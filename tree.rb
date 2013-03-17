
require 'set'

class TreeNode
	attr_accessor :parent
	attr_reader :value, :children

	def initialize(value, parent = nil)
		@value = value
		@parent = parent
		@children = []
	end

	def add_child(child)
		child.parent = self
		@children << child
	end

	def dfs(value, &block)
		if self.value == value
			return self
		end
		answer = nil
		@children.each do |child|
			next if !answer.nil?
			answer = child.dfs(value)
		end
		if block
			block.call(answer)
		else
			answer
		end
	end

	def bf_print


	end


	def bfs(value, &block)
		search_queue = []
		search_queue << self

		while search_queue.length > 0 
			test_node = search_queue.shift
			if test_node.value != value
				test_node.children.each { |child| search_queue << child }
			else
				return block ? block.call( test_node ) : test_node
			end
		end
	end

	def more_nodes?
		print_queue[print_queue.keys.sort.last].last.children.length > 0



	end

	def print_tree  ## major issue..it stops looping when it hits any branch that has no children
		#not necessarily the last!
		# { tree_level => [nodes] }
		print_queue = Hash.new { |hash, key| hash[key] = [] }
		
		tree_level = 1

		print_queue[1] << self

		while more_nodes?(print_queue)
			print_queue[print_queue.keys.sort.last].each do |node|
				node.children.each do |child|
					print_queue[tree_level+1] << child
				end
			end
			tree_level += 1
		end
		node_count = 0
		print_queue.each do |tree_level, nodes|
			print "nodes at level #{tree_level}: "
			nodes.each { |node| print "#{node.value} | "; node_count += 1 }
			print "\n"
		end
	end
end
class Knight

	MOVES = [[2,1],
			 [1,2],
			 [2,-1],
			 [1,-2],
			 [-1,-2],
			 [-2,-1],
			 [-1,2],
			 [-2,1]]

	def move_tree(root_node)
		used_moves = Set.new
		newest_nodes = [root_node]

		8.times do |index|
			next_newest_nodes = []

			newest_nodes.each do |node|

				start = node.value
				MOVES.each do |move|
					new_move = [ move[0] + start[0], move[1] + start[1] ]  #x,y
					if !used_moves.include?( new_move ) && in_bounds?( new_move )
						used_moves.add( new_move )
						new_node = TreeNode.new(new_move) 
						node.add_child( new_node )
						next_newest_nodes << new_node
					end
				end
			end
			newest_nodes = next_newest_nodes
		end
		[ root_node , used_moves ] 
	end




	def in_bounds?(move)
		( move[0] <= 8 && move[0] >= 1 ) && ( move[1] <= 8 && move[1] >= 1 )
	end

end

def p
	root = TreeNode.new( [5,4] )
	root , used_moves = root.move_tree( root )
	root.print_tree
	print "you found : #{used_moves.length} moves"
	root
end


def m

	root = TreeNode.new(1)
	root.add_child( TreeNode.new(2) )
	root.add_child( TreeNode.new(3) )
	root.children[0].add_child( TreeNode.new(4) )
	root.children[0].add_child( TreeNode.new(5) )
	root.children[1].add_child( TreeNode.new(6) )
	root.children[1].add_child( TreeNode.new(7) )

	root
end