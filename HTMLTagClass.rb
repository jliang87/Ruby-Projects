class Tag
	attr_reader :name
	attr_accessor :parent, :children, :end_tag

	def initialize(str)
		@name = str
		@parent = nil
		@children = []
		@end_tag = nil
	end

	def to_s
		name
	end
end

class HTML
	attr_reader :tags, :tags_names, :valid

	def initialize(str)
		@tags = []
		@tags_names = {} #can retrieve a Tag by name
		@valid = nil

		duplicate_stack = []

		#QUESTION IN INTERVIEW
		str.scan(/<\/?\w+\/?>/).inject do |m,o| #In all cases, m will be the parent, and o will be one of m's children
			unless tags_names.key? m
				t = Tag.new m
				tags.push t 
				tags_names[m] = t
			end
			
			if m == o and (m !~ /<\w+\/>/ and o !~ /<\w+\/>/) #For the case when a parent has a child with the same name. ie. <div><div>
				t = Tag.new o 
				tags.push t

				parent = tags_names[m] 
				duplicate_stack.push parent #saves the parent in a stack

				tags_names[o] = t #the tags_names hash keeps the child (latest occurence) in record

				tags_names[o].parent = parent #set child's parent variable to parent
				parent.children.push tags_names[o] #add child to one of parent's children 
			else
				t = Tag.new o 
				tags.push t
				tags_names[o] = t unless m == o and (m =~ /<\w+\/>/ and o =~ /<\w+\/>/) #the tags_names hash keeps the first occurence of a self-closing tag in record. ie. <li/><li/>

				unless m =~ /<\w+\/>/ or o.sub(/\//, '') == m #For cases other than ie. <li/><li/> and ie. <div></div>
					tags_names[o].parent = tags_names[m]
					tags_names[m].children.push tags_names[o]
				else
					tags_names[o].parent = tags_names[m].parent unless o =~ /<\/\w+>/ #an end_tag has no parent
					tags_names[m].parent.children.push tags_names[o] unless tags_names[m].parent.nil? or o =~ /<\/\w+>/ #children does not include end_tags

					if o.sub(/\//, '') == m
						tags_names[m].end_tag = tags_names[o]
					end
				end
			end

			if (m =~ /<\w+\/>/ or o.sub(/\//, '') == m) and !tags_names[m].parent.nil? #For cases such as ie. <li/><li/> or ie. <div></div> or ie. <div><div>
				if o =~ /<\/\w+>/ and !duplicate_stack.empty? and duplicate_stack.last.name == m #For cases specifically to ie. <div></div> and have duplicates
					t = tags_names[m]
					tags_names[m] = duplicate_stack.pop
					next t.parent.name #next m will be the parent tag with the same name
				else
					next tags_names[m].parent.name #next m will be the m's parent tag
				end
			end

			next o
		end
	end

	def print_formatted(x=tags.first, spacing=0)
		puts "print_formatted only works if the html is valid." unless valid?
		if valid?
			s = ''
			spacing.times { s += ' ' }
			puts s + x.name
			x.children.each { |n| print_formatted n, spacing+1 } unless x.children.empty?
			puts s + x.end_tag.name unless x.end_tag.nil?
		end
	end

	def print_original
		puts tags.map { |m| m.name }.join
	end

	def valid?
		valid = true
		if tags.first.name !~ /<\w+>/ #currently the script works only with a html with at least one non-self-closing tag 
			valid = false
		end
		tags.each do |x| 
			if x.end_tag.nil? 
				valid = false unless x.name =~ /<\w+\/>/ or x.name =~ /<\/\w+>/
			end
		end
		valid
	end
end


puts "test:"
html = HTML.new "<html><body><div><a></a><a></a><div><ul><li/><li/></ul></div></div></body></html>"
html.print_formatted
html.print_original
p html.valid?
puts

puts "test:"
html = HTML.new "<html><body><div><div><br/><br/><div></div></div><a></a><a></a><div><ul><li/><li/></ul></div></div></body></html>"
html.print_formatted
html.print_original
p html.valid?
puts

puts "test:"
html = HTML.new "<html><li/><li/><li/><li/><li/><li/><li/><li/></html>"
html.print_formatted
html.print_original
p html.valid?
puts

puts "test:"
html = HTML.new "<html><bo><div><ul><a></a><li/><li/></ul></div></body></html>" #<bo>
html.print_formatted
html.print_original
p html.valid?
puts

html = HTML.new "<html><body><div><ul><a><li/><li/></ul></div></body></html>" #missing </a>
html.print_formatted
html.print_original
p html.valid?
puts

puts "test:"
html = HTML.new "<li/><li/><li/><li/><li/><li/><li/><li/>"
html.print_formatted
html.print_original
p html.valid?
puts

puts "test:"
html = HTML.new "<html><li/><li/><li/><li/><li/><li/><li/><li/>"
html.print_formatted
html.print_original
p html.valid?
puts