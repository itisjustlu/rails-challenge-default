module Api
  class UsersController < ApplicationController
    def index

    end

    def create
      result = ::Users::Creator.call(user_params)

      if result.success?
        render json: result.user, status: :created
      else
        render json: result.errors, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(
        :email,
        :phone_number,
        :full_name,
        :password,
        :metadata
      ).merge(password_confirmation: params[:password])
    end
  end
end
