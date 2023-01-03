class ToDoPost < ApplicationRecord
  has_one_attached :image

  belongs_to:user
  has_many:post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

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

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
