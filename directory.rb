require 'csv'
@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list from a file"
  puts "9. Exit" # 9 because we'll be adding more items
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    insert_student("#{name},november")
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each {|student| puts "#{student[:name]} (#{student[:cohort]} cohort)"}
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def get_filename
  filename = ''
  while filename == '' do
    puts "Please enter the name of the students file: "
    filename = gets.chomp
  end
  filename
end

def save_students
  # open the file for writing
  puts "Preparing to save the student list..."
  filename = get_filename
  CSV.open(filename, "wb") do |csv|
    @students.each {|student| csv << [student[:name], student[:cohort]]}
  end
  puts "--> Students have been saved to '#{filename}'"
end

def load_students(filename = nil)
  filename = filename.nil? ? get_filename : filename
  if File.exists?(filename)
    CSV.foreach(filename) {|line| insert_student(line)}
    puts "--> Students have been loaded from '#{filename}'."
  else
    puts "--> File '#{filename}' not found. Could not load the list."
  end
end

def insert_student(line)
  if line.is_a?(String)
    name, cohort = line.chomp.split(',')
  else
    name, cohort = line
  end
  @students << {name: name, cohort: cohort.to_sym}
end

def try_load_students
  filename = ARGV.first || "students.csv" # first argument from the command line
  load_students(filename)
  puts "Loaded #{@students.count} from '#{filename}'"
end

try_load_students
interactive_menu
