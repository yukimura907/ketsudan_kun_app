class ChoicesController < ApplicationController
  before_action :set_choice_instance, only: [:confirm, :create, :edit, :compassion, :compassion_create]
  before_action :throuth_confirm?, only: [:result]
  before_action :today_choices_too_many?, only: [:new]
  # before_action :twitter_client, only: [:create] # twitter自動投稿を使用する場合のみ！
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
      flash[:success] = t 'choices.flash.new decide with compassion'
      redirect_to result_choice_path(@choice.id)
    end
  end

  def create
    decide_result
    if params[:back]
      render :new
    elsif @choice.save
      flash[:success] = t 'choices.flash.new decide'
      redirect_to result_choice_path(@choice.id)
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

  def throuth_confirm?
    return if request.referer.present?

    redirect_to new_choice_path
    flash[:danger] = t 'choices.flash.fullfill title and options'
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
    queues = if @choice.option_5.present?
               { @choice.option_1.to_s => 7, @choice.option_2.to_s => 7, @choice.option_3.to_s => 7, @choice.option_4.to_s => 7,
                 @choice.option_5.to_s => 7, (params[:choice][:primary_option]).to_s => 65 }
             elsif @choice.option_4.present?
               { @choice.option_1.to_s => 10, @choice.option_2.to_s => 10, @choice.option_3.to_s => 10, @choice.option_4.to_s => 10,
                 (params[:choice][:primary_option]).to_s => 60 }
             elsif @choice.option_3.present?
               { @choice.option_1.to_s => 15, @choice.option_2.to_s => 15, @choice.option_3.to_s => 15,
                 (params[:choice][:primary_option]).to_s => 55 }
             else
               { @choice.option_1.to_s => 30, @choice.option_2.to_s => 30, (params[:choice][:primary_option]).to_s => 40 }
             end
    randomizer = WeightedRandomizer.new(queues)
    @choice.result = randomizer.sample
  end

  def choice_params
    params.require(:choice).permit(:title, :option_1, :option_2, :option_3, :option_4, :option_5,
                                   :result)
  end

  # twitter自動投稿を使用する場合のみ！

  # def twitter_client
  # @client = Twitter::REST::Client.new do |config|
  # config.consumer_key = Rails.application.credentials.dig(:twitter, :key)
  # config.consumer_secret = Rails.application.credentials.dig(:twitter, :secret_key)
  # config.access_token = Rails.application.credentials.dig(:twitter, :token)
  # config.access_token_secret = Rails.application.credentials.dig(:twitter, :secret_token)
  # end
  # end
end
