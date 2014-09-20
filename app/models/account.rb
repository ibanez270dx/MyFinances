class Account < ActiveRecord::Base

  belongs_to :user
  belongs_to :token

  validates :service, presence: true
  validates :data, presence: true

  serialize :data, JSON

  PLAID = {
    "amex" => "American Express",
    "bofa" => "Bank of America",
    "capone360" => "Capital One 360",
    "schwab" => "Charles Schwab",
    "chase" => "Chase",
    "citi" => "Citi",
    "fidelity" => "Fidelity",
    "usaa" => "USAA",
    "us" => "US Bank",
    "wells" => "Wells Fargo"
  }

  def name
    self[:name] || case service
    when "plaid" then data['meta']['name']
    end.strip
  end

  def type
    case service
    when "plaid" then "#{data['type']} #{data['subtype']}"
    end.strip
  end

  def number
    case service
    when "plaid" then data['meta']['number']
    end.strip
  end

  def balance
    case service
    when "plaid" then data['balance']
    end
  end

  def institution_name
    PLAID[token.institution] if token
  end

end
