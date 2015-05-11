class PagesController < ApplicationController

	def home
		@blogs = Blog.paginate(:page => params[:page], :per_page => 5)
	end

end
