class Shape
	attr_reader :name

	def initialize(name)
		@name = name
	end
end

class Polygon < Shape
	attr_reader :sides, :side_length

	def initialize(name, sides, side_length)
		super name
		@sides = sides
		@side_length = side_length
	end
end

class Pentagon < Polygon
	def initialize(side_length)
		super "pentagon", 5, side_length 
	end

	def perimeter
		(side_length * 5).round 2
	end

	def area
		(1.72 * side_length * side_length).round 2
	end
end

class Triangle < Polygon
	def initialize(side_length)
		super "triangle", 3, side_length 
	end

	def perimeter
		(side_length * 3).round 2
	end

	def area
		(Math.sqrt(3) / 4 * side_length * side_length).round 2
	end
end

class Square < Polygon
	def initialize(side_length)
		super "square", 4, side_length 
	end

	def perimeter
		(side_length * 4).round 2
	end

	def area
		(side_length * side_length).round 2
	end
end

class Circle < Shape
	attr_reader :radius

	def initialize(radius)
		super "circle"
		@radius = radius
	end

	def perimeter
		(radius * 2 * 3.1416).round 2
	end

	def area
		(3.1416 * radius * radius).round 2
	end
end


def main 
	unless ARGV[0]
	puts "Usage: ruby Shapes.rb <filename.ext>" 
	exit
	end

	unless File.exist?(ARGV[0])
	puts "The file could not be found"
	exit
	end

	shapes_from_file=IO.readlines(ARGV[0]).map{|line| line.split(',').each {|x| x.chomp!} }
	puts shapes_from_file.inspect
	shapes=[]
	shapes_from_file.each do |shape|
		case shape.first
			when "triangle"
				shapes.push Triangle.new shape[1].to_f
			when "circle"
				shapes.push Circle.new shape[1].to_f
			when "pentagon"
				shapes.push Pentagon.new shape[1].to_f
			when "square"
				shapes.push Square.new shape[1].to_f
			else
				raise "Invalid shape!"
			end 
	end

	shapes.each do |shape|
		if shape.is_a? Polygon
			puts "A " + shape.name + " with side length " + shape.side_length.to_s + " u has a perimeter of " + shape.perimeter.to_s + " u and an area of " + shape.area.to_s + " u^2"
		else
			puts "A " + shape.name + " with radius " + shape.radius.to_s + " u has a perimeter of " + shape.perimeter.to_s + " u and an area of " + shape.area.to_s + " u^2"	
		end
	end
end








