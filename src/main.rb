# frozen_string_literal: true

require 'json'
require 'tty-prompt'
require 'colorize'
require 'date'
require 'tty-font'
require 'tty-table'
require_relative 'quiz_method'

begin
  file = File.read('./quiz_data.json')
  data_hash = JSON.parse(file)
rescue StandardError
  puts "I can't find the quiz data where it's supposed to be!"
  puts "Please check that the path for the JSON file or move the json file back to where it was if you've moved it. Thanks!"
end

system 'clear'

font = TTY::Font.new(:standard)
puts font.write("WELCOME")
table = TTY::Table.new(["Command","Function"], [["ruby main.rb", "Open main menu"], ["./main_menu.sh", "Open main menu"],["./main_menu.sh <quiz topic>", "Directly starts a quiz for the topic"]])
puts table.render(:ascii)

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
    options.choice('Ruby quiz', 3)
    options.choice('View performance', 4)
    options.choice('Reset Performance Data', 5)
    options.choice('Exit', 6)
  end
  case selection

  when 1
    ARGV[0] = 'html'
    start_quiz(data_hash[ARGV[0]])

  when 2
    ARGV[0] = 'css'
    start_quiz(data_hash[ARGV[0]])

  when 3
    ARGV[0] = 'ruby'
    start_quiz(data_hash[ARGV[0]])

  when 4
    File.open('user_performance.txt', 'r') do |file|
      puts file.read()
    end

  when 5
    File.open('user_performance.txt', 'w') do |file|
      file.write('USER PERFORMANCE')
      file.write("\n--------------")
    end
  end
end

