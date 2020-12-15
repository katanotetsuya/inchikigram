class Room < ApplicationRecord

  has_many :entries
  has_many :chats

	def self.create_new_room_and_initial_entry(current_user, other_user)
	  room = create!
	  Entry.create!(user_id: current_user.id, room_id: room.id)
	  Entry.create!(user_id: other_user.id, room_id: room.id)
	  room
	end

end
