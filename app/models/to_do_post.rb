class ToDoPost < ApplicationRecord
  belongs_to:user
  has_many:post_comments, dependent: :destroy

  def self.looks(search, word)
    if search == "perfect_match"
      @todopost = ToDoPost.where("title LIKE?","#{word}")
    elsif search == "partial_match"
      @todopost = ToDoPost.where("title LIKE? OR description LIKE?", "%#{word}%")
    else
      @todopost = ToDoPost.all
    end
  end
end
