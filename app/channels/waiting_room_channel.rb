class WaitingRoomChannel < ApplicationCable::Channel
  # Called when the consumer has successfully
  # become a subscriber of this channel.
  def subscribed
    stream_from 'waiting_room_channel'
  end
end
