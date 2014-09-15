class Account < ActiveRecord::Base

  belongs_to :user
  belongs_to :token

  validates :service, presence: true
  validates :data, presence: true

  serialize :data, JSON

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
end
