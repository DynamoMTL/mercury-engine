# Mercury Engine

> The Little Engine That Could

A basic content editing system based on [Mercury Editor](http://jejacks0n.github.com/mercury/) and [Active Admin](http://activeadmin.info/).

Overview
--------

mercury-engine is a lightweight content editing system that makes it easy to add live in-place editing to your site's static pages.

It is designed to fit a workflow where static pages are hand crafted using regular rails templates and asset pipeline. It does not impose any structure on the host application and has minimal requirements. 

### Examples

To make an area of a page editable, simply annotate the area with the `editable` helper.  

if you have a HAML template like this:

```haml
-# in app/views/pages/index.html.haml
%section#main
  %h1 My Cyber Web Page
  :markdown
    All your web belong to us
```

it becomes:

```haml
%section#main
  = editable(:title, :h1) do
    My Editable Cyber Web Page

  = editable(:details) do
    :markdown
      All your web belong to us
```

The first parameter `:title` and `:details` are the section names. The second parameter is the optional tag name, assumed to be a `div`  

The markup inside the block is the default content for the section. If there is newer content in the database, the newer content is displayed

You can also pass additional parameters

```haml
= editable(:nav, class: 'retro')
```

The helper also supports Mercury's content types.

```haml
= editable(:title,   :h1,  type: :simple) # only allow text in h1
= editable(:details, :div, type: :full)   # allow any markup inside div
```

Most of the time you dont need to explicitly pass the `:type` because the helper can determine it for common tags

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
