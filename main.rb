# main.rb
require "sinatra"
require "sinatra/config_file"
require "./lib/game"
require "./lib/player"
require 'securerandom'
require 'sinatra/twitter-bootstrap'
require 'haml'

use Rack::Session::Pool
config_file './config/items.yml'

get '/' do
  @items = settings.items

  player1_pick = @items.sample
  digest = OpenSSL::Digest.new('sha256')
  key = SecureRandom.hex(64)
  session[:player1_pick] = player1_pick
  session[:secret] = key

  instance = OpenSSL::HMAC.hexdigest('SHA256', key, "spock")
  @hmac_hash = instance.to_s

  erb :index
end


get '/game' do
  player1_pick = session[:player1_pick]
  key = session[:secret]

  digest = OpenSSL::Digest.new('sha256')
  instance = OpenSSL::HMAC.hexdigest('SHA256', key, "spock")
  @hmac_hash = instance.to_s

  session[:player1_pick] = nil
  session[:secret] = nil

  @player1 = Player.new("comp")
  @player1.picks(player1_pick)
  @player2 = Player.new("human")
  @player2.picks(params[:pick])
  game = Game.new(settings.items, @player1, @player2)
  @winner_name = game.winner
  erb :game
end
