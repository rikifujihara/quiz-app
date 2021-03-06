# frozen_string_literal: true

require 'json'
require 'tty-prompt'
require 'colorize'
require 'date'
require 'tty-font'
require 'tty-table'

def start_quiz(qns)
  system 'clear'
  current_time = DateTime.now
  score = 0
  qns.each do |question|
    answer = TTY::Prompt.new.select(question['question']['prompt'], echo: false) do |options|
      options.choice(question['question']['option_1']['text'], question['question']['option_1']['is_correct'])
      options.choice(question['question']['option_2']['text'], question['question']['option_2']['is_correct'])
      options.choice(question['question']['option_3']['text'], question['question']['option_3']['is_correct'])
      options.choice(question['question']['option_4']['text'], question['question']['option_4']['is_correct'])
    end

    if answer
      score += 1
      system 'clear'
      puts '----------------'
      puts 'Yep.'.colorize(:green)
    else
      system 'clear'
      puts '----------------'
      puts 'nope.'.colorize(:red)
    end
    puts '----------------'
  end
  system 'clear'
  puts "You got #{score} out of 5!"

  File.open('user_performance.txt', 'a') do |file|
    file.write("\nDate/Time : #{current_time.strftime '%d/%m/%Y %H:%M'}")
    file.write("\nTopic : #{ARGV[0]}")
    file.write("\nScore : #{score} out of 5")
    file.write("\n-------------------------")
  end

  File.open('user_performance.txt', 'r') do |file|
    puts file.read
  end
end
