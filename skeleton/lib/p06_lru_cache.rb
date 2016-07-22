require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # cache_link = @map.get(key)

    if @map.include?(key)
      value = @map.get(key)
      @store.remove(key)
      @store.insert(key,value)
      @map[key] = @store.get_link(key)
      value

    else
      value = calc!(key)
      if count == @max
        eject!
      end
      @store.insert(key,value)
      @map[key] = @store.get_link(key)
      value
    end

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    @map.delete(@store.head.key)

    @store.remove(@store.head.key)



  end
end
