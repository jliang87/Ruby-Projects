require "minitest/autorun"
require "./NuPack"


describe "String Methods Unit Tests" do
	describe "Is Price in Correct Format of a Positive Float with Maximum Two Decimal Places" do
	  it "must be true" do
	  	s = "0.2"
	    s.is_correct_base_price?.must_equal true

	    s = ".2"
	    s.is_correct_base_price?.must_equal true

	    s = ".12"
	    s.is_correct_base_price?.must_equal true

	    s = "2132132.2"
	    s.is_correct_base_price?.must_equal true

	    s = "31432"
	    s.is_correct_base_price?.must_equal true

	    s = "0"
	    s.is_correct_base_price?.must_equal true

	    s = "0.62"
	    s.is_correct_base_price?.must_equal true

	    s = "0."
	    s.is_correct_base_price?.must_equal true

	    s = "99912."
	    s.is_correct_base_price?.must_equal true

	    s = "312.12"
	    s.is_correct_base_price?.must_equal true

	    s = "7.00"
	    s.is_correct_base_price?.must_equal true

	    s = "312."
	    s.is_correct_base_price?.must_equal true

	    s = "0.00"
	    s.is_correct_base_price?.must_equal true
	  end

	  it "must be false" do
	  	s = "."
	    s.is_correct_base_price?.must_equal false

	  	s = "0.2123"
	    s.is_correct_base_price?.must_equal false

	    s = "00.2"
	    s.is_correct_base_price?.must_equal false

	    s = "0000.213122"
	    s.is_correct_base_price?.must_equal false

	    s = ".123"
	    s.is_correct_base_price?.must_equal false

	    s = "000021321"
	    s.is_correct_base_price?.must_equal false

	    s = "02"
	    s.is_correct_base_price?.must_equal false

	    s = "0123"
	    s.is_correct_base_price?.must_equal false

	    s = "09129"
	    s.is_correct_base_price?.must_equal false

	    s = "0009.00"
	    s.is_correct_base_price?.must_equal false

	    s = "00.00"
	    s.is_correct_base_price?.must_equal false

	    s = "00094324.0"
	    s.is_correct_base_price?.must_equal false

	    s = "-9009"
	    s.is_correct_base_price?.must_equal false

	    s = "09009.as"
	    s.is_correct_base_price?.must_equal false

	    s = "435dfas"
	    s.is_correct_base_price?.must_equal false

	    s = "09009.00"
	    s.is_correct_base_price?.must_equal false

	    s = "123ads0"
	    s.is_correct_base_price?.must_equal false

	    s = "12.546"
	    s.is_correct_base_price?.must_equal false

	    s = "000000"
	    s.is_correct_base_price?.must_equal false

	    s = "0.000"
	    s.is_correct_base_price?.must_equal false

	    s = "9.000"
	    s.is_correct_base_price?.must_equal false

	    s = "000"
	    s.is_correct_base_price?.must_equal false

	    s = "00"
	    s.is_correct_base_price?.must_equal false

	    s = "1.000"
	    s.is_correct_base_price?.must_equal false

	    s = "-0"
	    s.is_correct_base_price?.must_equal false

	    s = "-"
	    s.is_correct_base_price?.must_equal false

	    s = ""
	    s.is_correct_base_price?.must_equal false

	    s = "asdas.asd"
	    s.is_correct_base_price?.must_equal false

	    s = "asdas.12"
	    s.is_correct_base_price?.must_equal false

	    s = "934.324"
	    s.is_correct_base_price?.must_equal false

	    s = "+934.34"
	    s.is_correct_base_price?.must_equal false

	    s = "dsf"
	    s.is_correct_base_price?.must_equal false

	    s = "213..21"
	    s.is_correct_base_price?.must_equal false

	    s = ".32.21"
	    s.is_correct_base_price?.must_equal false

	    s = "..23"
	    s.is_correct_base_price?.must_equal false

	    s = "0..98"
	    s.is_correct_base_price?.must_equal false
	  end
	end

	describe "Is the Number a Positive Integer" do
	  it "must be true" do
	  	s = "1"
	    s.is_positive_int?.must_equal true

	    s = "453534"
	    s.is_positive_int?.must_equal true

	    s = "0"
	    s.is_positive_int?.must_equal true

	    s = "+123"
	    s.is_positive_int?.must_equal true
	  end

	  it "must be false" do
	  	s = "1.12"
	    s.is_positive_int?.must_equal false

	    s = "12ad"
	    s.is_positive_int?.must_equal false

	    s = "-213"
	    s.is_positive_int?.must_equal false

	    s = ""
	    s.is_positive_int?.must_equal false

	    s = "0.02"
	    s.is_positive_int?.must_equal false

	    s = "asd"
	    s.is_positive_int?.must_equal false

	    s = "a"
	    s.is_positive_int?.must_equal false

	    s = "$#!23"
	    s.is_positive_int?.must_equal false

	    s = ".72"
	    s.is_positive_int?.must_equal false
	  end
	end

	describe "Is Money Format Conversion Working" do
	  it "must equal" do
	  	s = "2.52"
	    s.to_money.must_equal "$2.52"

	  	s = "252"
	    s.to_money.must_equal "$252.00"

	    s = "252.9"
	    s.to_money.must_equal "$252.90"

	    s = ".959"
	    s.to_money.must_equal "$0.96"
	  end

	  it "must not equal" do
	    s = "0..959"
	    s.to_money.wont_equal "$0.96"

	    s = "..96"
	    s.to_money.wont_equal "$0.96"
	  end
	end
