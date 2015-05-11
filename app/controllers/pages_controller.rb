class PagesController < ApplicationController

	def home
		@blogs = Blog.where(:is_draft => false, :is_archived => false).order("created_at desc").paginate(:page => params[:page], :per_page => 5)
	end

end
