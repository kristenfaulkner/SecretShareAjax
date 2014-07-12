# == Schema Information
#
# Table name: friendships
#
#  id            :integer          not null, primary key
#  out_friend_id :integer          not null
#  in_friend_id  :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Friendship < ActiveRecord::Base
  validates_uniqueness_of :out_friend_id, scope: :in_friend_id
  validates :out_friend_id, presence: true
  validates :in_friend_id, presence: true
  
  belongs_to(
    :friend_owner,
    class_name: "User",
    primary_key: :id,
    foreign_key: :in_friend_id
  )
  
  belongs_to(
    :owned_friend,
    class_name: "User",
    primary_key: :id,
    foreign_key: :out_friend_id
  )
  
  def self.find_by_pair(owner, owned)
    Friendship.find_by_in_friend_id_and_out_friend_id(owner.id, owned.id);
  end
  
end
