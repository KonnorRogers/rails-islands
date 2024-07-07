class IslandsController < ApplicationController
  def show
    sleep(5) # Used for demo purposes to simulate slow connection.
    @island_name = params[:id]
  end
end
