class Paddle
    attr_accessor :x, :y, :score
    def initialize(x, y)
        @image = Gosu::Image.new('images/pong_paddle.png')
        @x = x
        @y = y
        @velocity = 0.0
        @score = 0
    end

    def draw
        @image.draw(@x, @y, 2)
    end 
end

