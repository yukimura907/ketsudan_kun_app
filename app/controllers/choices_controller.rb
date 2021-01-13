class ChoicesController < ApplicationController
  before_action :set_choice_instance, only: [:confirm, :create, :edit]
  before_action :result_throuth_confirm?, only: [:result]
  before_action :today_choices_too_many?, only: [:new, :result]
  def new
    @choice = Choice.new
  end

  def confirm
    render :new if @choice.invalid?
  end

  def create
    options = []
    options.push(@choice.option_1, @choice.option_2, @choice.option_3, @choice.option_4, @choice.option_5)
    options.compact!
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

  def alert; end

  def edit
    render :new
  end

  def update; end

  def destroy; end

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

  def today_choices_too_many?
    redirect_to alert_choices_path if current_user.count_today_choices > 5
  end

  def choice_params
    params.require(:choice).permit(:title, :option_1, :option_2, :option_3, :option_4, :option_5, :result)
  end
end
