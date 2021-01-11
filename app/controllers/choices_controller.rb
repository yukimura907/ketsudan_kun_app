class ChoicesController < ApplicationController
  def new
    @choice = Choice.new
  end

  def confirm
    @choice = current_user.choices.build(choice_params)
    if @choice.invalid?
      render :new
    end
  end

  def create
    @choice = current_user.choices.build(choice_params)
    options = []
    options.push(@choice.option_1, @choice.option_2)
    @choice.result = options.sample
    if @choice.save
      redirect_to "/choices/result/#{@choice.id}" 
    else
      render :new
    end
  end

  def result
    @choice = Choice.find(params[:id])
  end

  def edit
    @choice = current_user.choices.build(choice_params)
     render :new
  end

  def update
  end

  def destroy
  end

  private
  
  def choice_params
    params.require(:choice).permit(:title, :option_1, :option_2, :result)
  end
end
