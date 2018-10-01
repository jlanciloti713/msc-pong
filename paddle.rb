class Paddle
    attr_accessor :x, :y, :score
    def initialize(x, y)
        @image = Gosu::Image.new('images/pong_paddle.png')
        @x = x
        @y = y
        @velocity = 0.0
        @score = 0
        @acceleration = 1.0
        @friction = 0.9
    end
    def accelerate_up
        @velocity -= @acceleration
    end

    def accelerate_down
        @velocity += @acceleration  
    end

    def move
        @y += @velocity
        @velocity *= @friction

        if  @y <= 0 
            @velocity = 0.0 
            @y = 0   
        elsif @y >= 355
            @velocity = 0
            @y = 355
        end
    end
    def draw
        @image.draw(@x, @y, 2)
    end 
end

