class BlogsController < ApplicationController

  before_action :set_blog, only: [:show, :edit, :update, :destroy]
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
    @blog = current_user.blogs.build(blog_params)

    respond_to do |format|
      if @blog.save

        params[:categories].each do |category|
          @blogs_category = BlogsCategory.create({ blog_id: @blog.id, category_id: category.to_i })
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
              @blogs_category = BlogsCategory.create({ blog_id: @blog.id, category_id: category.to_i })
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
        params.require(:blog).permit(:title, :caption, :description, :email)
      end

end
