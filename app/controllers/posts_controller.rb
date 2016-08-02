class PostsController < ApplicationController
  # The below callback sequence should not be altered, as authorization
  # is dependent on it

  before_action :set_blog, only: [:index, :show]
  before_action :set_blog_from_user, only: [:new, :create, :edit, :update,
                                            :destroy, :publish]
  before_action :build_post, only: [:new, :create]
  before_action :set_post_from_user, only: [:edit, :update, :destroy, :publish]
  before_action -> { authorize(@post) }, only: [:new, :create, :edit, :update,
                                                :destroy]

  # GET /blog/1/posts
  # GET /blog/1/posts.json
  def index
    @posts = PostPolicy::Scope.new(current_user, @blog.posts, @blog).resolve
  end

  # GET /blog/1/posts/1
  # GET /blog/1/posts/1.json
  def show
    @post = @blog.posts.friendly.find(params[:id])
    @comments = @post.comments.joins(:user)
    @comment = @post.comments.build
  end

  # GET /blog/1/posts/new
  def new

  end

  # GET /blog/1/posts/1/edit
  def edit
  end

  # POST /blog/1/posts
  # POST /blog/1/posts.json
  def create
    respond_to do |format|
      if @post.save
        format.html { redirect_to blog_post_no_prefix_path(@blog, @post),
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
        format.html { redirect_to blog_post_no_prefix_path(@blog, @post),
                                  notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog/1/posts/1
  # PATCH/PUT /blog/1/posts/1.json
  def publish
    respond_to do |format|
      if @post.publish!
        format.html { redirect_to blog_post_no_prefix_path(@blog, @post),
                                  notice: 'Post was successfully published.' }
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
      format.html { redirect_to blog_posts_no_prefix_path(@blog),
                                notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_blog
      @blog =  Blog.friendly.find(params[:blog_id])
    end

    def set_post_from_user
      @post = current_user.posts.friendly.find(params[:id])
    end

    def set_blog_from_user
      @blog = current_user.blogs.friendly.find(params[:blog_id])
    end

    def build_post
      @post = @blog.posts.build(post_params) do |post|
        post.user = current_user
      end
    end

    # Never trust parameters from the scary internet,
    # only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :published) if params.has_key?(:post)
    end
end
