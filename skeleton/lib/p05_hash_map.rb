require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
    @keys = []
  end

  def include?(key)
    if get(key).nil?
      false
    else
      true
    end
  end


  def set(key, val)
    @count += 1
    resize! if @count > num_buckets
    index = key.hash % num_buckets
    @store[index].insert(key, val)
    @keys << key
  end

  def get(key)
    index = key.hash % num_buckets
    @store[index].get(key)
  end


  def delete(key)
    index = key.hash % num_buckets
    @store[index].remove(key)
    @count -= 1
    @keys.delete(key)
  end

  def each(&blck)
    @keys.each do |key|
      blck.call(key, get(key))
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = HashMap.new(num_buckets*2)
    each { |key, value| temp_store.set(key, value) }
    @store = temp_store.store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
