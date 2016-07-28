class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_blog, only: [:new, :create, :edit, :update, :destroy]

  # GET /blog/1/posts
  # GET /blog/1/posts.json
  def index
    @blog =  Blog.friendly.find(params[:blog_id])
    @posts = @blog.posts
  end

  # GET /blog/1/posts/1
  # GET /blog/1/posts/1.json
  def show
    @blog = Blog.friendly.find(params[:blog_id])
    @post = @blog.posts.friendly.find(params[:id])
  end

  # GET /blog/1/posts/new
  def new
    @post = @blog.posts.build do |post|
        post.user = current_user
    end
  end

  # GET /blog/1/posts/1/edit
  def edit
  end

  # POST /blog/1/posts
  # POST /blog/1/posts.json
  def create
    @post = @blog.posts.build(post_params) do |post|
      post.user = current_user
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to blog_post_path(@blog, @post),
                                  notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog/1/posts/1
  # PATCH/PUT /blog/1/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to blog_post_path(@blog, @post),
                                  notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog/1/posts/1
  # DELETE /blog/1/posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to blog_posts_url(@blog),
                                notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.friendly.find(params[:id])
    end

    def set_blog
      @blog = current_user.blogs.friendly.find(params[:blog_id])
    end

    # Never trust parameters from the scary internet,
    # only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
