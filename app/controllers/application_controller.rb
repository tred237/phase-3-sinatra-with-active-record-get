class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/games' do
    # get all the games from the database
    # return a JSON response with an array of all the game data
    Game.all.to_json
  end

  get '/games/:id' do
    # look up the game in the database using its ID
    # send a JSON-formatted response of the game data
    Game.find(params[:id]).to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end
end
