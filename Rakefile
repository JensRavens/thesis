require "rubygems"
require "bundler"
Bundler.require(:default)

def root
  @root ||= File.dirname(__FILE__)
end

desc "updates the include file"
task :update do
  files = Dir
    .glob("pages/**/*.tex")
    .sort
    .map { |e| Pathname.new(e) }
    .reject { |e| e.basename.to_s.start_with? "_" }
    .map { |e| "\\input{./#{e.to_s}}" }
    .join("\n")
  File.write "pages/_all.tex", files
end

desc "compiles the files to finished html"
task compile: [:update] do
  `pdflatex thesis.tex`
end

task default: [:compile]
