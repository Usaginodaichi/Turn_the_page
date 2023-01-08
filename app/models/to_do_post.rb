class ToDoPost < ApplicationRecord
  has_one_attached :image

  belongs_to:user
  has_many:post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :description,
   presence: true,
   length: {minimum: 5, maximum: 200}

  validates :status, inclusion: { in: [true, false] }

  # 終了日は開始日より前の日付で登録できないようにする
  validate :start_end_check

  def start_end_check
    errors.add(:end_date, "は開始日より前の日付は登録できません。")unless
    self.start_date < self.end_date
  end

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
      file_path = Rails.root.join('app/assets/images/ToDoPost_no_image.sample.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
