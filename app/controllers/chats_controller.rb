class ChatsController < ApplicationController

  def show
  	# どのユーザーとチャットするかを取得。
    @user = User.find(params[:id])

    # カレントユーザーのentryにあるroom_idの値の配列をroomsに代入。
    rooms = current_user.entries.pluck(:room_id)
    # Entryモデルから
    # user_idがチャット相手のidが一致するものと、
    # room_idが上記roomsのどれかに一致するレコードを
    # entriesに代入。
    entries = Entry.find_by(user_id: @user.id, room_id: rooms)

    # もしentriesが空でないなら
    unless entries.nil?
      # @roomに上記entriesのroomを代入
      @room = entries.room
    else
      # それ以外は新しくroomを作り、
      @room = Room.new
      @room.save
      # entryをカレントユーザー分とチャット相手分を作る
      Entry.create(user_id: current_user.id, room_id: @room.id)
      Entry.create(user_id: @user.id, room_id: @room.id)
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
