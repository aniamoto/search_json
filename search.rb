require_relative 'services/file_parser'
require_relative 'services/search_service'

puts 'Enter path to file:'
file_path = gets.chomp
data = FileParser.new(file_path).perform

if data.is_a?(String)
  puts data
else
  puts "Enter a phase to search in '#{file_path}':"
  target = gets.chomp.downcase
  result = SearchService.new(data, target).perform
  line = '-' * 100

  puts line
  puts "Search result for '#{target}' in '#{file_path}':"
  puts line
  puts result
  puts '*** Thank you. Have a nice day! ***'
end
