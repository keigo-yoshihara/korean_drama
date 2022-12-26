class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :dramas, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_dramas, through: :favorites, source: :drama
  
  def favorite(other_drama)
    self.favorites.find_or_create_by(drama_id: other_drama.id)
  end
  
  def unfavorite(other_drama)
    favorite = self.favorites.find_by(drama_id: other_drama.id)
    favorite.destroy if favorite
  end
  
  def favorite?(other_drama)
    self.fav_dramas.include?(other_drama)
  end
end
