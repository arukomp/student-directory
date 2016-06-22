def input_students
  puts "Please enter the names of the students"
  puts "Please enter their name, cohort (defaults to this month), age, and country of birth separated by commas"
  puts "For example: Arunas Skirius, november, 25, Lithuania"
  puts "To finish, just hit return twice"
  #create an empty array
  students = []
  # a list of valid cohorts
  months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november","december"]
  name = gets.chomp.split(',').map {|n| n.strip}
  #while the name is not empty, repeat this code
  while !name.empty? do
    if name[0] == "" || name[2].to_i <= 0 || name[3] == ""
      puts "* Please make sure you enter Full name, cohort, age, and country of birth separated by commas *"
    elsif !months.include?(name[1].downcase)
      puts "* Make sure you spell the cohort correctly *"
    else
      #add the student hash to the array
      students << {
        name: name[0],
        cohort: name[1] == "" ? Time.new.strftime("%B").downcase.to_sym : name[1].downcase.to_sym,
        age: name[2].to_i,
        country: name[3]
      }
      puts "Now we have #{students.count} students"
    end
    #get another name from the user
    name = gets.chomp.split(',').map {|n| n.strip}
  end
  students
end

def select_letter(students, letter)
  students = students.select do |student|
    student[:name].downcase[0] == letter.downcase[0]
  end
  students
end

def short_names(students, len)
  students.select do |student|
    student[:name].length < len
  end
end

def print_header
  puts "The students of Villains Academy".center (40)
  puts "----------".center(40)
end

def print(students)
  # students.each.with_index do |student, index|
  #   puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  # end
  index = 0
  while index < students.length do
    puts "#{index + 1}. " + "#{students[index][:name]}".center(25) +
         "(#{students[index][:cohort]} cohort) - " +
         "#{students[index][:age]}, " +
         "from #{students[index][:country]}"
    index += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

# Start the program!
students = input_students
print_header
print(students)
print_footer(students)

# puts "Enter a starting letter to filter the student names: "
# letter = gets.chomp
# print(select_letter(students, letter))

# puts "Printing names shorter than 12 characters:"
# print(short_names(students, 12))
