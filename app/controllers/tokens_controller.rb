class TokensController < ApplicationController

  def index
    @tokens = current_user.tokens
  end

  def new
    @token = Token.new
    # Rails.cache.fetch('get_institutions') do
      @institutions = Plaid.call.get_institutions()

      @institution_options = @institutions.inject({}) do |memo, institution|
        memo[institution['name']] = institution['type']
        memo
      end
    # end
  end

  def request_token
    options = {
      client_id: SECRETS[:plaid][:client_id],
      secret: SECRETS[:plaid][:secret],
      credentials: params[:credentials],
      email: current_user.email,
      type: params[:institution],
      options: {
        list: true
      }
    }

    begin
      response = RestClient.post "https://tartan.plaid.com/connect", options
      @response = JSON.parse(response)
    rescue Exception => e
      flash[:error] = "Could not authorize."
      redirect_to new_token_path and return
    end

    @institution = params[:institution]

    if @response.has_key?('mfa')
      render 'tokens/mfa/code/delivery_method'
    else
      if token = Token.create(user: current_user, institution: params[:token][:institution], access_token: @response['access_token'])
        if @response.has_key?('accounts')
          @response['accounts'].each do |account|
            Account.create(user: user, token: token, name: account['meta']['official_name'], data: account, service: 'plaid')
          end
        end
        flash[:success] = "Account token created successfully!"
        redirect_to accounts_path and return
      else
        flash[:error] = "Something went wrong!"
        redirect_to accounts_path and return
      end
    end
  end

  def request_mfa_code
    options = {
      client_id: SECRETS[:plaid][:client_id],
      secret: SECRETS[:plaid][:secret],
      access_token: params[:access_token],
      mfa: '',
      options: {
        send_method: {
          mask: params[:delivery]
        }
      }
    }

    response = RestClient.post "https://tartan.plaid.com/connect/step", options
    @response = JSON.parse(response)
    @institution = params[:institution]

    render 'tokens/mfa/code/enter_code'
  end

  def submit_mfa_code
    options = {
      client_id: SECRETS[:plaid][:client_id],
      secret: SECRETS[:plaid][:secret],
      access_token: params[:access_token],
      mfa: params[:code]
    }

    response = RestClient.post "https://tartan.plaid.com/connect/step", options
    @response = JSON.parse(response)
    @institution = params[:institution]

    if token = Token.create(user: current_user, institution: @institution, access_token: @response['access_token'])
      if @response.has_key?('accounts')
        @response['accounts'].each do |account|
          Account.create(user: current_user, token: token, name: account['meta']['official_name'], data: account, service: 'plaid')
        end
      end
      flash[:success] = "Account token created successfully!"
      redirect_to accounts_path and return
    else
      flash[:error] = "Something went wrong!"
      redirect_to accounts_path and return
    end
  end


  def create
    @token = Token.new token_params
    @token.user = current_user

    if @token.save
      flash[:success] = "Token created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @token = Token.find params[:id]
  end

  def update
    @token = Token.find params[:id]
    if @token.update_attributes(token_params)
      flash[:success] = "Token updated successfully."
      redirect_to tokens_path
    else
      render :edit
    end
  end

  def destroy
    @token = Token.find(params[:id]).destroy
    flash[:success] = "Token destroyed successfully."
    redirect_to tokens_path
  end


  private

    def token_params
      params.require(:token).permit(:institution, :username, :password, :email)
    end

end
