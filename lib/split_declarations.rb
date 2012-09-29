module SplitDeclarations
	# Build hash list out of CSS declarations
	def self.split(dec)
		dec = dec.split(/; ?/)
		list = {}
		dec.each do |d|
			pair = d.split(/: ?/)
			list[pair[0].to_sym] = pair[1]
		end
		list
	end
end
