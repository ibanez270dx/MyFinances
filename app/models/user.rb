class User < ActiveRecord::Base

  has_many :tokens
  has_many :accounts
  has_many :widgets

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  def available_accounts
    token = tokens.first.access_token
    if token
      # Rails.cache.fetch("#{id}_available_accounts") do
        response = Plaid.customer.get_all(tokens.first.access_token)
        response['accounts'].reject { |x| x['type']=="other" }
      # end
    end
  end

end
