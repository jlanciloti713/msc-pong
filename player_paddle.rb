require_relative('paddle')

class PlayerPaddle < Paddle
    def initialize(x, y)
        super(x, y)
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
end