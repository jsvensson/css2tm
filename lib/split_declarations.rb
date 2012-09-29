module SplitDeclarations
	def self.split(dec)
		dec = dec.split(/; ?/)
		list = {}
		dec.each do |d|
			pair = d.split(/: ?/)
			list[pair[0]] = pair[1]
		end
		list
	end
end
