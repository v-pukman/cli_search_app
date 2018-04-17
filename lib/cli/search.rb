require_relative '../initech/search'
require "highline/import"

# https://makandracards.com/makandra/45704-quickly-printing-data-in-columns-on-your-ruby-console
def print_result objects, method_names
  terminal_width = `tput cols`.to_i
  cols = objects.count + 1
  col_width = (terminal_width / cols) - 1

  puts "*"*terminal_width

  Array(method_names).map do |method_name|
    cells = objects.map{ |o| o[method_name] }
    cells.unshift(method_name)
    puts cells.map{ |cell| cell.to_s.ljust(col_width) }.join ' '
  end

  puts "*"*terminal_width
end

def ask_data label
  val = ask label
  quit if val == "quit"
  val
end

def quit
  say "Ok, see you"
  exit 0
end

def search file_path, field, value
  results = Initech::Search.new.start file_path, field, value
  if results.any?
    results.each do |r|
      print_result [r], r.keys
    end
    say "#{results.count} results found"
  else
    say "No results found"
  end
end


ask_data "Type 'quit' to exit at any time, Press 'enter' to continue:"
file_type = choose do |menu|
  menu.prompt = "Select file type:"
  menu.choice(:users)
  menu.choice(:tickets)
  menu.choice(:organizations)
  menu.choice(:quit) { quit }
end

field = ask_data "Enter seach field:"
value = ask_data "Enter search value:"

say "Searching #{file_type} for #{field} with a value of #{value}:"

file_path = File.join('assets', "#{file_type}.json")
search file_path, field, value


