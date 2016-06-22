def input_students
  puts "Please enter the names of the students"
  puts "Please enter their name, cohort (defaults to this month), age, and country of birth separated by commas"
  puts "For example: Arunas Skirius, november, 25, Lithuania"
  puts "To finish, just hit return twice"
  #create an empty array
  students = []
  # a list of valid cohorts
  months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november","december"]
  name = gets.rstrip.split(',').map {|n| n.strip}
  #while the name is not empty, repeat this code
  while !name.empty? do
    if name[0] == "" || name[2].to_i <= 0 || name[3] == ""
      puts "* Please make sure you enter Full name, cohort, age, and country of birth separated by commas *"
    elsif name[1] != "" && !months.include?(name[1].downcase)
      puts "* Make sure you spell the cohort correctly *"
    else
      #add the student hash to the array
      students << {
        name: name[0],
        cohort: name[1] == "" ? Time.new.strftime("%B").downcase.to_sym : name[1].downcase.to_sym,
        age: name[2].to_i,
        country: name[3]
      }
      puts "Now we have #{students.count} " + pluralize("student", students.count)
    end
    #get another name from the user
    name = gets.rstrip.split(',').map {|n| n.strip}
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
  index = 0
  while index < students.length do
    puts "#{index + 1}. " + "#{students[index][:name]}".center(30) +
         "(#{students[index][:cohort]} cohort)".center(20) +
         "#{students[index][:age]}".center(6) +
         "#{students[index][:country]}".center(20)
    index += 1
  end
end

def print_cohorts(students)
  # split the students into different cohorts
  cohorts = {}
  students.each do |s|
    if cohorts[s[:cohort]] == nil then cohorts[s[:cohort]] = []; end
    cohorts[s[:cohort]] << s
  end
  #and now print them
  cohorts.each do |cohort, students|
    puts "-- " + (pluralize("Student", students.count) + " for the #{cohort.to_s.capitalize} cohort:").center(50) +
         "Age".center(6) +
         "Country of Birth".center(20)
    print(students)
    puts
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great " + pluralize("student", names.count)
end

def pluralize(word, number)
  return "#{word}" if (number.to_s[-2..-1] != "11" && number.to_s[-1] == "1")
  "#{word}s"
end

# Start the program!
students = input_students
if (students.length > 0)
  print_header
  print_cohorts(students)
  print_footer(students)
end
