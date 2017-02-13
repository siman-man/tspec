require 'tspec'

def message
  'hello'
end.return(Float)

def string_or_float
  ['hello', 3.14].sample
end.return(String, Regexp)

def message_list
  %w(hello ruby world)
end.return(String)

p message_list
