require 'tspec'

def say_hello(str)
  puts str
end.receive(st: String) #=> undefined `st' variable name

def echo(val)
  puts val
end.receive(val: String)

echo(3.14) #=> echo need String parameter
