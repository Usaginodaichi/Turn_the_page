class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


has_one_attached :profile_image

has_many:to_do_posts, dependent: :destroy
has_many:post_comments, dependent: :destroy
has_many:favorites, dependent: :destroy
# relationshipsへの多対多のアソシエーション未設定

def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
end

def self.looks(search, word)
  if search == "perfect_match"
    @user = User.where("nickname LIKE?", "#{word}")
  elsif search == "partial_match"
    @user = User.where("nickname LIKE?", "%#{word}%")
  else
    @user = User.all
  end
end

end
