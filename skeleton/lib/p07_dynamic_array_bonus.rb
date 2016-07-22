class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count
  include Enumerable

  def each(&block)

  end

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    i = i + @count if i < 0
    return nil unless i.between?(0,@count-1)
    @store[i]
  end

  def []=(i, val)
    i = i + @count if i < 0
    until @count > i
      self.push(nil)
    end
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |x|
      return true if x == val
    end
    false
  end

  def push(val)
    @count += 1
    if @count > @store.length
      resize!
    end
    @store[@count-1] = val
  end

  def unshift(val)
    counter = @count
    @count += 1
    if @count >= @store.length
      resize!
    end
    until counter == 0

      @store[counter] = @store[counter - 1]
      counter -= 1
    end
    @store[0] = val

  end

  def pop
    return nil if @count == 0
    # puts "counter #{@count} counter -1 #{@count-1} length #{@store.length}"
    return_value = @store[@count - 1]
    @store[@count - 1] = nil
    @count -= 1
    return_value
  end

  def shift
    counter = 0
    output = @store[0]
    until counter == @store.length-1
      @store[counter] = @store[counter+1]
      counter +=1
    end
    @store[@store.length-1] = nil
    @count -= 1
    output
  end

  def first
    @store[0]
  end

  def last
    @store[@count-1]
  end

  def each(&prc)
    counter = 0
    while counter < @count
      prc.call(@store[counter])
      counter +=1
    end
    @store
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    counter = 0
    return false unless @count == other.count
    until counter >= @count
      return false unless @store[counter] == other[counter]
      counter +=1
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_static_arr = StaticArray.new(@store.length * 2)
    counter = 0
    until counter == @store.length
      new_static_arr[counter] = @store[counter]
      counter += 1
    end
    @store = new_static_arr
  end
end
