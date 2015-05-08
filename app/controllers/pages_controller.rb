class PagesController < ApplicationController

	def home
		# @blogs = current_user.blogs.paginate(:page => params[:page], :per_page => 5)
		# redirect_to blogs_path
	end

end
