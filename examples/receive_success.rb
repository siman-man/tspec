require 'tspec'

def echo(val)
  puts val
end.receive(val: [String, Float])

echo('hello')
echo(3.14)
