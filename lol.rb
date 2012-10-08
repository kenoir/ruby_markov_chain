module Insultatron

  class IO
    def get_word
      word = nil
      while c = self.read(1)
        if c =~ /\s/
          break if word
        else
          word||=""
          word << c
        end
      end
      word
    end
  end

  class Prefix < Array

    attr :prefix_length

    def initialize(length = 2)
      @prefix_length = length

      super()
    end

    def string
      raise "Not enought elements in prefix!" if count < @prefix_length

      string = ""
      self.each do | element |
        string += element
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

    def initialize
      @chain = Hash.new
    end

    def build(stream)
      raise "Stream must be instance of IO" if not stream.instance_of? IO



    end

  end

  class InsultGenerator

    def modifier
      ["stinky","loser","arsey","daily mail reading"]
    end

    def subject
      ["weasel","arse","masterchef contestant"]
    end

    def insult!
      puts "You #{pick_one(modifier)} #{pick_one(subject)}!"
      puts "Why don't you shove a #{pick_one(subject)} up your #{pick_one(subject)}"
    end

    def pick_one(word_array)
      index = random_index(word_array.count) - 1
      word_array[index]
    end

    private
    def random_index(max)
      index = (rand * max).round
    end

  end

  def self.run!
    prefix = Prefix.new

    prefix.push("hi")
    prefix.push("there")

    puts prefix.string

    prefix.shift

    puts prefix.inspect

    insult_generator = InsultGenerator.new
    insult_generator.insult!
  end

end

Insultatron.run!
