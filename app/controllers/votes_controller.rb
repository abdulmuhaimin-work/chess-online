class VotesController < ApplicationController
  respond_to :js
  before_action :create_vote

  def upvote
    update_vote(1)
    flash[:success] = "you've +1"
    VoteBroadcastJob.perform_later("upvote", @vote)
  end

  def downvote
    update_vote(-1)
    flash[:success] = "you've -1"
    VoteBroadcastJob.perform_later("downvote", @vote)
  end

  private

  def create_vote
    @vote = current_user.votes.create
  end

  def update_vote(value)
    @vote.update(value: value)
    VoteBroadcastJob.perform_later(@vote.user)
  end
end
