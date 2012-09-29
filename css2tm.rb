require "rubygems"
require "bundler/setup"
Bundler.require :default

Dir["./lib/*.rb"].each { |f| require f }

parser = CssParser::Parser.new

parser.load_file!('tests/kestrel.css')

theme = {
	settings: []
}

# Build theme settings
themename = SplitDeclarations.split(parser.find_by_selector('#theme').first)
theme.merge!(themename)

settings = {}
settings[:settings] = SplitDeclarations.split(parser.find_by_selector('#settings').first)
theme[:settings] << settings

parser.each_selector do |selector, declaration, specificity|
	next if (selector == '#theme' or selector == '#settings')

	h = SplitDeclarations.split(declaration)

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

#puts theme
puts theme.to_plist
