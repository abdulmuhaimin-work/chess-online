class VoteBroadcastJob < ApplicationJob
  queue_as :default

  def perform(user)
    ActionCable.server.broadcast 'votes_channel',  user_id: user.id, value: user.total_votes
  end
end
