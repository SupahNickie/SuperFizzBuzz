# CRACKING THE CODING INTERVIEW PROBLEMS
# ARRAYS AND STRINGS

# 1.1

def unique_string(string)
  puts string.chars.uniq == string.chars ? "unique" : "not unique"
end

unique_string("ice")
unique_string("poo")

# 1.2

def reverse_c_string(string)
  new_string = string.reverse + " "
  puts new_string
  puts new_string.chars.size
end

reverse_c_string("qwer")

# 1.3

def remove_duplicate_chars(string)
  puts string.chars.uniq!.join
end

remove_duplicate_chars("neubie")

# 1.4

def anagrams(a, b)
  a.each_with_index { |word, index| puts a[index].chars.sort == b[index].chars.sort ? "1" : "0" }
end

anagrams(["iceman", "carebear", "tuesq"], ["cinema", "subpoena", "quest"])

# 1.5

def replace_spaces_with_percenttwenty(string)
  puts string.gsub(" ", "%20")
end

replace_spaces_with_percenttwenty("I have to pewp")

# SOME MORE STRING UTILITIES

class String
  def balanced?
    counter = 0
    self.chars.each do |char|
      if char == "("
        counter += 1
      elsif char == ")"
        counter -= 1
      end
      return "Invalid closing parentheses" if counter < 0
    end
    counter.zero? ? "Balanced" : "Invalid amounts of opening parantheses"
  end
end

# LINKED LISTS

# 2.1, 2.2, 2.3

class LinkedList
  attr_accessor :stores, :head, :tail
  def initialize(stores = [], head = nil, tail = nil)
    @stores = stores
    @head = head
    @tail = tail
  end

  def append(node)
    if @stores.empty?
      @head = node
      @tail = node
    else
      @tail.after = node
      node.previous = @tail
      @tail = node
    end
    @stores << node
  end

  def prepend(node)
    if @stores.empty?
      @head = node
      @tail = node
    else
      @head.previous = node
      node.after = @head
      @head = node
    end
    @stores << node
  end

  def list_stores
    @stores.each do |data|
      if data == @head
        puts "This is the head"
        puts "#{data.after} is the after node"
      elsif data == @tail
        puts "This is the tail"
        puts "#{data.previous} is the previous node"
      else
        puts "#{data.after} is the after node"
        puts "#{data.previous} is the previous node"
      end
      puts "#{data.data} is the data; #{data} is the actual object"
      puts ""
    end
  end

  def search(position)
    counter = @head
    position.times do
      @node = counter
      counter = counter.after
    end
    @node
  end

  def delete(position)
    node = self.search(position)
    if node == @head
      node_above = node.after
      node_above.previous = nil
      @head = node_above
    elsif node == @tail
      node_below = node.previous
      node_below.after = nil
      @tail = node_below
    else
      node_above = node.after
      node_below = node.previous
      node_above.previous = node.previous
      node_below.after = node.after
    end
    node.data = nil
    @stores.delete(node)
  end

  def remove_duplicates
    counter = @head
    position = 1
    instances = Hash.new
    instances.default = 0
    until counter.nil?
      instances[counter.data] += 1
      if instances[counter.data] > 1
        self.delete(position)
        instances = Hash.new
        instances.default = 0
        counter = @head
        position = 1
      else
        counter = counter.after
        position += 1
      end
    end
  end

end

class Node
  attr_accessor :data, :after, :previous
  def initialize(data, after = nil, previous = nil)
    @data = data
    @after = nil
    @previous = nil
  end
end

list = LinkedList.new
node1 = Node.new(5)
node2 = Node.new(9)
node3 = Node.new(13)
node4 = Node.new(3)
node5 = Node.new(13)
node6 = Node.new(8)
node7 = Node.new(3)
node8 = Node.new(5)
node9 = Node.new(5)
list.append(node1)
list.append(node2)
list.prepend(node3)
list.prepend(node4)
list.append(node5)
list.append(node6)
list.append(node7)
list.append(node8)
list.append(node9)
list.list_stores
list.search(3)
list.delete(1)
list.delete(1)
list.delete(2)
list.delete(list.stores.size)
list.list_stores
puts "GETTING RID OF DATA"
list.remove_duplicates
list.list_stores

# TREES

