class PagesController < ApplicationController

	def home
		@blogs = Blog.order("created_at desc").paginate(:page => params[:page], :per_page => 5)
    @blogs = @blogs.where(:is_draft => false)
	end

end
