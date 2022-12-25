class ToDoPost < ApplicationRecord
  belongs_to:user
  has_many:post_comments, dependent: :destroy
  has_many :favorites, depemdemt: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id:user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @todopost = ToDoPost.where("title like?","#{word}")
    elsif search == "partial_match"
      @todopost = ToDoPost.where(["title like? OR description like?", "%#{word}%", "%#{word}%"])
    else
      @todopost = ToDoPost.all
    end
  end
end
