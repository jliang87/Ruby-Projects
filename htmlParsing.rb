def printHTML(s)
	a = s.split('><')
	a.first.sub! '<', ''
	a.last.sub! '>', ''
	raise "Bad input!" if a != a.each {|x| x.sub! '/',''}.reverse

	c = (a.size-1)/2

	for i in 0..c
		x = ''
		i.times { x += ' ' }
		puts x + '<' + a[i] + '>'
	end

	for i in c+1..a.size-1
		x = ''
		(a.size-1-i).times { x += ' ' }
		puts x + '</' + a[i] + '>'
	end
end

def printTags(a, n=0)
	raise "Bad input!" if !a.is_a? Array
	x = ''
	if n < a.size
		raise "Bad input!" if !a[n].is_a? String
		n.times {x += ' '}
		puts x+'<'+a[n]+'>'
		printTags a, n+1

		puts x+'</'+a[n]+'>'
	end
end

printHTML "<html><body><div><a></a></div></body></html>"

a = ['a','b','c','d','e','f']
printTags a
