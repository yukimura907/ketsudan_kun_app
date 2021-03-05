class ChoicesController < ApplicationController
  before_action :set_choice_instance, only: [:confirm, :create, :edit]
  before_action :result_throuth_confirm?, only: [:result]
  before_action :today_choices_too_many?, only: [:new]
  before_action :twitter_client, only: [:create]
  before_action :require_login
  def new
    @choice = Choice.new
  end

  def show
    @choice = Choice.find(params[:id])
  end

  def index
    @choices = Choice.page(params[:page]).per(20).includes(:user).order(created_at: :desc)
  end

  def confirm
    render :new if @choice.invalid?
  end

  def create
    decide_result
    if params[:back]
      render :new
    elsif @choice.save
      @client.update("#{current_user.name}は、\r#{@choice.title}に対して、\r#{@choice.result}ことを決めた！！！！")
      flash[:success] = '新たな決断が下されました。'
      redirect_to "/choices/result/#{@choice.id}"
    end
  end

  def result
    @choice = Choice.find(params[:id])
  end

  def alert; end

  def edit
    render :new
  end

  private

  def set_choice_instance
    return if current_user.nil?

    @choice = current_user.choices.build(choice_params)
  end

  def result_throuth_confirm?
    return if request.referer.present?

    redirect_to new_choice_path
    flash[:danger] = 'お題と選択肢を入力してください'
  end

  def today_choices_too_many?
    return if current_user.nil?
    
    redirect_to alert_choices_path if current_user.count_today_choices > 10
  end

  def decide_result
    options = []
    options.push(@choice.option_1, @choice.option_2, @choice.option_3, @choice.option_4,
                 @choice.option_5)
    options.reject!(&:blank?)
    @choice.result = options.sample
  end

  def choice_params
    params.require(:choice).permit(:title, :option_1, :option_2, :option_3, :option_4, :option_5,
                                   :result)
  end

  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.dig(:twitter, :key)
      config.consumer_secret = Rails.application.credentials.dig(:twitter, :secret_key)
      config.access_token = Rails.application.credentials.dig(:twitter, :token)
      config.access_token_secret = Rails.application.credentials.dig(:twitter, :secret_token)
    end
  end
end
