require 'inesita'

module Inesita
  module Component
    alias_method :old_mount_to, :mount_to
    def mount_to(element)
      JS.global.JS.addEventListener('inesita:refresh', method(:update_dom), false)
      old_mount_to(element)
    end
  end

  class LiveReload

    webSocket = JS.global.JS["WebSocket"]

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
      `
      var s = document.createElement('script');
      s.setAttribute("type","text/javascript");
      s.setAttribute("src", filename);
      s.onload = function(){
        Opal.load(mod)
        window.dispatchEvent(new Event('inesita:refresh'));
      };
      var scripts = document.getElementsByTagName('script');
      for(var i = 0; i < scripts.length; ++ i){
        if(scripts[i].src.match(filename)){
          return document.head.replaceChild(s, scripts[i]);
        }
      }
      document.head.appendChild(s);
      `
    end

    def replace_css(filename)
      `
      var s = document.createElement('link');
      s.setAttribute("rel", "stylesheet");
      s.setAttribute("type", "text/css");
      s.setAttribute("href", filename);
      var links = document.getElementsByTagName('link');
      for(var i = 0; i < links.length; ++ i){
        if(links[i].href.match(filename)){
          return document.head.replaceChild(s, links[i]);
        }
      }
      document.head.appendChild(s);
      `
    end
  end
end

Inesita::LiveReload.new
