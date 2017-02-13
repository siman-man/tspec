require 'tspec'

def message
  'hello'
end.return(String)

def string_or_float
  ['hello', 3.14].sample
end.return(String, Float)

def message_list
  %w(hello ruby world)
end.return([String])

p message_list
