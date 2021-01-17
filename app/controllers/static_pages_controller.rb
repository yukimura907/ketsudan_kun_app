class StaticPagesController < ApplicationController
  skip_before_action :require_login
  def top
    #if URI(request.referer).path == confirm_choices_path or URI(request.referer).path == confirm_guests_choices_path
      #flash.now[:call] = 'またいつでも来るがよい' 
    #else
      #render :top
    #end 
  end

  def about; end

  def contract; end

  def contact; end

  def policy; end
end
