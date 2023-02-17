class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many:to_do_posts, dependent: :destroy
  has_many:post_comments, dependent: :destroy
  has_many:favorites, dependent: :destroy
  has_many:follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many:followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  # ニックネームは一意性を持たせる
  validates :nickname,
   uniqueness: true,
   length: {minimum:2, maximum: 20}

# 自己紹介文、必須にはしない
  validates :introduction,
   length:{maximum: 50}

# 目的、目的達成が主なため入力は必須
  validates :purpose,
   presence: true,
   length:{maximum: 20}

  validates :email, presence: true

  def active_for_authentication?
    super && (is_deleted == false)
  end

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename:'default-image.jpg', content_type:'image/jpeg')
    end
      profile_image.variant(resize_to_limit:[width, height]).processed
  end

  # フルネーム、かなも含めて設定

  def full_name
    last_name + " " + first_name
  end

  def full_name_kana
    last_name_kana + " " + first_name_kana
  end

  # 検索機能、完全一致と部分一致
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("nickname like?", "#{word}")
    elsif search == "partial_match"
      @user = User.where("nickname like?", "%#{word}%")
    else
      @user = User.all
    end
  end
end
