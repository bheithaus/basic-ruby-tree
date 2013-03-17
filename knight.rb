require 'set'
require './tree'

class Knight

	MOVES = [[2,1],
			 [1,2],
			 [2,-1],
			 [1,-2],
			 [-1,-2],
			 [-2,-1],
			 [-1,2],
			 [-2,1]]

	def knight_path(start_pos, end_pos)
		## make a tree starting from the start_pos
		root_node = move_tree( TreeNode.new( start_pos ) )
		## find the shortest path to the end_pos
		end_node = root_node.bfs( end_pos )
		array_of_positions = []
		node_tracer = end_node
		##follow parent chain to track series of moves
		until node_tracer.parent.nil?
			array_of_positions << node_tracer.value
			node_tracer = node_tracer.parent
		end
		array_of_positions << node_tracer.value

		array_of_positions.reverse
	end

private

	def move_tree(root_node)
		used_moves = Set.new(root_node.value)
		newest_nodes = [root_node]
		6.times do |index|   ## how to handle this in a more extensible way??
			newest_nodes_in_training = []   ## tracking the new nodes to be
			newest_nodes.each do |node|
				start = node.value
				MOVES.each do |move|
					new_move = [ move[0] + start[0], move[1] + start[1] ]  #x,y
					if !used_moves.include?( new_move ) && in_bounds?( new_move )
						used_moves.add( new_move )
						new_node = TreeNode.new(new_move) 
						node.add_child( new_node )
						newest_nodes_in_training << new_node
					end
				end
			end
			newest_nodes = 	newest_nodes_in_training
		end
		root_node
	end

	def in_bounds?(move)
		( move[0] <= 8 && move[0] >= 1 ) && ( move[1] <= 8 && move[1] >= 1 )
	end
end


###tester method
def p

	dr_knight = Knight.new

	dr_knight.knight_path([8, 1],[1, 1])
	# root = TreeNode.new( [5,4] )
	# dr_knight = Knight.new
	# root , used_moves = dr_knight.move_tree( root )
	# root.print_tree
	# print "you found : #{used_moves.length} moves"
	# nil

end
