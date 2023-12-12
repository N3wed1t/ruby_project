# example_array = Array.new(20) {rand(1..200)}
example_array = [1, 2, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

# Node class used to represent each node of the b-tree containing "value" which is it own value
# "left_child" which is left child node of that root node and "right_child" means the same way
class Node
  attr_accessor :value, :left_child, :right_child

  def initialize(value = nil, left_child = nil, right_child = nil)
    @value = value
    @left_child = left_child
    @right_child = right_child
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(array)
    return nil if array.empty?

    middle = array.length / 2
    root = Node.new(array[middle])

    root.left_child = build_tree(array[0...middle])
    root.right_child = build_tree(array[(middle + 1)..-1])

    root
  end

  def insert(value, node = @root)
    if value < node.value
      node.left_child.nil? ? node.left_child = Node.new(value) : insert(value, node.left_child)
    elsif value > node.value
      node.right_child.nil? ? node.right_child = Node.new(value) : insert(value, node.right_child)
    end
  end

  def delete(value, node = @root)
    return node if node.nil?
    if value < node.value
      node.left_child = delete(value, node.left_child)
      node
    elsif value > node.value
      node.right_child = delete(value, node.right_child)
      node
    elsif value == node.value
      if node.left_child.nil? && node.right_child.nil?
        nil
      elsif !node.left_child.nil? && node.right_child.nil?
        node.left_child
      elsif node.left_child.nil? && !node.right_child.nil?
        node.right_child
      elsif not node.left_child.nil? && node.right_child.nil?
        min_right_child = find_min(node.right_child)
        delete(min_right_child.value)
        min_right_child.right_child, min_right_child.left_child = node.right_child, node.left_child
        min_right_child
      end
    end
  end

  def find(value, node = @root)
    return nil if node.nil?
    if value < node.value
      find(value, node.left_child)
    elsif value > node.value
      find(value, node.right_child)
    elsif value == node.value
      node
    end
  end

  def find_min(node = @root)
    node.left_child.nil? ? node : find_min(node.left_child)
  end

  def level_order(&block)

  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end


b_tree = Tree.new(example_array)
b_tree.delete(4)
b_tree.pretty_print
