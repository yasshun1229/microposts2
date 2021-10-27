class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: "User" # 「本当はUserだよ」という意味
end
