class BlogImageString < StringIO
  attr_accessor :original_filename, :content_type
end 

class BlogsController < ApplicationController

  require 'base64'

  before_action :set_blog, only: [:show, :edit, :update]
  before_filter :authenticate_user!, except: [:show]


  def index
    @blogs = current_user.blogs.order("created_at desc").paginate(:page => params[:page], :per_page => 5)
  end


  def show
    set_blog
  end


  def new
    @blog = current_user.blogs.build
    @categories = Category.all
  end


  def edit
    set_blog
    @categories = Category.all
  end


  def create
    image = params[:image]

    @blog = current_user.blogs.build(blog_params)

    respond_to do |format|
      if @blog.save

        if image.present?
          image64 = image.split(",").second
          io = BlogImageString.new(Base64.decode64(image64))
          io.original_filename = "foobar.png"
          io.content_type = "image/png"
          @blog.image = io
          @blog.save
        end

        if params[:categories].present?
          params[:categories].each do |category|
            @blog_category = BlogsCategory.create({ blog_id: @blog.id, category_id: category.to_i })
          end
        end

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
        if params[:categories].present?
          @blogs_category = BlogsCategory.select("blog_id").where("blog_id = ? AND category_id NOT IN (?)", @blog.id, params[:categories])

          if @blogs_category.present?
            @blogs_category.delete_all
          end

          params[:categories].each do |category|
            @blogs_category = BlogsCategory.select("blog_id").where("blog_id = ? AND category_id IN (?)", @blog.id, category.to_i)
            unless @blogs_category.present?
              @blog_category = BlogsCategory.create({ blog_id: @blog.id, category_id: category.to_i })
            end
          end
        else
          @blogs_category = BlogsCategory.select("blog_id").where("blog_id = ?", @blog.id).delete_all
        end
        
        format.html { redirect_to blogs_path, notice: 'Blog was successfully updated!' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { redirect_to :back }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end

  end


  private

    def set_blog
      @blog = Blog.find(params[:id])
      end

    def blog_params
        params.require(:blog).permit(:title, :caption, :description)
      end

end
