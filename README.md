# TSpec

[![Build Status](https://travis-ci.org/siman-man/tspec.svg?branch=master)](https://travis-ci.org/siman-man/tspec)

TSpec add simple type check of method into Ruby.

:construction: **Recommended for use only in hobby programming. Do not use this in production apps.** :construction:

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tspec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tspec

## Usage

tspec can use `#receive` and `#return` method.


### receive

`receive` define the type of method arguments.

```ruby
require 'tspec'

def echo(str)
  puts str
end.receive(str: String)
```

specify multiple type.

```ruby
require 'tspec'

def echo(val)
  puts val
end.receive(val: [String, Float])

echo('hello')
echo(3.14)
```

if method arguments is single. it can skip keyword.

```ruby
require 'tspec'

def join_array(arr)
  arr.join(' ')
end.receive([String])

puts join_array(%w(hello world))
```

if specify Array content type. writing is strange.

```ruby
require 'tspec'

def receive_string_array(arr)
  arr.join
end.receive(arr: [[String]])

puts receive_string_array(['hello', 'world'])
```


### return

`return` define the type of method return value.

```ruby
require 'tspec'

def message
  'hello world'
end.return(String)
```

multiple return value.

```ruby
require 'tspec'

def random_val
  [1.0, '1', :hello].sample
end.return(Float, String, Symbol)

10.times do
  v = random_val
end
```

specify Array content type.

```ruby
require 'tspec'

def message_list
  %w(hello ruby world)
end.return([String])

p message_list
```

## Example

combination `receive` and `return` method.

```ruby
require 'tspec'

def string2symbol(str)
  str.to_sym
end.receive(str: String).return(Symbol)

p string2symbol('hello') #=> :hello
p string2symbol(123)     #=> TSpec::ArgumentTypeError
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/siman-man/tspec. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

