class StaticPagesController < ApplicationController
  skip_before_action :require_login
  def top; end

  def about; end

  def contract; end

  def contact; end

  def policy; end
end
