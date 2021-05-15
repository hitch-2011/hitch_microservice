class SmartyStreetService
  class << self
    def validate_address(params)
      response = conn.post('/street-address') do |req|
        req.body = params
      end
      return_message(response)
    end

    def return_message(response)
      if JSON.parse(response.body, symbolize_names: true).count == 2
        [200, ({message: "Both addresses validated."}).to_json]
      else
        [400, ({message: "One of these addresses is not valid."}).to_json]
      end
    end

    private

    def conn
      @conn ||= Faraday.new('https://us-street.api.smartystreets.com') do |req|
        req.params['auth-id'] = ENV['SMARTY_AUTH_ID']
        req.params['auth-token'] = ENV['SMARTY_AUTH_TOKEN']
      end
    end
  end
end
