module Admin
  class UsersController < ApplicationController
    before_action -> { authorize(@user || User.new) },
                  only: [:index, :edit, :update]
    def index
      @users = User.where.not(role: :admin)
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update_attributes(update_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :show, status: :ok, location: @user
      end
    end

    private

    def udpate_params
      params.require(:user).permit(:role)
    end

  end
end