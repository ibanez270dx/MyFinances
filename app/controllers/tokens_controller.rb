class TokensController < ApplicationController

  def index
    @tokens = current_user.tokens
  end

  def new
    @token = Token.new
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
      params.require(:token).permit(:bank, :username, :password, :email)
    end

end
