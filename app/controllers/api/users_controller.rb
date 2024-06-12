module Api
  class UsersController < ApplicationController
    def index
      result = ::Users::Finder.call(params: request.query_parameters)

      if result.success?
        render json: result.users, root: 'users', each_serializer: UserSerializer, adapter: :json
      else
        render json: result.error, status: result.status || 500
      end
    end

    def create
      result = ::Users::Creator.call(attributes: user_params)

      if result.success?
        render json: UserSerializer.new(result.user).as_json, status: :created
      else
        render json: { errors: result.errors }, status: result.status || 500
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
