#! /usr/bin/env ruby

require "bigdecimal"
require "active_support/all"
# require "nmatrix"

root = File.dirname(File.expand_path('..', __FILE__))
path = ARGV.first || (root + "/data/data.txt")
name = File.basename path, ".txt"
radius = 570 * 0.5

output = ARGV.second || (root + "/output/#{name}")

class Document
  attr_reader :path
  attr_reader :file

  attr_reader :x_axis
  attr_reader :y_axis

  attr_reader :plane

  def initialize(path)
    @path = path
    @file = File.open path
  end

  def analyze
    # m = NMatrix::IO::Matlab::load_mat @path
    move "x"
    @x_axis = read_numbers
    move "y"
    @y_axis = read_numbers
    move "profile", 1
    @plane = read_many_numbers
  end

  def reference_line(slice = plane)
    lines = []
    x_axis.each.with_index do |x, x_index|
      lines << [x.to_f, slice[x_index].last.to_f]
      lines << [-x.to_f, slice[x_index].last.to_f]
    end
    lines.sort_by(&:first).map { |e| e.join(" ") }.join("\n")
  end

  def average(slice = plane)
    count = x_axis.length * y_axis.length
    sum = normalise(slice).flatten.sum
    sum / count
  end

  def extrapolate(slice = plane, radius)
    base_area = Math::PI * radius * radius * 0.25
    doc_area = area
    missing_area = base_area - doc_area
    (doc_area * average + missing_area * base_value) / base_area
  end

  def max(slice = plane)
    normalise(slice).flatten.max
  end

  def area
    x_span * y_span
  end

  def x_span
    (x_axis.max - x_axis.min).abs
  end

  def y_span
    (y_axis.max - y_axis.min).abs
  end

  def points_per_area
    (x_axis.length * y_axis.length) / area
  end

  def base_value(slice = plane)
    slice.flatten.min
  end

  def normalise(slice)
    slice
  end

  def z_axis(slice = plane)
    normalise(slice).flatten
  end

  def print_slice(slice)
    slice.each do |line|
      puts line.map(&:to_f).join(" ")
    end
  end

  def heatmap(slice = plane)
    lines = []
    x_axis.each.with_index do |x, x_index|
      y_axis.each.with_index do |y, y_index|
        lines << "#{x.to_f} #{y.to_f} #{slice[x_index][y_index].to_f}"
        lines << "#{-x.to_f} #{y.to_f} #{slice[x_index][y_index].to_f}"
        lines << "#{-x.to_f} #{-y.to_f} #{slice[x_index][y_index].to_f}"
        lines << "#{x.to_f} #{-y.to_f} #{slice[x_index][y_index].to_f}"
      end
    end
    lines.join("\n")
  end

  def csv(slice = plane)
    lines = []
    x_axis.each.with_index do |x, x_index|
      line = []
      y_axis.each.with_index do |y, y_index|
        line << slice[x_index][y_index].to_f
      end
      lines << line.join(";")
    end
    lines.join("\n").gsub(".", ",")
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

def gnu_file_heatmap(path, x:[-400, 400], y:[-400, 400], z:[0, 3], average: "")
  x_max = [x.max.abs, x.min.abs].max
  y_max = [y.max.abs, y.min.abs].max
  max = [x_max, y_max].max
  <<-END
reset
set ticslevel 0
set term png
set view map
set dgrid3d #{x.length*2}, #{y.length*2}
set xrange [#{-max}:#{max}]
set yrange [#{-max}:#{max}]
set cbrange [#{z.min}:#{z.max}]
set title "#{average}"
set xlabel "nm"
set ylabel "nm"
set size square
set palette defined (0 0 0 0.5, 1 0 0 1, 2 0 0.5 1, 3 0 1 1, 4 0.5 1 0.5, 5 1 1 0, 6 1 0.5 0, 7 1 0 0, 8 0.5 0 0)
splot "#{path}" using 1:2:3 with pm3d
  END
end

def gnu_file_line(path)
  <<-END
reset
set term png
plot "#{path}" with linespoints
  END
end

puts "Reading document at #{path}"
document = Document.new(path)
document.analyze

gnu_file_path = output + ".gnu"
gnu_reference_file_path = output + "_reference" + ".gnu"
data_file_path = output + ".dat"
image_file_path = output + ".png"
reference_image_file_path = output + "_reference" + ".png"
reference_file_path = output + "_reference" + ".dat"
puts "Writing reference line"
File.write reference_file_path, document.reference_line
puts "Writing heatmap data"
File.write data_file_path, document.heatmap
puts "Writing gnu files"
File.write gnu_file_path, gnu_file_heatmap(data_file_path, x: document.x_axis, y: document.y_axis, average: document.extrapolate(radius).round(5))
File.write gnu_reference_file_path, gnu_file_line(reference_file_path)
puts "Plotting"
`gnuplot -c #{gnu_file_path} > #{image_file_path}`
`gnuplot -c #{gnu_reference_file_path} > #{reference_image_file_path}`
