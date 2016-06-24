puts "File name: " + __FILE__
puts
File.open(__FILE__, "r").each {|line| puts line}
