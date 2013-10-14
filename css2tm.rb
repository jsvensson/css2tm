require "rubygems"
require "bundler/setup"
Bundler.require :default

# Build hash list out of CSS declarations
def split_declarations(dec)
	dec = dec.split(/; ?/)
	list = {}
	dec.each do |d|
		pair = d.split(/: ?/)
		list[pair[0].to_sym] = pair[1]
	end
	list
end

# Set up args
infile = ARGV[0]
outfile = ARGV[1]

if !infile then
	puts "No input!"
	exit
end

parser = CssParser::Parser.new
parser.load_file!(infile)

theme = {
	settings: []
}

# Build theme settings
themename = split_declarations(parser.find_by_selector('#theme').first)
theme.merge!(themename)

settings = {}
settings[:settings] = split_declarations(parser.find_by_selector('#settings').first)
theme[:settings] << settings

parser.each_selector do |selector, declaration, specificity|
	next if (selector == '#theme' or selector == '#settings')

	h = split_declarations(declaration)

	# Build the selector hash
	selhash = {
		name: h[:name],
		scope: selector,
		settings: {}
	}

	h.delete(:name)  # We don't want it inside the settings key
	selhash[:settings] = h

	theme[:settings] << selhash

end

puts theme.to_plist
