class UsersController < ApplicationController

  def signup
    @user = User.new
  end

  def create
    @user = User.create user_params

    if @user.valid?
      session[:user_id] = @user.id
      flash[:success] = "Welcome to My Finances"
      redirect_to dashboard_path
    else
      render :signup
    end
  end

  def login
    if request.post?
      if @user = User.find_by_email(params[:user][:email])
        if @user.authenticate(params[:user][:password])
          session[:user_id] = @user.id
          redirect_to(root_path)
        else
          flash.now[:error] = "Your password is incorrect."
        end
      else
        flash.now[:error] = "There is no user with that email."
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to site_path
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
