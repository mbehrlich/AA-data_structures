class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  attr_reader :head
  include Enumerable
  def initialize
    @head = nil
    @tails = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tails
  end

  def empty?
    return true if @head.nil?
    false
  end

  def get(key)
    link = @head
    return nil if @head.nil?
    until link.key == key
      unless link.next == nil
        link = link.next
      else
        return nil
      end
    end
    link.val
  end

  def include?(key)
    link = @head
    return false if @head.nil?
    until link.key == key
      unless link.next == nil
        link = link.next
      else
        return false
      end
    end
    true
  end

  def insert(key, val)
    link = Link.new(key,val)
    if @head.nil?
      @head = link
      @tails = link
    end
    if include?(key)
      get_link(key).val = val
    else
      link.prev = @tails
      @tails.next = link
      @tails = link
    end
  end

  def remove(key)
    if include?(key)
      deleted_link = get_link(key)
      if @head == @tails
        @head = nil
        @tails = nil
      elsif deleted_link.next == nil
        deleted_link.prev.next = nil
        @tails = deleted_link.prev
        return true
      elsif deleted_link.prev == nil
        deleted_link.next.prev = nil
        @head = deleted_link.next
        return true
      else
        deleted_link.prev.next = deleted_link.next
        deleted_link.next.prev = deleted_link.prev
        return true
      end
    end
    false
  end

  def get_link(key)
    link = @head
    until link.key == key
      unless link.next == nil
        link = link.next
      else
        return nil
      end
    end
    link
  end



  def each(&blck)
    link = @head
    until link == nil
      blck.call(link)
      link = link.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
