require "rubygems"
require "bundler/setup"
Bundler.require :default

Dir["./lib/*.rb"].each { |f| require f }

parser = CssParser::Parser.new

parser.load_file!('tests/test.css')

parser.each_selector do |selector, declaration, specificity|
	puts selector

	hash = SplitDeclarations.split(declaration)
	hash['scope'] = selector
	puts hash

	puts ThemeBlock.create(hash)
end

