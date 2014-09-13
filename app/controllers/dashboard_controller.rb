class DashboardController < ApplicationController
  before_filter :require_user

  def index
    unless current_user.tokens.empty?
      transactions = Plaid.customer.get_transactions(current_user.tokens.first.access_token)
      @transactions = transactions[:transactions]
    end
  end

  def show
    @account = Plaid.call.add_account(params[:bank],params[:username],params[:password],params[:email])
    @transactions = Plaid.customer.get_transactions(@account[:access_token])
  end

end
