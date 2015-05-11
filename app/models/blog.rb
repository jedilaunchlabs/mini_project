class Blog < ActiveRecord::Base

	belongs_to :user
	validates :title, presence: true
	validates :caption, presence: true
	validates :description, presence: true

end
