module Guests
  class ChoicesController < ApplicationController
    before_action :set_choice_instance, only: [:confirm, :result]
    skip_before_action :require_login

    def new
      @choice = Choice.new
    end

    def confirm
      @choice.user_id = 1
      render :new if @choice.invalid?
    end

    def result
      @choice.user_id = 1
      options = []
      options.push(@choice.option_1, @choice.option_2, @choice.option_3, @choice.option_4,
                   @choice.option_5)
      options.reject!(&:blank?)
      @choice.result = options.sample
      render :new if params[:back]
    end

    def edit
      render :new
    end

    def goodbye
      redirect_to root_path
    end

    private

    def set_choice_instance
      @choice = Choice.new(choice_params)
    end

    def choice_params
      params.require(:choice).permit(:title, :option_1, :option_2, :option_3, :option_4,
                                     :option_5, :result)
    end
  end
end
