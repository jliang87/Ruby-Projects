# To run the code, simply do 'ruby Dijkstra.rb routes.in'

require 'minitest/autorun'

class Node 
	attr_reader :name

	def initialize(name)
		raise "Wrong argument" unless name.is_a? String and name.size == 1
		@name = name
	end

	def to_s
		name
	end
end

class Edge
	attr_reader :start, :stop, :distance

	def initialize(n1, n2, weight)
		raise "Wrong arguments" unless n1.is_a? Node and n2.is_a? Node and weight.is_a? Integer and weight > 0
		@start = n1
		@stop = n2
		@distance = weight
	end

	def to_s
		start.name + "->" + stop.name
	end
end

class Graph
	attr_reader :edges, :nodes, :adjacency_list

	def initialize
		@edges = {}
		@nodes = {}
		@adjacency_list = {}
	end

	def addEdge(e)
		raise "Wrong argument" unless e.is_a? Edge
		unless edges.key? "#{e.start}#{e.stop}"
			edges["#{e.start}#{e.stop}"] = e
			nodes["#{e.start}"] = e.start unless nodes.key? "#{e.start}"
			nodes["#{e.stop}"] = e.stop unless nodes.key? "#{e.stop}"
			adjacency_list["#{e.start}"] = [] unless adjacency_list.key? "#{e.start}"
			adjacency_list["#{e.start}"].push "#{e.stop}"
		end
	end 

	def getDistance(route)
		raise "Wrong argument" unless route.is_a? String
		
		if route.size > 1
			begin
				d = edges[route[0..1]].distance
				r = d+getDistance(route[1..-1])
			rescue  
				"NO SUCH ROUTE"
			end
		else
			0
		end
	end

	def DFS(route, size, tempHold, results)
  	raise "Wrong arguments" unless route.is_a? String and route.size == 2 and size.is_a? Integer and tempHold.is_a? Array and results.is_a? Array
  	a = route.split ''
  	start = a[0]
  	stop = a[1]
  	if !nodes.key? start or !nodes.key? stop
  		puts "No routes"
  		return nil
  	end

  	tempHold.push start

  	a = adjacency_list[start]
  	a.each do |n| 
  		if n == stop and tempHold.size == size - 1
  			results.push tempHold.dup
  			results.last.push n
			elsif tempHold.size >= size
				return
			else
				DFS(n+stop, size, tempHold, results)
				tempHold.pop
			end
  	end

  	results.map{ |n| n.join }
  end

  def DFS_max(route, size, tempHold, results)
  	raise "Wrong arguments" unless route.is_a? String and route.size == 2 and size.is_a? Integer and tempHold.is_a? Array and results.is_a? Array
  	a = route.split ''
  	start = a[0]
  	stop = a[1]
  	if !nodes.key? start or !nodes.key? stop
  		puts "No routes"
  		return nil
  	end

  	tempHold.push start

  	a = adjacency_list[start]
  	a.each do |n| 
  		if tempHold.size < size
  			if n == stop 
	  			results.push tempHold.dup
  				results.last.push n
  			end

  			DFS_max(n+stop, size, tempHold, results)
  			tempHold.pop
			else
				return
			end
  	end

  	results.map{ |n| n.join }
  end

  def DFS_Weighted_max(route, size, tempHold, results)
  	raise "Wrong arguments" unless route.is_a? String and route.size == 2 and size.is_a? Integer and tempHold.is_a? Array and results.is_a? Array
  	a = route.split ''
  	start = a[0]
  	stop = a[1]
  	if !nodes.key? start or !nodes.key? stop
  		puts "No routes"
  		return nil
  	end

  	tempHold.push start

  	a = adjacency_list[start]
  	a.each do |n|
  		totalCurrentDistance = getDistance tempHold.join

  		if totalCurrentDistance + edges[start+n].distance <= size
  			if n == stop 
	  			results.push tempHold.dup
  				results.last.push n
	  		end

  			DFS_Weighted_max(n+stop, size, tempHold, results)
				tempHold.pop
			else
				return
			end
  	end

  	results.map{ |n| n.join }
  end

  def Dijkstra(route)
  	raise "Wrong arguments" unless route.is_a? String and route.size == 2
  	a = route.split ''
  	start = a[0]
  	stop = a[1]
  	if !nodes.key? start or !nodes.key? stop
  		puts "No routes"
  		return nil
  	end

 		untravelledNodes = nodes.keys
    shortestDistanceToNode = {}
    nodes.each_key { |k| k == start ? shortestDistanceToNode[k] = 0 : shortestDistanceToNode[k] = Float::INFINITY } 
  
    while !untravelledNodes.empty?
    	#Acts like priority queue
      h = untravelledNodes.inject({}){ |m,o| m[o] = shortestDistanceToNode[o]; m }
      a = h.sort_by { |x,y| y }
      nearestNode = a.first.first

      #Super directed graph, even the distance of A->A cannot be 0!
      if nearestNode == stop and shortestDistanceToNode[stop] != 0
        return shortestDistanceToNode[stop]
      end

      neighbors = adjacency_list[nearestNode]
      neighbors.each do |n|
        cumulativeDistance = shortestDistanceToNode[nearestNode] + edges[nearestNode+n].distance
        if cumulativeDistance < shortestDistanceToNode[n]
          shortestDistanceToNode[n] = cumulativeDistance
        end
      end

      if nearestNode == stop
      	#For being a super directed graph
        shortestDistanceToNode[nearestNode] = Float::INFINITY
      else
        untravelledNodes.delete nearestNode
      end
    end

    puts "No route"
    return nil
  end
