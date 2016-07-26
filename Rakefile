require "rubygems"
require "bundler"
Bundler.require(:default)

def root
  File.dirname(__FILE__)
end

class Renderer
  def initialize
    renderer = Redcarpet::Render::HTML.new
    @markdown = Redcarpet::Markdown.new(renderer, extensions = {})
  end

  def render(content)
    @markdown.render(content)
  end
end

class Part
  attr_reader :path
  attr_accessor :renderer
  attr_reader :content

  def initialize(path)
    @path = path
    @renderer = Renderer.new
    @content = File.read @path
  end

  def render
    renderer.render content
  end
end

class Document
  attr_reader :root
  attr_accessor :parts
  attr_accessor :layout

  def initialize(root)
    @root = root
    @parts = Dir.glob("#{root}/pages/**/*.md").map { |e| Part.new e }
    @layout = File.read "#{root}/layout.html"
  end

  def render
    content = parts.map(&:render).join("\n")
    layout.sub "{{CONTENT}}", content
  end

  def save(path)
    FileUtils.mkdir_p "#{root}/output"
    File.write path, render
    File.write(File.dirname(path) + "/styles.css", styles)
  end

  def styles
    Sass.compile sass
  end

  def sass
    Dir
      .glob("#{root}/style/**/*.scss")
      .sort
      .map { |e| File.read e }
      .join("\n")
  end
end


desc "compiles the files to finished html"
task :compile do
  root = File.dirname(__FILE__)
  output = "#{root}/output/thesis.html"
  Document.new(root).save(output)
end

desc "compiles the project and outputs a pdf"
task pdf: :compile do
  `cd output && prince thesis.html`
  `open output/thesis.pdf`
end

task default: [:compile]
