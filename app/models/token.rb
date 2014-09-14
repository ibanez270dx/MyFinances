class Token < ActiveRecord::Base

  belongs_to :user
  before_create :authenticate_plaid

  validates :bank, presence: true
  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true
  validates :user_id, presence: true

  attr_accessor :username, :password

  PLAID = {
    "American Express" => "amex",
    "Bank of America" => "bofa",
    "Chase" => "chase",
    "Citi" => "citi",
    "US Bank" => "us",
    "USAA" => "usaa",
    "Wells Fargo" => "wells"
  }

  private

    def authenticate_plaid
      plaid = Plaid.call.add_account(bank,username,password,email)
      self[:access_token] = plaid[:access_token]
    end
end
