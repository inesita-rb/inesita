module Inesita
  class AppFilesListener
    include Singleton
    CURRENT_DIR = Dir.pwd

    def initialize
      @websockets = []
      listener = Listen.to(Config::APP_DIR) do |modified, added, _removed|
        (modified + added).each do |file|
          @websockets.each do |ws|
            ws.send transform_filename(file)
          end
        end
      end
      listener.start
    end

    def add_ws(ws)
      @websockets << ws
    end

    def rm_ws(ws)
      @websockets.delete(ws)
    end

    def transform_filename(filename)
      filename.sub!(CURRENT_DIR, '')
      path = filename.split('/')
      path.delete('')
      path.delete(Config::APP_DIR)
      path = path.join('/').split('.')

      prefix = Config::ASSETS_PREFIX
      name = path.first
      ext = case path
            when /rb|js/
              'js'
            when /sass|css/
              'css'
            end
      "#{prefix}|#{name}|#{ext}"
    end
  end
end
