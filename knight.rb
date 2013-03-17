require 'set'
require 'tree'

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
	
private

	def in_bounds?(move)
		( move[0] <= 8 && move[0] >= 1 ) && ( move[1] <= 8 && move[1] >= 1 )
	end
end


###tester method
def p
	root = TreeNode.new( [5,4] )
	dr_knight = Knight.new
	root , used_moves = dr_knight.move_tree( root )
	root.print_tree
	print "you found : #{used_moves.length} moves"
	nil
end
