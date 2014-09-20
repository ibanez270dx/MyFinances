class AccountsController < ApplicationController

  def index
    @accounts = current_user.accounts
  end

  def refresh
    i = 0
    current_user.tokens.each do |token|
      options = {
        client_id: SECRETS[:plaid][:client_id],
        secret: SECRETS[:plaid][:secret],
        access_token: token.access_token
      }

      Rails.logger.debug "================================================================================"
      Rails.logger.debug options.inspect
      Rails.logger.debug "================================================================================"

      response = RestClient.get "https://tartan.plaid.com/connect", params: options
      @response = JSON.parse(response)

      Rails.logger.debug "================================================================================"
      Rails.logger.debug @response.inspect
      Rails.logger.debug "================================================================================"

      if @response.has_key?('accounts')
        @response['accounts'].each do |account_data|
          account = Account.find_by_service_id(service_id: account_data['_id'])
          account.data = account_data
          i+=1 if account.save
        end
      end
    end
    flash[:success] = "#{i} accounts updated successfully!"
    redirect_to accounts_path
  end

end
