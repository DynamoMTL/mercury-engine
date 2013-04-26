# Mercury Engine

A basic content editing system based on [Mercury Editor](http://jejacks0n.github.com/mercury/).

[![Travis CI Status](https://travis-ci.org/DynamoMTL/mercury-engine.png)](https://travis-ci.org/DynamoMTL/mercury-engine)

[![Code Climate](https://codeclimate.com/github/DynamoMTL/mercury-engine.png)](https://codeclimate.com/github/DynamoMTL/mercury-engine)

Whats that?
--------

mercury-engine is a lightweight content editing system that makes it easy to add live in-place editing to your site's static pages.

It is designed to fit a workflow where static pages are hand crafted using regular Rails templates/asset pipeline. 

It does not impose any structure on the host application and has minimal requirements. 

### How it works

To make an area of a page editable, simply annotate the area with the `editable` helper.  

If you have a HAML template like this:

```haml
-# in app/views/pages/index.html.haml
%section#main
  %h1 My Cyber Web Page
  :markdown
    All your web belong to us
```

To make it editable, simply annotate it with the helper:

```haml
%section#main
  = editable(:title, :h1) do
    My Editable Cyber Web Page

  = editable(:details) do
    :markdown
      All your web belong to us
```

The first parameter (`:title` and `:details`) is the id, it should be unique per page. 
The second parameter is the optional tag name, defaults to `:div`.

If the user has edited the section, content is served from the database. When there are not edits, the content inside the block is used.

Optional html attributes can also be passed:

```haml
= editable(:nav, class: 'retro')
```

The helper also supports Mercury's other content types:

```haml
= editable(:title,   :h1,  type: :simple) # only allow text in h1
= editable(:details, :div, type: :full)   # allow any markup inside div
```

Most of the time you wont need to explicitly declare the `:type` because the helper can determine `:type` for common tags.
The following tags are considered simple: h1, h2, h3, h4, h5, h6, a, span, label

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

Now, update your bundle:

```bash
bundle
```

Then, run the `mercury_engine:install` generator. 
It will copy over database migrations and will mount the engine in your `config/routes.rb` file.

```
rails generate mercury_engine:install
```

Also, add the "Edit" link somewhere in your layout. 
The engine provides a partial that will only show the link when an admin is logged in.

```haml
= render partial: 'mercury_engine/shared/edit_link'
```
# And - you're done.
coffee break? 

Testing
-------

Clone the repo:

    $ hub clone DynamoMTL/mercury-engine && cd mercury-engine

To run tests:

    $ bundle exec rake spec

To run tests with guard (preferred):

    $ bundle exec guard
