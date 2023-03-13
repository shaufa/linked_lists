class LinkedList ()
  attr_reader :head, :tail
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    elsif @tail.nil?
      @head.next_node = @tail = new_node
    else
      last(@head).next_node = @tail = new_node
    end
  end
  
  def prepend(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = Node.new(value)
    else
      new_node = Node.new(value, @head)
      @head = new_node
    end
  end

  def last(head)
    return head if head.next_node.nil?
    last(head.next_node)
  end

  def size(head = @head, acc = 0)
    return acc + 1 if head.next_node.nil?
    acc += 1
    size(head.next_node, acc)
  end
  

  def to_s(head = @head, acc = "")
    return acc << "( #{head.value} ) -> nil" if head.next_node.nil?
    acc << "( #{head.value} ) -> "
    to_s(head.next_node, acc)
  end

  def at(index, head = @head, acc = 0)
    return head if index == acc
    acc += 1
    at(index, head.next_node, acc)
  end
  
  def pop
    self.at(self.size - 2).next_node = nil
    @tail = last(@head)
  end

  def contains?(value, head = @head)
    return true if value == head.value
    return false if head.next_node == nil
    contains?(value, head.next_node)
  end

  def find(value, head = @head, acc = 0)
    return acc if value == head.value
    return nil if head.next_node == nil
    acc += 1
    find(value, head.next_node, acc)
  end

  def insert_at(value, index)
    if at(index).next_node == nil
      self.append(value)
    elsif index == 0
      self.prepend(value)
    else
      prev_node = at(index - 1)
      next_node = at(index)
      prev_node.next_node = Node.new(value, next_node)
    end
  end

  def remove_at(index)
    case index
    when 0
      @head = @head.next_node
    when (self.size - 1)
      @tail = self.at(self.size - 2)
      @tail.next_node = nil
    else
      prev_node = at(index - 1)
      next_node = at(index + 1)
      prev_node.next_node = next_node
    end
  end
end


class Node
  attr_accessor :value, :next_node
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

l = LinkedList.new

l.append(1)
l.append(2)
l.append(3)
l.append(4)
l.append(5)
l.prepend(-1)
l.prepend(-2)
l.prepend(-3)
l.append(6)
p l.to_s
p l.size
p l.head.value
p l.tail.value
p l.at(8).value
l.pop
l.pop
l.pop
l.pop
l.pop
p l.to_s
l.remove_at(0)
p l.to_s

p l.find(1)


p l.contains?('a')