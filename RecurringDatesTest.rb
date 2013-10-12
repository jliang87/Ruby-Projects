require "./RecurringDates"
require 'minitest/autorun'

class RecurringDatesTest < MiniTest::Unit::TestCase
  def setup
    @a1 = recurringDates Date.new(2013, 6, 15), 7
    @a2 = recurringDates Date.new(2013, 1, 31), 1
    @a3 = recurringDates Date.new(2013, 1, 31), 12
  end

  def test_wrong_input_parameters
    assert_raises ArgumentError do
      recurringDates Date.new(2013, 2, 31), 7
    end

    assert_raises ArgumentError, RuntimeError do
      recurringDates 
    end

    assert_raises ArgumentError, RuntimeError do
      recurringDates Date.new(2013, 2, 1)
    end

    assert_raises RuntimeError do
      recurringDates Date.new(2013, 6, 30), 13
    end

    assert_raises RuntimeError do
      recurringDates Date.new(2013, 6, 30), 0
    end

    assert_raises RuntimeError do
      recurringDates Date.new(2013, 6, 30), -12
    end

    assert_raises RuntimeError do
      recurringDates Date.new(2013, 6, 30), "12"
    end
  end

  def test_2013615
    assert_equal @a1.first.to_s, Date.new(2013, 6, 15).to_s
    assert_equal @a1.first.day, @a1.last.day
    assert_equal @a1.size, 7
    assert @a1.is_a? Array
    @a1.each { |n| assert n.is_a? Date } 
    (1..@a1.size-1).each { |n| assert @a1[n] > @a1[n-1] } 
  end

  def test_2013131_1
    assert_equal @a2.size, 1
    assert_equal @a2.first.month, 1
  end

  def test_2013131_12
    assert_equal @a3.size, 12
    assert_equal @a3[1].to_s, Date.new(2013, 2, 28).to_s
    assert_equal @a3[3].to_s, Date.new(2013, 4, 30).to_s
    assert_equal @a3.first.year, @a3.last.year
    assert_equal @a3.last.day, 31
    assert_equal @a3.last.month, 12
    assert_equal (@a3.select { |n| n.day == 28}).size, 1
    assert_equal (@a3.select { |n| n.day == 30}).size, 4
    assert_equal (@a3.select { |n| n.day == 31}).size, 7
  end
end
