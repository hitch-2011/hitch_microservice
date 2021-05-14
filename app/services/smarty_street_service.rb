class SmartyStreetService
  class << self
    def validate_address(query1, query2)
      response = conn.post('/street-address') do |req|
        req.body = [query1, query2].to_json
      end
      JSON.parse(response.body, symbolize_names: true)
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