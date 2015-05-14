class Blog < ActiveRecord::Base

	belongs_to :user
  has_and_belongs_to_many :categories
  mount_uploader :image, BlogsImageUploader

	validates :title, presence: true
	validates :caption, presence: true
	validates :description, presence: true

end
