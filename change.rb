module Enumerable
	@@permutations_cache = {}

	def min_by
		pairs = map{|x| [yield(x), x]} #http://stackoverflow.com/questions/14517046/what-do-the-square-brackets-mean-here
		min_pair = pairs.min {|a,b| a.first <=> b.first} # http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator
		min_pair.last
		#http://en.wikipedia.org/wiki/Schwartzian_transform
	end

	#inject(initial, sym) → obj click to toggle source
	#inject(sym) → obj
	#inject(initial) {| memo, obj | block } → obj
	#inject {| memo, obj | block } → obj
	#inject -> also reduce/fold
	def sum
		inject(0) {|memo,a| memo+a } rescue nil
	end

	def permutations
		#dup prevents accidental changes
		return @@permutations_cache[self].dup if @@permutations_cache[self]
		return [[]] if empty?
		others = rest.permutations
		( @@permutations_cache[self.dup] = (others.map{|o| [first]+o} + others).uniq).dup #self.dup because contents of self keeps changing with every execution 
	end

	def rest
		return [] if empty?
		self[1..-1]
	end
end


class Prices
	def initialize(*data)
		@data = data
	end

	def get
		@data[rand(@data.size)]
	end

	def each(count)
		count.times {yield get} # prices.each(4) {|price| price_list.push price }, price is from 'get'
	end
end

price_list=IO.readlines("prices.txt").map{|price| price.to_i } # http://stackoverflow.com/questions/9429034/what-is-the-difference-between-map-each-and-collect
prices = Prices.new(*price_list)


#cm = ChangeMaker.new(1, 5, 10, 25)
class ChangeMaker
	def initialize(*coins)
		raise "ChangeMaker must have a coin of denomination 1" unless coins.include? 1
		@coins = coins.sort
		@cache = {}
	end

	#think amount=6 and coins=3
	#http://stackoverflow.com/questions/6164629/dynamic-programming-and-memoization-bottom-up-vs-top-down-approaches
	def change(amount)
		return @cache[amount] if @cache[amount]
		return [] if amount == 0

		possible = @coins.find_all {|coin| coin <= amount}
		best = possible.min_by{|coin| change(amount-coin).size}

		@cache[amount] = [best, *change(amount-best)].sort
	end
end

#customer = Customer.new([1, 5, 10, 25], 1, 1, 1, 5, 25)
class Customer
	attr_reader :denoms, :coins

	def initialize(denoms, *coins) 
		@coins = coins.sort
		@denoms = denoms.sort

		coins.each {|denom| check_denom denom}

		@cm = ChangeMaker.new *@denoms
		check_optimal_start
	end

	def check_denom(denom)
		raise "Bad denomination #{denom}" unless denoms.include? (denom)
	end

	def check_optimal_start
		optimal = @cm.change amount
		if coins.size != optimal.size
			raise "Bad starting state #{coins.inspect} should be #{optimal.inspect}"
		end
	end

	def amount
		coins.sum
	end

	def number
		coins.size
	end

	#for testing
	def self.us(*coins)
		self.new([1,5,10,25], *coins)
	end

	def ==(other)
		return false unless other.kind_of?(Customer)
		return false unless coins == other.coins
		return false unless denoms == other.denoms
		true
	end

	def to_s
		dollars = sprintf("$%.2f", amount.to_f/100)
		"#{dollars} (#{coins.join(', ')})"
	end

	def take!(coin)
		coins.push coin
		coins.sort!
		self
	end

	def give!(coin)
		raise "Don't have #{coin} to give" unless coins.include? coin
		coins.delete_at coins.index coin
		self
	end

	def pay!(bill)
		give = coins.permutations.min_by do |perm|
			amount = (perm.sum - bill)%100
			change = @cm.change amount
			number - perm.size + change.size
		end

		amount = (give.sum - bill)%100
		get = @cm.change amount

		give.each {|d| give! d}
		get.each {|d| take! d}
		self
	end
end

# #simulation
# c = Customer.us 1,1,5,10,25,25,25
# puts c.coins.inspect
# p = prices.get
# puts p
# c.pay! p
# puts c.coins.inspect
































