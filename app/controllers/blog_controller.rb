class BlogController < ApplicationController
  def home
    @current_post = Post.last
    @posts = Post.all.reject{ |p| p == Post.last }
  end

  def archives
    @posts = Post.all.order('created_at DESC')
  end



end
