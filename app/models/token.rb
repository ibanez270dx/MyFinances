class Token < ActiveRecord::Base

  belongs_to :user
  has_many :accounts, dependent: :destroy
  # before_create :authenticate_api

  before_destroy :remove_from_service

  validates :institution, presence: true
  validates :user_id, presence: true

  private

    def remove_from_service
      options = {
        client_id: SECRETS[:plaid][:client_id],
        secret: SECRETS[:plaid][:secret],
        access_token: access_token
      }
      response = RestClient.delete "https://tartan.plaid.com/connect", params: options
      response.code == 200
    end

    # def authenticate_api
    #   response = Plaid.call.add_account(institution,username,password,email)
    #   self[:access_token] = response[:access_token]
    #   response[:accounts].each do |account|
    #     Account.create(user: user, token: self, name: account['meta']['official_name'], data: account, service: 'plaid')
    #   end
    # end

end
