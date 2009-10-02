#!/usr/bin/env ruby

require 'rubygems'

#require 'chingu'
require File.join("..", "chingu", "lib", "chingu.rb") 

require 'gosu'
include Gosu
include Chingu
require_all "src"

class Game < Chingu::Window
  def initialize
    super(1024, 768)
    Gosu::Image.autoload_dirs << File.join(@root, "media", "backgrounds")
    self.input = { :escape => :close }
    push_game_state(Level)
    #push_game_state(Menu)
    #transitional_game_state(Chingu::GameStates::FadeTo)
	end

  def update
    super
    self.caption = "Triangle Wars [framerate: #{framerate}] [game objects: #{current_game_state.game_objects.size}] Bullets: #{Bullet.size} Enemies: #{Enemy.size}"
  end  
end

Game.new.show
