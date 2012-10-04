module Insultatron

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
    insult_generator = InsultGenerator.new
    insult_generator.insult!
  end

end

Insultatron.run!
