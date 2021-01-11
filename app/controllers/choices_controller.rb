class ChoicesController < ApplicationController
  before_action :set_choice_instance, only: [:confirm, :create, :edit]
  before_action :result_throuth_confirm?, only: [:result]

  def new
    @choice = Choice.new
  end

  def confirm
    if @choice.invalid?
      render :new
    end
  end

  def create
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
     render :new
  end

  def update
  end

  def destroy
  end

  private
  
  def set_choice_instance
    @choice = current_user.choices.build(choice_params)
  end

  def result_throuth_confirm?
    if request.referer.nil?
      redirect_to new_choice_path 
      flash[:danger] = 'お題と選択肢を入力してください'
    end
  end

  def choice_params
    params.require(:choice).permit(:title, :option_1, :option_2, :result)
  end
end
