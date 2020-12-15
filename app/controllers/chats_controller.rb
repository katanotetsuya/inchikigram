class ChatsController < ApplicationController

  def show
    @user = User.find(params[:id])
    room_ids = current_user.entries.pluck(:room_id)
    entry = Entry.find_by(user_id: @user.id, room_id: room_ids)
    @room = unless entry.nil?
              entry.room
            else
              Room.create_new_room_and_initial_entry(current_user, @user)
            end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    redirect_to request.referer
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
