class PostComment < ApplicationRecord
  belongs_to:user
  belongs_to:to_do_post
end
