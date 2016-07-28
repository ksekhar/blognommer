class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @blog =  current_user.blogs.friendly.find(params[:blog_id])
    @posts = @blog.posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @blog = current_user.blogs.friendly.find(params[:blog_id])
    @post = @blog.posts.build do |post|
        post.user = current_user
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @blog = current_user.blogs.friendly.find(params[:blog_id])
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

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
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
      @blog = current_user.blogs.friendly.find(params[:blog_id])
      @post = current_user.posts.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet,
    # only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
