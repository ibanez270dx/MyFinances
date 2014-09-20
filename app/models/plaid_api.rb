class PlaidAPI

  BASE_URL = "https://tartan.plaid.com"

  def self.connect(method, options)
    options = { client_id: SECRETS[:plaid][:client_id], secret: SECRETS[:plaid][:secret] }.merge(options)

    begin
      response = case method.to_sym
      when :post    then  RestClient.post("#{BASE_URL}/connect", options)
      when :get     then  RestClient.get("#{BASE_URL}/connect", params: options)
      when :delete  then  RestClient.delete("#{BASE_URL}/connect", params: options)
      end
      JSON.parse(response)
    rescue RestClient::ExceptionWithResponse => e
      return JSON.parse(e.response)
    rescue RestClient::Exception => e
      return e.message
    end
  end
end
