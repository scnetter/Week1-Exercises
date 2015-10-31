def say(msg)
  puts "=> #{msg}"
end

say "What's the first number?"
num1 = gets.chomp

say "What's the second number?"
num2 = gets.chomp


say "1) add 2) subtract 3) multiply 4) divide"
operator = gets.chomp.to_i

operation = ["add", "subtract", "multiply", "divide"]


puts "You entered Numbers: #{num1} and #{num2} and you chose to #{operation[operator -1]}"

case operator.to_s

when '1'
    result = num1.to_i + num2.to_i
when '2'
    result = num1.to_i - num2.to_i
when '3'
    result = num1.to_i * num2.to_i
when '4'
    result = num1.to_i / num2.to_i
else
    result = "You entered an invalid operation."
end


puts result     