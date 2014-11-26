class RankingsController < ApplicationController
  def index
    @players = User.leaders
  end
end
