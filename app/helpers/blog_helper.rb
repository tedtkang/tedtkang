module BlogHelper

  # If we're currently on a blog page.
  def on_blog
    session[:user_id] = user.id
  end  
end
