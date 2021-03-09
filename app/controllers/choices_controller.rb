class ChoicesController < ApplicationController
  before_action :set_choice_instance, only: [:confirm, :create, :edit, :compassion, :compassion_create]
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

  def compassion; end

  def compassion_create
    decide_with_compassion
    if params[:back]
      render :new
    elsif @choice.save
      flash[:success] = '新たな決断が下されました。'
      redirect_to "/choices/result/#{@choice.id}"
    end
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
    
    redirect_to alert_choices_path if current_user.count_today_choices > 100
  end

  def decide_result
    options = []
    options.push(@choice.option_1, @choice.option_2, @choice.option_3, @choice.option_4,
                 @choice.option_5)
    options.reject!(&:blank?)
    @choice.result = options.sample
  end

  def decide_with_compassion
    options = []
    options.push(@choice.option_1, @choice.option_2, @choice.option_3,
                    @choice.option_4, @choice.option_5, params[:choice][:primary_option])
    true_options = options.reject!(&:blank?)
    if @choice.option_5.present?
      queues = {"#{@choice.option_1}" =>7, "#{@choice.option_2}" => 7, "#{@choice.option_3}" => 7, "#{@choice.option_4}" => 7, "#{@choice.option_5}" => 7, "#{params[:choice][:primary_option]}" => 65}
    elsif @choice.option_4.present?
      queues = {"#{@choice.option_1}" =>10, "#{@choice.option_2}" => 10, "#{@choice.option_3}" => 10, "#{@choice.option_4}" => 10, "#{params[:choice][:primary_option]}" => 60}
    elsif @choice.option_3.present? 
      queues = {"#{@choice.option_1}" =>15, "#{@choice.option_2}" => 15, "#{@choice.option_3}" => 15, "#{params[:choice][:primary_option]}" => 55}
    else 
      queues = {"#{@choice.option_1}" =>30, "#{@choice.option_2}" => 30, "#{params[:choice][:primary_option]}" => 40}
    end
    randomizer = WeightedRandomizer.new(queues)
    @choice.result = randomizer.sample
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
