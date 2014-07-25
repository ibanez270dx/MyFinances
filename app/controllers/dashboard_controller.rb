class DashboardController < ApplicationController
  before_filter :require_user

  def index

  end

  def show
    @account = Plaid.call.add_account(params[:bank],params[:username],params[:password],params[:email])
    @transactions = Plaid.customer.get_transactions(@account[:access_token])
  end

end