class Tree
  attr_accessor :root, :leaves
  def initialize(root = nil, leaves = [])
    @root = root
    @leaves = leaves
  end

  def append_leaf(leaf, parent = nil)
    @root = leaf if @root.nil?
    @leaves << leaf
    if leaf != @root
      parent.children << leaf
      parent.children.sort_by! { |x| x.data }
      leaf.siblings = parent.children
      leaf.parent = parent
    end
  end

  def remove_leaf(leaf)
    if leaf == @root
      @root = leaf.children[(leaf.children.size/2)]
      if @root.siblings.any?
        @root.siblings.each do |sibling|
          @root = sibling.parent
        end
      end
    else
      if leaf.children.any?
        leaf.children.each do |child|
          child.parent = leaf.siblings[(leaf.siblings.size)/2]
        end
      end
      leaf.siblings.each { |sibling| sibling.siblings.delete(leaf) }
    end
    @leaves.delete(leaf)
  end

  def find_leaf(leaf = @root, value)
    if leaf.data == value
      a = leaf
    else
      if leaf.children.any?
        leaf.children.each do |n|
          find_leaf(n, value)
        end
      end
    end
    puts "#{a} with data #{a.data} has been found with parent #{leaf.parent}, which has value #{leaf.parent.data}" unless a.nil?
  end

end

class Leaf
  attr_accessor :data, :parent, :siblings, :children
  def initialize(data, parent = nil, siblings = [], children = [])
    @data = data
    @parent = parent
    @siblings = siblings
    @children = children
  end

end

tree = Tree.new
leaf = Leaf.new(35)
tree.append_leaf(leaf)
leaf2 = Leaf.new(70)
leaf3 = Leaf.new(17)
leaf4 = Leaf.new(42)
leaf5 = Leaf.new(20)
leaf6 = Leaf.new(13)
leaf7 = Leaf.new(80)
leaf8 = Leaf.new(99)
tree.append_leaf(leaf2, leaf)
tree.append_leaf(leaf3, leaf)
tree.append_leaf(leaf4, leaf3)
tree.append_leaf(leaf5, leaf3)
tree.append_leaf(leaf6, leaf5)
tree.append_leaf(leaf7, leaf2)
tree.append_leaf(leaf8, leaf2)
root_children, leaf4_siblings, leaf2_children = [], [], []
tree.root.children.each { |x| root_children << x.data }
leaf4.siblings.each { |x| leaf4_siblings << x.data }
leaf2.children.each { |x| leaf2_children << x.data }
tree.find_leaf(13)
print root_children
puts ""
print leaf4_siblings
puts ""
print leaf2_children
puts ""
tree.remove_leaf(leaf)
puts "#{tree.root} is the tree's root"
puts "#{leaf3} is the 3rd leaf"
puts "#{leaf2} is the 2nd leaf, which is the 3rd leaf's sibling"
tree.remove_leaf(leaf3)
puts "#{leaf4.parent} is leaf4's new parent, which is the 2nd leaf"
puts "#{leaf5.parent} is leaf5's new parent, which is the 2nd leaf as well"

# BINARY TREE TIME!

class BinaryTree
  attr_accessor :data, :left, :right
  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def child_nodes
    [@left, @right].compact
  end

  def balanced?
    hash = Hash.new
    hash.default = 0
    self.check_side(hash)
    hash[:left] > hash[:right] ? "The left side has more branches than the right" :
    hash[:right] > hash[:left] ? "The right side has more branches than the left" :
    "The tree has the same amount of left and right branches"
  end

  def check_side(hash)
    if @left && @right
      hash[:left] += 1
      hash[:right] += 1
      @left.check_side(hash)
      @right.check_side(hash)
    elsif @left && @right.nil?
      hash[:left] += 1
      @left.check_side(hash)
    elsif @right && @left.nil?
      hash[:right] += 1
      @right.check_side(hash)
    end
  end

  def same_depth?
    hash = Hash.new
    hash.default = 0
    if @left && @right
      hash[:left] = @left.height + 1
      hash[:right] = @right.height + 1
      hash[:left] > hash[:right] ? "The left side has more levels of depth (#{hash[:left]}) than the right (#{hash[:right]})" :
      hash[:right] > hash[:left] ? "The right side has more levels of depth (#{hash[:right]}) than the left (#{hash[:left]})" :
      "The tree has the same level of depth on the left and right side: #{hash[:right]}"
    elsif @left && @right.nil?
      "#{self.height} is the height of the left side with no right"
    elsif @right && @left.nil?
      "#{self.height} is the height of the right side with no left"
    else
      "There's only one node; the root"
    end
  end

  def height
    return 0 if self.child_nodes.empty?
    self.child_nodes.collect {|n| n.height + 1}.max
  end
