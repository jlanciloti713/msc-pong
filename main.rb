require 'gosu'
require_relative('player_paddle')
require_relative('enemy_paddle')
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
            @player.draw
            @enemy.draw
            @ball.draw
            @font.draw("#{@player.score}", 160, 20, 2)
            @font.draw("#{@enemy.score}", 480, 20, 2)
        else
            @font.draw("#{@game_message}", 285, 150, 2)
            @font.draw("Press the spacebar to start a new game, or ESC to quit.", 45, 200, 2)
        end
    end

    def update
        if @game_in_progress
            @player.accelerate_up if button_down?(Gosu::KbW)
            @player.accelerate_down if button_down?(Gosu::KbS)
            @enemy.accelerate_up if button_down?(Gosu::KbUp)
            @enemy.accelerate_down if button_down?(Gosu::KbDown)
            @player.move
            @ball.move(@player, @enemy)
            @enemy.move
            score_enemy_point if @ball.x + @ball.radius <= 0
            score_player_point if @ball.x - @ball.radius >= 640
        end
    end

    def button_down(id)
        start_game if id == Gosu::KbSpace && @game_in_progress != true
        self.close if id == Gosu::KbEscape
    end

    def start_game
        @player = PlayerPaddle.new(15, 200)
        @enemy = EnemyPaddle.new(614, 200)
        @ball = Ball.new(@player.x + 17, @player.y + 22, 5.0, -5.0)
        @game_in_progress = true

    end

    def score_enemy_point
        @enemy.score += 1
        @score_sound.play
        @ball = Ball.new(@player.x + 17, @player.y + 22, 5.0, 5.0)
        if @enemy.score == 10
            @game_in_progress = false
            @game_message = "Player 2 is VICTORIOUS"
        end
    end

    def score_player_point
        @player.score += 1
        @score_sound.play
        @ball = Ball.new(@enemy.x - 5, @enemy.y + 22, 5.0, 5.0)
        if @player.score == 10
            @game_in_progress = false
            @game_message = "Player 1 has ASCENDED"
        end
    end
        
end 

pong = Pong.new
pong.show