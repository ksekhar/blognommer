require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @blog = blogs(:one)
  end

  test "should get index" do
    get blog_posts_url(@blog)
    assert_response :success
  end

  test "should get new" do
    get new_blog_post_url(@blog)
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post blog_posts_url(@blog), params: { post:
                                                { content: @post.content,
                                                  published: @post.published,
                                                  title: @post.title,
                                                  slug: @post.slug + rand(1..9999).to_s,
                                                  user_id: @post.user_id,
                                                  views: @post.views } }
    end

    assert_redirected_to blog_post_url(@blog, Post.last)
  end

  test "should show post" do
    get blog_post_url(@blog, @post)
    assert_response :success
  end

  test "should get edit" do
    get edit_blog_post_url(@blog, @post)
    assert_response :success
  end

  test "should update post" do
    patch blog_post_url(@blog, @post), params: { post: { content: @post.content, published: @post.published, title: @post.title, slug: @post.slug, user_id: @post.user_id, views: @post.views } }
    assert_redirected_to blog_post_url(@blog, @post)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete blog_post_url(@blog, @post)
    end

    assert_redirected_to blog_posts_url(@blog)
  end
end
