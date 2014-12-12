class MatchesController < ApplicationController
  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    @match.save
    redirect_to root_path
  end

private

  def match_params
    params.require(:match).permit(:winner_id, :loser_id)
  end
end
