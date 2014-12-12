class MatchesController < ApplicationController
  def new
    @match = Match.new
  end

  def create
    if params[:match][:winner_id] == current_user.id.to_s
      params[:match][:loser_id] = params[:match][:user_id].to_s
    else
      params[:match][:loser_id] = current_user.id.to_s
    end
    @match = Match.new(match_params)
    @match.save
    redirect_to root_path
  end

private

  def match_params
    params.require(:match).permit(:winner_id, :loser_id)
  end
end
