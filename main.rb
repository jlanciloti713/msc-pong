require 'gosu'
require_relative('player1_paddle')
require_relative('player2_paddle')
require_relative('ball')

class Pong < Gosu::Window
    def initialize
        super(640, 400)
        self.caption = "Pong!"
        @background = Gosu::Image.new("images/pong_background.png")
        @font = Gosu::Font.new(24)
        @score_sound = Gosu::Sample.new('sounds/pong_score.ogg')
        @game_message = "Pong!"
        @game_in_progress = false
    end

    def draw
        if @game_in_progress
            @background.draw(0, 0, 1)
            @player_1.draw
            @player_2.draw
            @ball.draw
            @font.draw("#{@player_1.score}", 160, 20, 2)
            @font.draw("#{@player_2.score}", 480, 20, 2)
        else
            @font.draw("#{@game_message}", 285, 150, 2)
            @font.draw("Press the spacebar to start a new game, or ESC to quit.", 45, 200, 2)
        end
    end

    def update
        if @game_in_progress
            @player_1.accelerate_up if button_down?(Gosu::KbW)
            @player_1.accelerate_down if button_down?(Gosu::KbS)
            @player_2.accelerate_up if button_down?(Gosu::KbUp)
            @player_2.accelerate_down if button_down?(Gosu::KbDown)
            @player_1.move
            @ball.move(@player_1, @player_2)
            @player_2.move
            score_player2_point if @ball.x + @ball.radius <= 0
            score_player1_point if @ball.x - @ball.radius >= 640
        end
    end

    def button_down(id)
        start_game if id == Gosu::KbSpace && @game_in_progress != true
        self.close if id == Gosu::KbEscape
    end

    def start_game
        @player_1 = PlayerOnePaddle.new(15, 200)
        @player_2 = PlayerTwoPaddle.new(614, 200)
        @ball = Ball.new(@player_1.x + 17, @player_1.y + 22, 5.0, -5.0)
        @game_in_progress = true

    end

    def score_player2_point
        @player_2.score += 1
        @score_sound.play
        @ball = Ball.new(@player_2.x + 17, @player_2.y + 22, 5.0, 5.0)
        if @player_2.score == 10
            @game_in_progress = false
            @game_message = "Player 2 is VICTORIOUS"
        end
    end

    def score_player1_point
        @player_1.score += 1
        @score_sound.play
        @ball = Ball.new(@player_1.x - 5, @player_1.y + 22, 5.0, 5.0)
        if @player_1.score == 10
            @game_in_progress = false
            @game_message = "Player 1 has ASCENDED"
        end
    end
        
end 

pong = Pong.new
pong.show