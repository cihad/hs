module Administration
  class UsersController < BaseController

    before_filter :user, only: [:edit, :update]

    def index
      @users = User.all.order(created_at: :desc)
    end

    def edit
      authorize @user
    end

    def update
      authorize @user
      if @user.update(user_params)
        redirect_to administration_users_path, notice: I18n.t('administration.users.flash.updated')
      else
        render :new
      end
    end

  private

    def user_params
      params.require(:user).permit(:email, :role)
    end

    def user
      @user = User.find params[:id]
    end

  end
end