end

tree = BinaryTree.new(17,
         BinaryTree.new(12,
           BinaryTree.new(6,
             BinaryTree.new(3), BinaryTree.new(8)),
           BinaryTree.new(14,
             nil, BinaryTree.new(13))),
         BinaryTree.new(28,
           BinaryTree.new(23,
             BinaryTree.new(18), BinaryTree.new(25)),
           BinaryTree.new(34,
             BinaryTree.new(29,
               BinaryTree.new(28,
                BinaryTree.new(11), BinaryTree.new(17)),
               nil),
             BinaryTree.new(30)))
        )

# The tree is deeper on the right side, yet has the same amount of left and right "branches"
puts tree.same_depth?
puts tree.balanced?

# BIT MANIPULATION

# 5.1

def number_substring_madness(n, m, pos1, pos2)
  new_n = n.to_s.chars
  new_n[pos1, pos2] = m.to_s.chars
  puts new_n.join
end

number_substring_madness(999_999_999, 3434, 2, 6)

# 5.6

def swap_even_odds(int)
  array = int.to_s.chars
  array.each_with_index do |number, index|
    if index % 2 == 0
      array[index], array[index + 1] = array[index + 1], array[index]
    end
  end
  puts array.join
end

swap_even_odds(4234052123450)

# BRAIN TEASERS

# 6.1

"3 1 3 6 = 8
(3+1)/(3/6) = 8"

# 6.3

"5 gallons and 3 gallons = 4 gallons

5 > 3, dump 3 gallons out
5(2 inside) > 3; 5 is empty, 3 gallon has 2 inside
5(fill up) > 3(2 inside); 5 gallons has 4 gallons inside"

# 6.5

"Drop the egg from the 10th floor, then the 20th floor and so on until it breaks, which will leave you with 9 additional floors to try.
The most amount of drops in the worst case scenario is on the 99th floor, which is 10 drops plus 9 more to find the individual floor."

# OBJECT ORIENTED DESIGN

# 7.1

