class Token < ActiveRecord::Base

  belongs_to :user
  before_create :authenticate

  # validates :access_token, presence: true

  attr_accessor :username, :password

  private

    def authenticate_plaid
      plaid = Plaid.call.add_account(bank,username,password,email)
      self[:access_token] = plaid[:access_token]
    end
end
