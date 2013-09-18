require "./NuPack"

def main
	puts "Please enter the base price of the project: "

	while(true)
		base_price = STDIN.gets.chomp
		if base_price.is_correct_base_price?
			np_obj = NuPack.new base_price.to_f
			break
		else 
			puts "The input must be a positive number with at most two decimal places. Please try again:"
		end	
	end 

	puts "\nPlease enter the number of people for this job:"

	while(true)
		people = STDIN.gets.chomp
		if people.is_positive_int?
			np_obj.add_people people.to_i
			break
		else
			puts "The input must be a positive integer number. Please try again:"
		end
	end

	puts "\nPlease enter the number corresponding to the material used:"
	puts "1 - Pharmaceuticals  2 - Food  3 - Electronics  4 - Others"

	while(true)
		material = STDIN.gets.chomp.to_i
		if (1..4).to_a.include? material
			np_obj.add_material material
			break
		else
			puts "The input must be a number from 1 to 4. Please try again:"
		end
	end

	puts
	np_obj.calculate_final_price

	puts "Base Price: " + np_obj.base_price.to_s.to_money
	puts "Price after flat markup: " + np_obj.flat_markup_price.to_s.to_money
	puts np_obj.people.to_s + (np_obj.people > 1 ? " people: " : " person: ") + np_obj.people_markup_price.to_s.to_money
	puts np_obj.material + ": " + np_obj.material_markup_price.to_s.to_money
	puts "Total: " + np_obj.final_price.to_s.to_money
end


main