SUITS = ["spades", "hearts", "clubs", "diamonds"]
NUMBERS = ["ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "jack", "queen", "king"]

class Deck
  attr_accessor :game, :cards
  def initialize(game, cards = [])
    @game = game
    @cards = cards
    if @game == "poker"
      SUITS.each do |suit|
        NUMBERS.each do |number|
          Card.new(suit, number).add_to_deck(self)
        end
      end
    elsif @game == "pinochle"
      SUITS.each do |suit|
        NUMBERS.each do |number|
          if number.is_a? String
            2.times { Card.new(suit, number).add_to_deck(self) }
          elsif (number.is_a? Fixnum) && (number > 8)
            2.times { Card.new(suit, number).add_to_deck(self) }
          end
        end
      end
    end
  end

  def list_cards
    self.cards.each do |card|
      card.list
    end
  end

  def shuffle(times_to_shuf)
    times_to_shuf.times { self.cards.shuffle! }
  end
end

class Card
  attr_accessor :suit, :value
  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def list
    print "#{self.value} of #{self.suit}"
    puts ""
  end

  def add_to_deck(deck)
    deck.cards << self
  end
end

deck1 = Deck.new("poker")
deck2 = Deck.new("pinochle")
deck1.list_cards
deck2.shuffle(3)
deck2.list_cards

# 7.2

class Office
  attr_accessor :freshers, :tl, :pm, :employees
  def initialize(tl, pm, freshers = [])
    @freshers = freshers
    @tl = tl
    @pm = pm
    @employees = [@freshers, @tl, @pm]
  end

  def add_fresher_to_office(name)
    Employee.new("freshers", name).assign_fresher_to_office(self)
  end
end

class Employee
  attr_accessor :type, :name, :engaged
  def initialize(type, name, engaged = false)
    @type = type
    @name = name
    @engaged = engaged
  end

  def assign_fresher_to_office(office)
    office.freshers << self
  end
end

class Call
  attr_accessor :subject, :handler
  def initialize(subject, handler = nil)
    @subject = subject
    @handler = handler
  end

  def get_call_handler(office)
    office.employees.flatten.each do |employee|
      if employee.engaged == false
        if employee.type == "freshers"
          @handler = employee.name
          break
        elsif employee.type == "tl"
          @handler = employee.name
          break
        else # employee.type == "pm"
          @handler = employee.name
        end
      else
        @handler = "on hold"
      end
    end
  end
end

bill = Employee.new("tech lead", "Bill")
steve = Employee.new("project manager", "Steve")
joe = Employee.new("freshers", "Joe", true)
office = Office.new(bill, steve)
joe.assign_fresher_to_office(office)
office.add_fresher_to_office("Stewart")
office.employees.flatten.collect { |employee| puts employee.name }
test_call = Call.new("tech support")
test_call.get_call_handler(office)
puts test_call.handler

# 7.3

class Jukebox
  attr_accessor :songs
  def initialize(songs = [])
    @songs = songs
  end

  def list_songs
    @songs.each do |song|
      puts "#{song.name} by #{song.artist}"
    end
  end
end

class Song
  attr_accessor :name, :artist
  def initialize(name, artist)
    @name = name
    @artist = artist
  end

  def add_to_jukebox(jukebox)
    jukebox.songs << self
  end
end

jukebox = Jukebox.new
song = Song.new("One", "Metallica")
song.add_to_jukebox(jukebox)
Song.new("Slickleg", "Mastodon").add_to_jukebox(jukebox)
jukebox.list_songs

# 7.8

class Piece
  attr_accessor :starting_color, :current_color, :top, :bottom, :left, :right
  def initialize(starting_color, current_color, top = false, bottom = false, left = false, right = false)
    @starting_color = starting_color
    @current_color = current_color
    @top = top
    @bottom = bottom
    @left = left
    @right = right
  end

  def check_color
    if (top && bottom) || (left && right)
      if @starting_color == "white"
        @current_color = "black"
      else
        @current_color = "white"
      end
    end
  end
end

# RECURSION

# 8.1

def nth_iterative_fibonacci(n)
  start = 0
  iter_start = 1
  sum = 0
  (n - 1).times do
    sum = start + iter_start
    start = iter_start
    iter_start = sum
  end
  return sum
end

puts nth_iterative_fibonacci(5)
puts nth_iterative_fibonacci(20)

def nth_recursive_fibonacci(n)
  return 0 if n == 0
  return 1 if n == 1
  nth_recursive_fibonacci(n - 1) + nth_recursive_fibonacci(n - 2)
end

puts nth_recursive_fibonacci(5)
puts nth_recursive_fibonacci(20)

MEMO = Hash.new

def golf_style_memoized_fibonacci(n)
  n < 2 ? n : MEMO.has_key?(n) ? MEMO[n] : MEMO[n] = fibonacci(n-1) + fibonacci(n-2)
end

# 8.4

def permutations(string)
  return [string] if string.size == 1
  array = Array.new
  (0..(string.size - 1)).each do |n|
    rest = string.chars
    picked = rest.delete_at(n)
    permutations(rest.join).each { |x| array << picked + x }
  end
  array
end

puts permutations("cute")

# SORTING AND SEARCHING

# 9.1

def two_sorted(a, b)
  a.each_with_index do |num, index|
    unless b.empty?
      if b.first < num
        a.insert(index, b.shift)
      elsif b.first > a.last
        a << b.shift
      end
    end
  end
  return a
end

print two_sorted([4, 10, 13, 24], [5, 16, 90])
puts ""

# 9.2

# O(n^2) RUNTIME, ONE ITERATION OF ARRAY PER WORD

array = ["socks", "cinema", "stare", "cemian", "cokss", "brigade", "tares", "iceman", "time", "rbiagde", "rates", "maniec"]

def anagram_sort(array)
  new_array = Array.new
  array.each do |word|
    index = 0
    while index < array.size
      comparator = array[index]
      if (word != comparator) && (word.chars.sort == comparator.chars.sort)
        new_array << comparator
        array.delete(comparator)
      end
      index += 1
    end
    new_array << word
    array.delete(word)
  end
  return new_array + array
end

puts anagram_sort(array)

# O(n) RUNTIME, ONE ITERATION THROUGH ARRAY

array = ["socks", "cinema", "stare", "cemian", "cokss", "brigade", "tares", "iceman", "time", "rbiagde", "rates", "maniec"]

def better_anagram_sort(array)
  hash = {}
  array.each do |string|
    sorted = string.chars.sort.join.to_sym
    if hash[sorted].nil?
      hash[sorted] = [string]
    else
      hash[sorted] << string
    end
  end
  hash.values.flatten
end

puts better_anagram_sort(array)
