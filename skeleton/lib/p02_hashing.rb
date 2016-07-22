class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return ('empty_array'.hash * nil.hash).hash if self.length == 0
    mid_hash = self.map.with_index do |el, idx|
      (el.hash * (idx+1)).hash
    end

    mid_hash.inject { |acc, x| acc ^ x }
  end
end

class String
  def hash
    return ('nil'.hash * nil.hash).hash if self.length == 0
    mid_hash = self.split('').map.with_index do |el, idx|
      (el.ord * (idx+1)).hash
    end

    mid_hash.inject { |acc, x| acc ^ x }

  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    return ('empty_hash'.hash * nil.hash).hash if self.keys.length == 0

    mid_hash = keys.map.with_index do |_el, idx|
      keys[idx].hash ^ values[idx].hash ^ idx.hash
    end
    mid_hash.inject { |acc, x| acc ^ x }
  end
end
