# Mercury Engine

> The Little Engine That Could

A basic content editing system based on [Mercury Editor](http://jejacks0n.github.com/mercury/) and [Active Admin](http://activeadmin.info/).

Overview
--------

mercury-engine is a lightweight content editing system that makes it easy to add live in-place editing to your site's static pages.

It is designed to fit a workflow where static pages are hand crafted using regular rails templates and asset pipeline. It does not impose any structure. 

To make an area of a page editable, simply annotate the area with the `editable` helper.

### Example

```haml
section#main
  %h1 My Cyber Web Page
```

becomes

```haml
section#main
  = editable(:title, :h1) do
    My Cyber Web Page
```

Installation
------------
Add `mercury_engine` to your Gemfile:

```ruby
gem 'mercury_engine'
```

Alternatively you can use the git repo directly:

```ruby
gem 'mercury_engine', github: 'DynamoMTL/mercury-engine'
```

Now update your bundle

```bash
bundle
```

Then, run the `mercury_engine:install` generator. It will copy over database migrations and will mount the engine in your `config/routes.rb`

```
rails generate mercury_engine:install
```

Also, add the "Edit" link somewhere in your layout. The engine provides a partial that will only show the link when an admin is logged in.

```haml
= render partial: 'mercury_engine/shared/edit_link'
```

Testing
-------

Clone the repo:

    $ hub clone DynamoMTL/mercury-engine && cd mercury-engine

To run tests:

    $ bundle exec rake spec

To run tests with guard (preferred):

    $ bundle exec guard
