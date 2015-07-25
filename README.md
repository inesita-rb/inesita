# Inesita [![Gem Version](https://badge.fury.io/rb/inesita.svg)](http://badge.fury.io/rb/inesita) [![Code Climate](https://codeclimate.com/github/fazibear/opal-virtual-dom/badges/gpa.svg)](https://codeclimate.com/github/fazibear/inesita)

Frontend web framework for Opal

## requiments

This wrapper require to load [virtual-dom](https://github.com/Matt-Esch/virtual-dom) first. For example you can use rails assets.

```ruby
source 'https://rails-assets.org' do
  gem 'rails-assets-virtual-dom'
end
```

## usage

Server side (config.ru, Rakefile, Rails, Sinatra, etc.)

```ruby
require 'inesita'
```

Browser side

```ruby
require 'opal'
require 'virtual-dom' # required by opal-virtual-dom javascript library
require 'browser'     # not required
require 'inesita'

class Counter
  include Inesita::Component
  attr_reader :count

  def initialize(elements)
    @count = 0
  end

  def inc
    @count += 1
    update
  end

  def dec
    @count -= 1
    update
  end

  def random_style
    {
      color: %w(red green blue).sample
    }
  end

  def render
    virtual_dom do
      div do
        button onclick: -> { dec } do
          text '-'
        end
        span style: random_style do
          text count
        end
        button onclick: -> { inc } do
          text '+'
        end
      end
    end
  end
end

$document.ready do
  Counter.new.mount($document.body)
end
```
