#!/usr/bin/env ruby

require 'rubygems'
require File.join("..", "chingu", "lib", "chingu.rb") #require 'chingu'
require 'gosu'
include Gosu
include Chingu
require_all "src"

#
# When a missing method is called on an array...
# .. Go through each item in the array and call that method on the items.
#
class Set
	def collide_by_radius(items = [])
		self.each do |item|
			items.each do |item2|
				if distance(item.x, item.y, item2.x, item2.y) < item.radius
					yield item, item2
				end
			end
		end
	end

	def method_missing(method, *arg)
		self.each { |item| item.send(method, *arg) }
	end
end

class Array
	def collide_by_radius(items = [])
		self.each do |item|
			items.each do |item2|
				if distance(item.x, item.y, item2.x, item2.y) < item.radius
					yield item, item2
				end
			end
		end
	end

	def method_missing(method, *arg)
		self.each { |item| item.send(method,  *arg) }
	end
end

class Game < Chingu::Window
  def initialize
    super(1024, 768)
    Gosu::Image.autoload_dirs << File.join(@root, "media", "backgrounds")
    self.input = { :escape => :close }
    push_game_state(Menu)
    transitional_game_state(Chingu::GameStates::FadeTo)
	end

  def update
    super
    self.caption = "Triangle Wars [framerate: #{framerate}] [game objects: #{current_game_state.game_objects.size}]"
  end  
end

Game.new.show
