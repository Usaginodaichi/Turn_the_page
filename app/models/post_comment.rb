class PostComment < ApplicationRecord
  belongs_to:user
  belongs_to:to_do_post

  validates :comment,
   presence: true,
   length: {maximum: 100}

end
