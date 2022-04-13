# frozen_string_literal: true

require 'json'
require 'tty-prompt'
require 'colorize'
require 'date'

begin
  file = File.read('./quiz_data.json')
  data_hash = JSON.parse(file)
rescue StandardError
  puts "I can't find the quiz data where it's supposed to be! Please check that the path for the JSON file or move the json file back to where it was if you've moved it. Thanks!"
end

def start_quiz(qns)
  current_time = DateTime.now
  score = 0
  qns.each do |question|
    answer = TTY::Prompt.new.select(question['question']['prompt'], echo: false) do |options|
      options.choice(question['question']['option_1']['text'], question['question']['option_1']['is_correct'])
      options.choice(question['question']['option_2']['text'], question['question']['option_2']['is_correct'])
      options.choice(question['question']['option_3']['text'], question['question']['option_3']['is_correct'])
      options.choice(question['question']['option_4']['text'], question['question']['option_4']['is_correct'])
    end
    system 'clear'
    puts '----------------'
    if answer
      puts 'correct.'.colorize(:green)
      puts '----------------'
      score += 1
    else
      puts 'nope.'.colorize(:red)
      puts '----------------'
    end
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

system 'clear'

if ARGV[0]
  begin
    start_quiz(data_hash[ARGV[0]])
  rescue StandardError
    puts 'please enter either one of the following:'
    puts 'ruby main.rb html'
    puts 'ruby main.rb css'
    puts 'ruby main.rb ruby'
  end
else
  selection = TTY::Prompt.new.select('Please make a selection :)', echo: false) do |options|
    options.choice('HTML quiz', 1)
    options.choice('CSS quiz', 2)
    options.choice('Ruby quiz', 2)
    options.choice('Reset Performance Data', 4)
    options.choice('Exit', 5)
  end
  case selection

  when 1
    ARGV[0] = 'html'
    start_quiz(data_hash['html'])

  when 2
    ARGV[0] = 'css'
    start_quiz(data_hash['css'])

  when 3
    ARGV[0] = 'ruby'
    start_quiz(data_hash['ruby'])

  when 4
    File.open('user_performance.txt', 'w') do |file|
      file.write('USER PERFORMANCE')
      file.write("\n--------------")
    end
  end
end
