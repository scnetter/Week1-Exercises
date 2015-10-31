def say(msg)
  puts "=> #{msg}"
end
operator = ''
loop do
  say "What's the first number?"
  num1 = gets.chomp

  say "What's the second number?"
  num2 = gets.chomp


  say "1) Addition 2) Subtraction 3) Multiplication 4) Division"
  operator = gets.chomp.to_i

  operation = ["add", "subtract", "multiply", "divide"]


  puts "You entered Numbers: #{num1} and #{num2} and you chose to #{operation[operator - 1]}"


  case operator.to_s

  when '1'
      result = num1.to_i + num2.to_i
  when '2'
      result = num1.to_i - num2.to_i
  when '3'
      result = num1.to_i * num2.to_i
  when '4'
    if num2.to_i == 0
      result = "You cannot divide by zero!"
    else
      result = num1.to_f / num2.to_f
    end
  else
      result = "You entered an invalid operation."
  end


  puts "\n\n The answer is: #{result}." 
  puts "Do another problem?[\'n\' to exit, anything else to continue]:" 
  if gets.chomp.downcase == 'n' then break end 

end
