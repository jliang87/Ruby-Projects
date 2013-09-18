require "./Shapes"
require 'minitest/autorun'

class ShapesTest < MiniTest::Unit::TestCase
  def setup
    @triangle = Triangle.new 3
    @circle = Circle.new 4
    @square = Square.new 5
    @pentagon = Pentagon.new 6
  end

  def test_for_triangle
    assert_equal "triangle", @triangle.name 
    assert_equal 3, @triangle.sides
    assert_equal 3, @triangle.side_length
    assert_equal 3.90, @triangle.area
    assert_equal 9, @triangle.perimeter
    assert @triangle.is_a? Polygon
    refute @triangle.respond_to? :radius
  end

  def test_for_circle
    assert_equal "circle", @circle.name 
    assert_equal 4, @circle.radius
    assert_equal 50.27, @circle.area
    assert_equal 25.13, @circle.perimeter
    refute @circle.is_a? Polygon
    refute @circle.respond_to? :side_length
    refute @circle.respond_to? :sides
  end

   def test_for_square
    assert_equal "square", @square.name 
    assert_equal 4, @square.sides
    assert_equal 5, @square.side_length
    assert_equal 25, @square.area
    assert_equal 20, @square.perimeter
    assert @square.is_a? Polygon
    refute @square.respond_to? :radius
   end

   def test_for_pentagon
    assert_equal "pentagon", @pentagon.name 
    assert_equal 5, @pentagon.sides
    assert_equal 6, @pentagon.side_length
    assert_equal 61.92, @pentagon.area
    assert_equal 30, @pentagon.perimeter
    assert @pentagon.is_a? Polygon
    refute @pentagon.respond_to? :radius
   end
end