class BlogController < ApplicationController

  # The blog home will alway show the latest blog post.
  def home
    @post = Post.last
  end

  # The previous page is passed an id of a blog post (most likely not the current one)
  # It will then display it if the id is valid else it will go to the blog home.
  def previous
    id = params[:id]
    @post = Post.find_by_id(params[:id]) 
    if @post == nil
      redirect_to b_path
    end
  end

  def archives
    @posts = Post.all.order('created_at DESC')
  end





end
