class Token < ActiveRecord::Base

  belongs_to :user
  before_create :authenticate_api

  validates :institution, presence: true
  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true
  validates :user_id, presence: true

  attr_accessor :username, :password, :pin

  private

    # def authenticate_api
    #   case
    #   when PLAID.has_value?(institution)
    #     response = Plaid.call.add_account(institution,username,password,email)
    #     self[:access_token] = response[:access_token]
    #     response[:accounts].each do |account|
    #       Account.create(user: user, token: self, name: account['meta']['official_name'], data: account, service: 'plaid')
    #     end
    #   end
    # end

end
