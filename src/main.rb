require 'json'

begin
    file = File.read('./quiz_data.json')
    data_hash = JSON.parse(file)
rescue
    puts "I can't find the quiz data where it's supposed to be! Please check that the path for the JSON file or move the json file back to where it was if you've moved it. Thanks!"
end

