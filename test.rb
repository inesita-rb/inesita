module A
  ['test','cos'].each do |name|
    define_method name do
      puts name
    end
  end
end

module B
  include A
end

module C
  include B
end

class X
  include C
  def initialize
    test
  end
end

X.new



