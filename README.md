# Minitest::Metz

Minitest::Metz is a Minitest plugin that under it's hood hides the [SandiMeter](https://github.com/makaroni4/sandi_meter).
It allows you to easily apply Sandi Metz's [four rules for developers](https://robots.thoughtbot.com/sandi-metz-rules-for-developers)
on your tests.

## Why?

Because tests are code. Especially in Minitest, where each test file is a subclass
of `Minitest::Test`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-metz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-metz

## Usage

There two ways that you can use this plugin:

### `--metz`

You can apply the `--metz` flag when you are running your tests. If present, the
plugin will run the `sandi_meter` for the test that ran.

### `assert_obey_metz`

If you are willing of writing tests around the four rules, you can assert on
them. If you want to test the test class for the four rules:

```ruby
class PersonTest < Minitest::Test
  def test_sandi_four_rules
    assert_obey_metz(self.class)
    # Or..
    assert_obey_metz(PersonTest)
  end
end
```

If you want to test another class:

```ruby
class PersonTest < Minitest::Test
  def test_sandi_four_rules
    assert_obey_metz(Person)
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fteem/minitest-metz.

