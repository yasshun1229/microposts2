class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts # userから見たときにmicropostsは複数あるから
  has_many :relationships # 中間テーブルを参照
  has_many :followings, through: :relationships, source: :follow # フォローしているUserの取得
  has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "follow_id" # フォローされる側から中間テーブルを参照
  has_many :followers, through: :reverses_of_relationship, source: :user # フォロワーのUserの取得
  
  def follow(other_user) 
    unless self == other_user # フォローしようとしているユーザが自分ではないか検証
      self.relationships.find_or_create_by(follow_id: other_user.id) # フォロー関係の保存
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id) # 中間テーブルの定義
    relationship.destroy if relationship # フォローしていれば外す
  end
  
  def following?(other_user)
    self.followings.include?(other_user) # フォローしているUserを取得し、他のユーザが含まれていないか確認
  end
end
