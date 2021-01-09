class ChoicesController < ApplicationController
  def new
    @choice = Choice.new
  end

  def create
    @choice = current_user.choices.new(choice_params)
    if @choice.save
      flash[:success] = '選択肢を登録しました'
      redirect_to root_path
    else 
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  def confirm
    @choice = Choice.find(params[:id])
  end

  def edit
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
