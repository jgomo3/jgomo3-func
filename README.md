# Jgomo3::Func

By requiring this Gem, some extensions will be applied to Ruby core
classes (similar to what Activesupport does).

The extensions is a collection of methods I find useful for any
project. This is a quick list:

## `then_if` and `then_unless`

Whenever you use `then` guarded by some simple ternary logic, ej:

```
number.then { _1.positive? ? _1 * 1000 : _1 }
```

you can use `then_if` (or `then_unless`):

```
number.then_if(:positive?) { _1 * 1000 }
number.then_if(->(x){ x.positive? }) { _1 * 1000 }
```

`then_if` and `then_unless` receive an argument which will be used as
a function, first by verifying it responds to `call`, lastly, by
trying to convert it to a **Proc**. That's why this method works with
**Symbols**, because they respond to
[to_proc](https://devdocs.io/ruby~2.7/symbol#method-i-to_proc).

## `complement`

Generates a Proc that negates the object if it would have been used as
a function.

```
negative = :positive?.complement
negative.call(1) # => false
negative.call(-1) # => true
```

`complement` will use the receiver as a function first by verifying it
responds to `call` it, lastly, by trying to convert it to a
**Proc**. That's why this method works with **Symbols**, because they
respond to
[to_proc](https://devdocs.io/ruby~2.7/symbol#method-i-to_proc).

## `constantly`
Generates a Proc that always returns it's receiver.

```
constantly_true = true.constantly
constantly_true.call(12345) # => true
constantly_true.call('Hola') # => true
constantly_true.call(nil) # => true
constantly_true.call(Object.new) # => true
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jgomo3-func'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jgomo3-func

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jgomo3-func. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/jgomo3-func/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jgomo3::Func project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/jgomo3-func/blob/master/CODE_OF_CONDUCT.md).
