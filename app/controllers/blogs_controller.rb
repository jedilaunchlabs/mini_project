class BlogsController < ApplicationController

	before_action :set_blog, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

	def index
		@blogs = current_user.blogs.paginate(:page => params[:page], :per_page => 5)
	end


	def show
	end


	def new
		@blog = current_user.blogs.build
	end


	def edit
		set_blog
	end


	def create
		@blog = current_user.blogs.build(blog_params)

		respond_to do |format|
			if @blog.save
				format.html { redirect_to blogs_path, notice: 'Blog was successfully created!' }
				format.json { render :show, status: :created, location: @blog }
			else
				format.html { redirect_to :back }
				format.json { render json: @blog.errors, status: :unprocessable_entity }
			end
	    end
	end


	def update
		respond_to do |format|
			if @blog.update_attributes(blog_params)
				format.html { redirect_to blogs_path, notice: 'Blog was successfully updated!' }
				format.json { render :show, status: :ok, location: @blog }
			else
				format.html { redirect_to :back }
				format.json { render json: @blog.errors, status: :unprocessable_entity }
			end
	    end
	end

	def destroy
		@blog.destroy
	    respond_to do |format|
	      format.html { redirect_to blog_url, notice: 'Blog was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	end


	private

		def set_blog
			@blog = Blog.find(params[:id])
	    end

		def blog_params
	    	params.require(:blog).permit(:title, :caption, :description, :email)
	    end

end
