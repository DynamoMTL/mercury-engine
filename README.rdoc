# Mercury Engine

> The Little Engine That Could

Installation
------------
Add `mercury_engine` to your Gemfile:

```ruby
gem "mercury_engine"
```

Alternatively you can use the git repo directly:

```ruby
gem "mercury_engine", git: "git://github.com/DynamoMTL/mercury-engine.git"
```

Then, run bundler

```
bundle
```

And dont forget to install migrations

```
rake mercury_engine:install:migrations
```

Testing
-------

To run tests:

    $ bundle exec rake spec

To run tests with guard (preferred):
    
    $ bundle exec guard
