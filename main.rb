module MarkovGenerator
  class Prefix < Array

    attr :prefix_length

    def initialize(length = 2)
      @prefix_length = length
    
      super(length,nil)
    end

    def string
      raise "Not enought elements in prefix!" if count < @prefix_length

      string = ""
      self.each do | element |
        string += element.to_s
      end

      string
    end

    def []=(index,value)
      raise "Index > Prefix length!" if index >= @prefix_length 

      super(index,value)
    end

    def push(value)
      raise "Prefix full!" if count == @prefix_length

      super(value)
    end
  end

  class MarkovChain

    attr :chain
    attr :prefix_length

    def initialize(prefix_length = 2)
      @chain = Hash.new{|h,k| h[k] = []}
      @prefix_length = prefix_length
    end

    def build(corpus)
      corpus_array = corpus.split(" ")
      prefix = Prefix.new(@prefix_length)

      corpus_array.each_with_index do | word, index |
        @chain[prefix.string] << corpus_array[index]
        prefix = prefix.clone

        prefix.shift
        prefix.push(word)
      end

      @chain
    end

    def generate(maximum_length)
      generated_chain = [] 

      prefix = Prefix.new(@prefix_length)

      maximum_length.times {
        word_list = @chain[prefix.string] 
        index = determine_index(word_list)
        word = word_list[index]

        generated_chain.push(word) 
        prefix.shift
        prefix.push(word)
      }

      generated_chain  
    end

    private
    def determine_index(word_list)
      (rand * word_list.length).floor
    end

  end

  def self.run!
    markov_chain = MarkovChain.new
    corpus = IO.read('corpus.txt') 

    markov_chain.build(corpus)
    puts markov_chain.generate(20).join(" ")
  end

end

MarkovGenerator.run!
