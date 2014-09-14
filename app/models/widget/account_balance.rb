class Widget::AccountBalance < Widget

  def name
    "Account Balance Widget"
  end

  def refresh_data
    get_plaid_data
  end

  def self.available_accounts(u)
    Plaid.customer.get_all(u)
  end


end
