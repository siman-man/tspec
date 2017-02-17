# TSpec

[![Build Status](https://travis-ci.org/siman-man/tspec.svg?branch=master)](https://travis-ci.org/siman-man/tspec)

TSpec adds a method of simple type check to Ruby.

:construction: **Recommended for use only in hobby programming. Do not use this in production apps.** :construction:

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tspec'
```

And then execute:

    $ bundle

Or install it by yourself:

    $ gem install tspec

## Usage

TSpec can use `#receive` and `#return` method.


### receive

`receive` defines the type of method arguments.

```ruby
require 'tspec'

def echo(str)
  puts str
end.receive(str: String)

echo('hello world') #=> ok
echo(123)           #=> TSpec::ArgumentTypeError
```

You can specify multiple type, too.

```ruby
require 'tspec'

def echo(val)
  puts val
end.receive(val: [String, Float])

echo('hello')  #=> ok
echo(3.14)     #=> ok
echo(123)      #=> TSpec::ArgumentTypeError
```

If single method argument is given, you can skip keyword.

```ruby
require 'tspec'

def join_array(arr)
  arr.join(' ')
end.receive([String])

puts join_array(%w(hello world)) #=> ok
puts join_array([1,2,3])         #=> TSpec::ArgumentTypeError
```

You can specify Array content type, although it may seem strange.

```ruby
require 'tspec'

def receive_string_array(arr)
  arr.join
end.receive(arr: [[String]])

puts receive_string_array(['hello', 'world']) #=> ok
puts receive_string_array([:hello, :world])   #=> TSpec::ArgumentTypeError
```


### return

`return` defines the type of method return value.

```ruby
require 'tspec'

def message
  'hello world'
end.return(String)

def dummy_message
  'hello world'
end.return(Symbol)

puts message        #=> ok
puts dummy_message  #=> TSpec::ReturnValueTypeError
```

You can specify multiple return value, too.

```ruby
require 'tspec'

def random_val
  [1.0, '1', :hello].sample
end.return(Float, String, Symbol)

10.times do
  v = random_val
end
```

Also, you can specify Array content type.

```ruby
require 'tspec'

def message_list
  %w(hello ruby world)
end.return([String])

p message_list
```

## Example

Combination of `receive` and `return` method.

```ruby
require 'tspec'

def string2symbol(str)
  str.to_sym
end.receive(str: String).return(Symbol)

p string2symbol('hello')  #=> :hello
p string2symbol(123)      #=> TSpec::ArgumentTypeError
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/siman-man/tspec. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available under the terms of the [MIT License](http://opensource.org/licenses/MIT).
