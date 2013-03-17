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

	def deepest_level(queue)
		queue.keys.sort.last
	end

	def more_nodes?(print_queue)
		more_nodes = false
		print_queue[ deepest_level( print_queue ) ].each do |node_at_bottom| 
			more_nodes = true unless node_at_bottom.children.empty?
		end
		more_nodes
	end

	def print_tree
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

##test build a tree
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