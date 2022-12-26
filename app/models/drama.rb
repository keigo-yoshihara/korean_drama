class Drama < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :rating, presence: true
  
  has_many :favorites, dependent: :destroy
end
