class Account < ActiveRecord::Base

  belongs_to :user

  PLAID = {
    "American Express" => "amex",
    "Bank of America" => "bofa",
    "Chase" => "chase",
    "Citi" => "citi",
    "US Bank" => "us",
    "USAA" => "usaa",
    "Wells Fargo" => "wells"
  }

end
