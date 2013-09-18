class String
  def is_positive_two_decimal_places_float?
    if self =~ /\A([1-9]+[0-9]*\.?[0-9]?[0-9]?|[0]?\.[0-9][0-9]?|[0]\.[0-9]?[0-9]?|[0])\Z/
    	true
    else
    	false
    end
  end

  def is_positive_int?
  	b = !!Integer(self) rescue false
    if b
    	if self.to_i < 0
    		false
    	else
    		true
    	end
    else
    	false
    end
  end

  def is_correct_base_price?
  	is_positive_two_decimal_places_float?
  end

  def to_money
  	sprintf '$%.2f', self.to_f
  end
end



class NuPack
	attr_reader :base_price, :flat_markup_price, :material_markup_price, :people_markup_price, :final_price, :people, :material

	FLAT_MARKUP=0.05
	PERSON_MARKUP=0.012
	PHARM_MARKUP=0.075
	FOOD_MARKUP=0.13
	ELEC_MARKUP=0.02
	OTHER_MARKUP=0
	MATERIALS=["Pharmaceuticals", "Food", "Electronics", "Others"]

	def initialize(base_price)
		raise "Invalid input" unless base_price.is_a? Float
		@base_price = base_price
		@flat_markup_price = (FLAT_MARKUP * base_price).round(2) + base_price
	end

	def add_people(people)
		raise "Invalid input" unless people.is_a?(Integer) && people >= 0
		@people = people
		@people_markup_price = (PERSON_MARKUP * flat_markup_price * people).round 2
	end

	def add_material(material)
		raise "Invalid input" unless material.is_a? Integer
		case material
		when 1
			@material_markup_price = PHARM_MARKUP * flat_markup_price
		when 2
			@material_markup_price = FOOD_MARKUP * flat_markup_price
		when 3
			@material_markup_price = ELEC_MARKUP * flat_markup_price
		when 4
			@material_markup_price = OTHER_MARKUP * flat_markup_price
		else
			raise "Invalid choice"
		end

		@material = MATERIALS[material-1]
		@material_markup_price = material_markup_price.round 2
	end

	def calculate_final_price
		@final_price = flat_markup_price + people_markup_price + material_markup_price
	end

	def self.for_testing_purpose
		np_obj = self.new "123".to_f
	end
end



