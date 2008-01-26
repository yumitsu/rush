module Rush
	module Commands
		def entries
			raise "must define me in class mixed in to for command use"
		end

		def vi(*args)
			names = entries.map { |f| f.full_path }.join(' ')
			system "vim #{names} #{args.join(' ')}"
		end

		def search(pattern)
			results = {}
			entries.each do |entry|
				if !entry.directory? and m = entry.contents.match(pattern)
					results[entry] = m
				end
			end
			results
		end

		def replace!(pattern, with_text)
			entries.each do |entry|
				entry.replace!(pattern, with_text) unless entry.directory?
			end
		end
	end
end
