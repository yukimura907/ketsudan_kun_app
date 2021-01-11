class ChoicesController < ApplicationController
  def new
    @choice = Choice.new
  end

  def confirm
    @choice = current_user.choices.new(choice_params)
    if @choice.invalid?
      render :new
    end
  end

  def create
    @choice = current_user.choices.new(choice_params)
    options = []
    options.push(@choice.option_1, @choice.option_2)
    @result = options.sample
    redirect_to root_path
  end

  def edit
    @choice = current_user.choices.new(choice_params)
     render :new
  end

  def update
  end

  def destroy
  end

  private
  
  def choice_params
    params.require(:choice).permit(:title, :option_1, :option_2)
  end
end
