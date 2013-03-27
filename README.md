# Mercury Engine

> The Little Engine That Could

This is a basic content editing system based on [Mercury Editor](http://jejacks0n.github.com/mercury/) and [Active Admin](http://activeadmin.info/).

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

Now update your bundle

```
bundle
```

Then, run the `mercury_engine:install` generator. It will copy over database migrations and will mount the engine in your `config/routes.rb`

```
rails generate mercury_engine:install
```

Also, add the "Edit" link somewhere in your layout, a default partial is provided.

```haml
= render partial: 'mercury_engine/shared/edit_link'
```

Testing
-------

To run tests:

    $ bundle exec rake spec

To run tests with guard (preferred):
    
    $ bundle exec guard
