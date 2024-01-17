class HashMap
  def initialize()
    @buckets = Array.new(16) {[]}
    @load_factor = 0.75
  end

  def hash(string)
    hash_code = 0
    prime_number = 13

    string.each_char { |char| hash_code = prime_number * hash_code + char.ord}

    hash_code
  end

  def set(key, value)
    unless @buckets.include? 

    end

  end
end
my_hash = HashMap.new
p my_hash.hash('hello')