end

class Runner < MiniTest::Unit::TestCase
	def tests
		unless ARGV[0]
			puts "\nYou need to include a file."
			puts "Usage: ruby DirectedGraph.rb FileName" 
			exit
		end

		File.open(ARGV[0], "r").each_line do |line|
		  if line =~ /^Graph:/
		  	g = Graph.new

		  	routes = line.split(": ")[1].split(", ")
		  	routes.each do |r|
		  		raise "Wrong format" unless r.size == 3
		  		a = r.split ''
	  			g.addEdge Edge.new Node.new(a[0]), Node.new(a[1]), a[2].to_i 
		  	end

        # The distance of the route
				assert_equal g.getDistance("ABC"), 9
				assert_equal g.getDistance("AD"), 5
				assert_equal g.getDistance("ADC"), 13
				assert_equal g.getDistance("AEBCD"), 22
		  	assert_equal g.getDistance("AED"), "NO SUCH ROUTE"

        # The number of trips starting at C and ending at C with a maximum 
        # of 3 stops (or a maximum of 4 nodes) 
		  	assert_equal g.DFS_max("CC", 4, [], []).size, 2 
		  	assert_equal g.DFS_max("CC", 4, [], []).sort, ["CDC", "CEBC"].sort

        # The number of trips starting at A and ending at C with exactly 4 
        # stops (or exactly 5 nodes)
		  	assert_equal g.DFS("AC", 5, [], []).size, 3
		  	assert_equal g.DFS("AC", 5, [], []).sort, ["ABCDC", "ADCDC", "ADEBC"].sort

        # The length of the shortest route
		  	assert_equal g.Dijkstra("AC"), 9
		  	assert_equal g.Dijkstra("BB"), 9

        # The number of different routes from C to C with a distance of 
        # less than 30 (or a maximum distance of 29)
		  	assert_equal g.DFS_Weighted_max("CC", 29, [], []).size, 7
  	    assert_equal g.DFS_Weighted_max("CC", 29, [], []).sort, ["CDC", "CEBC", "CEBCDC", "CDCEBC", "CDEBC", "CEBCEBC", "CEBCEBCEBC"].sort
		  end
		end
	end
end