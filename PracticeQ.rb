def find_ngram(text, ngram_length)
  # Write your code here
  # To print results to the standard output you can use puts
  # Example puts "Hello world!"
  ngram = []
  space = false
  str = ""
  arr = text.split(//)

  for i in 0..arr.length-1
      for j in i..i+(ngram_length-1)
      	if arr[j] == ' ' || arr[j] == nil
      		space = true
      		break
      	else
      		str += arr[j]
   		  end
      end

      unless space 
      	ngram.push str
  	  end

      space = false
      str = ""
  end

  freq = ngram.inject(Hash.new(0)){ |f,o| f[o] += 1; f }
  sorted = freq.sort_by {|x,y| [y,x]}
 	
 	puts sorted.last[0]
end

# find_ngram("aaaab a0a baaab c", 3)

# def findsum (arr, sum)
	
# 	less = []
# 	result = []

# 	for i in 0..arr.length-1
# 		if arr[i] <= sum
# 			less.push arr[i]
# 		end
# 	end
# 	less = less.sort
# 	# puts less

# 	i = 0
# 	j = less.length - 1 

# 	while (i < j)
# 		if less[i] + less[j] < sum
# 			i+=1 # no ++ in ruby!!!
# 		elsif less[i] + less[j] > sum
# 			j-=1
# 		elsif less[i] + less[j] == sum
# 			result.push less[i]
# 			result.push less[j]
# 			# puts result
# 			return
# 		end
# 	end

# 	result
# end

def findSum(array)
  h = {}
  result = []
  array.each do |n|
    i = 10 - n
    if h.key? i
      result.push [n,i]
    else
      h[n] = i
    end
  end
  result
end

a = [2, 213, 2, 123, 123, 34, 34, 5, 32, 10 ,3, 123, 3, 3,5, 324, 12, 7 ,3, 8]

# p findsum(a, 10)
# p findSum(a)
 # find_ngram("aaaab a0a baaab c", 3)
 # find_ngram("biu biu zii zii hai hai hai zii", 3)


 def test

 	sum = 0

 	for i in (0...5)
 		sum += i
 	end

 	puts sum

 end

def is_palindrome? (sentence)
	raise ArgumentError.new('expected string') unless sentence.is_a?(String)
	safe_sentence = sentence.gsub(/\W+/, '').downcase
	puts safe_sentence
	return (safe_sentence = safe_sentence.reverse)
end

a = [2, 213, 90]

def average(array)
  raise ArgumentError.new('expected array') unless array.is_a?(Array)
  sum = 0
  array.each { |element|
    raise ArgumentError.new('element is not Integer') unless element.is_a?(Integer)
    sum += element
  }
  return (sum.to_f / array.length).ceil
end

def some_method(value)
  puts value
  if value == 0
    return 0
  else
    return (value % 2) + some_method(value >> 1)
  end
end

#puts some_method 1362434329

#0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55

def getChange (total)

  if total%5 != 0
    puts 'no change'
    return
  end

  q = 13
  d = 5
  n = 9

  change_g = false

  for i in (0..total/25).to_a.reverse
    if i <= q && !change_g
      a_less_q = total - i*25

      for j in (0..a_less_q/10).to_a.reverse
        if j <= d && !change_g
          a_less_d = a_less_q - j*10

          for k in (0..a_less_d/5).to_a.reverse
            if k <= n && !change_g

              a_less_n = a_less_d - k*5

              if a_less_n == 0
                puts i.to_s + " quarters " + j.to_s + " dimes " + k.to_s + " nickles " + "are given out"
                change_g = true
              end

            end
          end

        end
      end

    end
  end

end



def findsumofmultiplesofthreeandfive (value)

  sum = 0

  1.upto(value-1) do |x|
    if x%3 == 0 || x%5 == 0
      sum+=x
    end
  end

  puts sum 
end


def stringpermutation(str1, str2)

  if str1.length != str2.length
    puts "false"
  else
    tmp1 = str1.chars.sort_by { |x| x.downcase } .join
    tmp2 = str2.chars.sort_by { |x| x.downcase } .join
    if tmp1 == tmp2
      puts 'true' 
    else
      puts 'false'
    end
  end

end

def isSubString?(str, substr)
  r = Regexp.new "#{substr}"
  if str =~ r
    true
  else
    false
  end
end

# p isSubString? "good boy", "good"
module Try
  def self.included(base)
    base.instance_eval do
      def crazy
        p "wow" 
      end
    end
  end
end

class Calculator

  include Try

  class << self
    def evaluate(&script)
      self.new.instance_eval(&script)
    end
  end

  def multiply(arg)
    eval arg
  end

  def two(arg=nil)
    "2#{arg}"
  end

  def times(arg)
    " * #{arg}"
  end
end

p Calculator.evaluate { multiply two times two }
Calculator.crazy
