require 'inesita'

module Inesita
  WebSocket = JS.global.JS['WebSocket']
  Document = JS.global.JS['document']
  Head = Document.JS['head']
  Window = JS.global

  module Component
    alias_method :old_mount_to, :mount_to
    def mount_to(element)
      Window.JS.addEventListener('inesita:refresh', method(:update_dom), false)
      old_mount_to(element)
    end
  end

  class LiveReload
    def initialize
      connect
    end

    def connect
      `
      var ws = new WebSocket('ws://0.0.0.0:23654');
      ws.onmessage = function(e){ #{on_file_change(`e.data`) }}
      ws.onclose = function(e){ setTimeout(function(){ #{connect} }, 1000); }
      `
    end

    def on_file_change(filename)
      prefix, mod, ext = filename.split('|')
      filename = "#{prefix}/#{mod}.self.#{ext}"
      case ext
      when 'js'
        replace_js(filename, mod)
      when 'css'
        replace_css(filename)
      else
        fail Error, "Don't know how to reload #{ext} file!"
      end
    end

    def replace_js(filename, mod)
      s = create_element(:script, type: 'text/javascript', src: filename, onload: lambda do
        Opal.load(mod)
        Window.JS.dispatchEvent(`new Event('inesita:refresh')`)
      end)
      replace_or_append(s, 'script') { |t| t.JS[:src].match(filename) }
    end

    def replace_css(filename)
      s = create_element(:link, rel: 'stylesheet', type: 'text/css', href: filename)
      replace_or_append(s, 'link') { |t| t.JS[:href].match(filename) }
    end

    def create_element(name, attrs = {})
      s = Document.JS.createElement(name)
      s.JS[:onload] = attrs.delete(:onload)
      attrs.each do |k, v|
        s.JS.setAttribute(k, v)
      end
      s
    end

    def replace_or_append(tag, tags, &block)
      tags = Document.JS.getElementsByTagName(tags)
      tags.JS[:length].times do |i|
        next unless block.call(tags.JS.item(i))
        Head.JS.replaceChild(tag, tags.JS.item(i))
        return
      end
      Head.JS.appendChild(tag)
    end
  end
end

Inesita::LiveReload.new
