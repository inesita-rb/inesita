# Inesita [![Gem Version](https://badge.fury.io/rb/inesita.svg)](http://badge.fury.io/rb/inesita) [![Code Climate](https://codeclimate.com/github/fazibear/opal-virtual-dom/badges/gpa.svg)](https://codeclimate.com/github/fazibear/inesita)

!!! WORK IN PROGRESS !!!

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

class CounterNumber
  include Inesita::Component
  attr_accessor :number

  def initialize
    @number = 0
  end

  def random_style
    {
      color: %w(red green blue).sample
    }
  end

  def reset
    @number = 0
    update
  end

  def render
    span style: random_style, onclick: -> { reset } do
      text number
    end
  end
end

class Counter
  include Inesita::Component
  attr_reader :count
  component :number, CounterNumber.new

  def initialize
    @count = 0
  end

  def inc
    number.number += 1
    update
  end

  def dec
    number.number -= 1
    update
  end

  def render
    div do
      button onclick: -> { dec } do
        text '-'
      end
      component number
      button onclick: -> { inc } do
        text '+'
      end
    end
  end
end

$document.ready do
  Counter.new.mount($document.body)
end
```