end


describe "NuPack Unit Tests" do
	before do
		@np_obj = NuPack.for_testing_purpose
	end

	describe "Constructor Takes One Float as Argument" do
	  it "must raise exception" do
	  	-> {NuPack.new "asdsad"}.must_raise RuntimeError
	  	-> {NuPack.new 213}.must_raise RuntimeError
	  end
	end

	describe "Method add_people Takes One Positive Integer as Argument" do
	  it "must raise exception" do
	  	-> {@np_obj.add_people "12"}.must_raise RuntimeError
	  	-> {@np_obj.add_people 12.12}.must_raise RuntimeError
	  	-> {@np_obj.add_people -2}.must_raise RuntimeError
	  end
	end

	describe "Method add_material Takes One Integer Ranging from 1 to 4 as Argument" do
	  it "must raise exception" do
	  	-> {@np_obj.add_material "12"}.must_raise RuntimeError
	  	-> {@np_obj.add_material 0.9}.must_raise RuntimeError
	  	e = -> {@np_obj.add_material 5}.must_raise RuntimeError
	  	e.message.must_match /Invalid choice/
	  	e = -> {@np_obj.add_material -3}.must_raise RuntimeError
	  	e.message.must_match /Invalid choice/
	  end
	end
end


#Simulate NuPackRunner.rb
describe "NuPack Integration Tests" do
	describe "First Test" do
	  it "must pass" do
	  	if "1299.99".is_correct_base_price?
	  		@np_obj = NuPack.new 1299.99
	  	end

	  	@np_obj.wont_be_nil

	  	if "3".is_positive_int?
	  		@np_obj.add_people 3
	  	end

	  	@np_obj.add_material 2

	  	@np_obj.calculate_final_price

	  	@np_obj.final_price.to_s.to_money.must_equal "$1591.58"
	  end
	end

	describe "Second Test" do
	  it "must pass" do
	  	if "5432".is_correct_base_price?
	  		@np_obj = NuPack.new 5432.to_f
	  	end

	  	@np_obj.wont_be_nil

	  	if "1".is_positive_int?
	  		@np_obj.add_people 1
	  	end

	  	@np_obj.add_material 1

	  	@np_obj.material.must_equal "Pharmaceuticals"
	  	@np_obj.calculate_final_price

	  	@np_obj.final_price.to_s.to_money.must_equal "$6199.81"
	  end
	end

	describe "Third Test" do
	  it "must pass" do
	  	if "12456.95".is_correct_base_price?
	  		@np_obj = NuPack.new 12456.95
	  	end

	  	@np_obj.wont_be_nil

	  	if "4".is_positive_int?
	  		@np_obj.add_people 4
	  	end

	  	@np_obj.add_material 4

			@np_obj.material.must_equal "Others"
	  	@np_obj.calculate_final_price

	  	@np_obj.final_price.to_s.to_money.must_equal "$13707.63"
	  end
	end

	describe "Fourth Test" do
	  it "must pass" do
	  	if ".".is_correct_base_price?
	  		@np_obj = NuPack.new 12456.95
	  	elsif ".0".is_correct_base_price?
	  		@np_obj = NuPack.new ".0".to_f
	  	end

	  	@np_obj.wont_be_nil

	  	if "4".is_positive_int?
	  		@np_obj.add_people 4
	  	end

	  	if !"-3".is_positive_int?
	  		@np_obj.add_material 3
	  	end

	  	@np_obj.calculate_final_price

	  	@np_obj.material.must_equal "Electronics"
	  	@np_obj.people.must_equal 4

	  	@np_obj.final_price.to_s.to_money.must_equal "$0.00"
	  end
	end
end
