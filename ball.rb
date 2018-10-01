class Ball
    attr_accessor :x, :y, :radius

    def initialize(x, y, velocity_x, velocity_y)
        @image = Gosu::Image.new('images/pong_ball.png')
        @wall_collision_sound = Gosu::Sample.new('sounds/pong_wall_collision.ogg')
        @paddle_collision_sound = Gosu::Sample.new('sounds/pong_paddle_collision.ogg')
        @x = x
        @y = y
        @velocity_x = velocity_x
        @velocity_y = velocity_y
        @radius = 5
    end
    
    def draw
        @image.draw_rot(@x, @y, 2, 0)
    end

    def move(player_1, player_2)
        if @x - @radius <= player_1.x + 11 && @y + @radius > player_1.y && @y - @radius < player_1.y + 45
            @velocity_x = 5.0
            @paddle_collision_sound.play
        elsif @x + @radius >= player_2.x && @y + @radius > player_2.y && @y - @radius < player_2.y + 45
            @velocity_x = -5.0
            @paddle_collision_sound.play
        elsif @y - @radius <= 0
            @velocity_y = 5.0
            @wall_collision_sound.play
        elsif @y + @radius >= 400
            @velocity_y = -5.0
            @wall_collision_sound.play
        end



        @x += @velocity_x
        @y += @velocity_y
        
    end

end