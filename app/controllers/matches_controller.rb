class MatchesController < ApplicationController
  def new
    @match = Match.new
    @opponent = User.find(params[:user_id])
  end

  def create
    if params[:match][:winner_id] == current_user.id.to_s
      params[:match][:loser_id] = params[:match][:opponent_id]
    else
      params[:match][:loser_id] = current_user.id
    end
    params[:match].delete(:opponent_id)
    puts params
    @match = Match.new(match_params)
    @match.save
    redirect_to root_path
  end

private

  def match_params
    params.require(:match).permit(:winner_id, :loser_id)
  end
end
