#! /usr/bin/env ruby

require "bigdecimal"
require "active_support/all"

path = ARGV.first || (File.dirname(__FILE__) + "/data.txt")

class Document
  attr_reader :path
  attr_reader :file

  attr_reader :x_axis
  attr_reader :y_axis

  def initialize(path)
    @path = path
    @file = File.open path
  end

  def analyze
    move "x"
    @x_axis = read_numbers
    move "y"
    @y_axis = read_numbers
    move "profile", 1
    slice = read_many_numbers
    heatmap slice
  end

  def print_slice(slice)
    slice.each do |line|
      puts line.map(&:to_f).join(" ")
    end
  end

  def heatmap(slice)
    x_axis.each.with_index do |x, x_index|
      y_axis.each.with_index do |y, y_index|
        puts "#{x.to_f} #{y.to_f} #{slice[x_index][y_index].to_f}"
        puts "#{-x.to_f} #{y.to_f} #{slice[x_index][y_index].to_f}"
        puts "#{-x.to_f} #{-y.to_f} #{slice[x_index][y_index].to_f}"
        puts "#{x.to_f} #{-y.to_f} #{slice[x_index][y_index].to_f}"
      end
    end
  end

  # private

  def read_line
    file.gets.try :strip!
  end

  def read_numbers
    lines = []
    while line = read_line.presence
      lines.push number(line)
    end
    lines
  end

  def read_many_numbers
    lines = []
    while line = read_line.presence
      lines.push line.split(" ").map { |e| number(e) }
    end
    lines
  end

  def move(id, offset = 0)
    hits = 0
    file.rewind
    while line = read_line
      hits += 1 if line.start_with? id
      return if hits > offset
    end
  end

  def number(string)
    BigDecimal.new string
  end
end

document = Document.new(path)
document.analyze
