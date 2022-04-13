require 'json'
require 'tty-prompt'
require 'colorize'

begin
    file = File.read('./quiz_data.json')
    data_hash = JSON.parse(file)
rescue
    puts "I can't find the quiz data where it's supposed to be! Please check that the path for the JSON file or move the json file back to where it was if you've moved it. Thanks!"
end

puts 

def json_method(qns)
    performance = Hash.new
    score = 0
    qns.each do |question|
      answer = TTY::Prompt.new.select(question['question']['prompt'], echo: false) do |options|
        options.choice(question['question']['option_1']['text'], question['question']['option_1']['is_correct'])
        options.choice(question['question']['option_2']['text'], question['question']['option_2']['is_correct'])
        options.choice(question['question']['option_3']['text'], question['question']['option_3']['is_correct'])
        options.choice(question['question']['option_4']['text'], question['question']['option_4']['is_correct'])
        
      end
      system "clear"
      puts '----------------'
      if answer
        puts 'correct.'.colorize(:green)
        puts '----------------'
        score += 1
        performance[question['question']['prompt']] = "correct!"
      else
        puts 'nope.'.colorize(:red)
        puts '----------------'
        performance[question['question']['prompt']] = "incorrect :("
      end
    end
    system "clear"
    puts "You got #{score} out of 5!"
    puts performance
end

system "clear"

begin
json_method(data_hash[ARGV[0]])
rescue
puts "please enter either one of the following:"
puts "ruby main.rb html"
puts "ruby main.rb css"
puts "ruby main.rb ruby"
end
