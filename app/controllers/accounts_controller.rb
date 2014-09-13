class AccountsController < ApplicationController

  def index
    @accounts = current_user.accounts
  end

  def new
    @account = current_user.token.new
  end

  def create
    if @account = current_user.accounts.create(account_params)
      flash[:success] = "Account created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @account = Account.find params[:id]
  end

  def update
    @account = Account.find params[:id]
    if @account.update_attributes(account_params)
      flash[:success] = "Account updated successfully."
      redirect_to accounts_path
    else
      render :edit
    end
  end

  def destroy
    @account = Account.find(params[:id]).destroy
    flash[:success] = "Account destroyed successfully."
    redirect_to accounts_path
  end


  private

    def account_params
      params.require(:account).permit(:bank, :username, :password, :email)
    end

end
