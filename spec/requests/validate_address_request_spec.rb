require 'spec_helper'
require 'rack/test'

RSpec.describe 'validate address' do
  include Rack::Test::Methods
    def app
      ApplicationController
    end
    describe "Happy path" do
      it 'can return proper addrs' do
        VCR.use_cassette('good_addr') do
          query_hash1 = { street: '2298 West 28th Ave', 
                          city: 'Denver',
                          state: 'CO',
                          zip: '80211'}
          query_hash2 = { street: '1138 Corona St', 
                          city: 'Denver',
                          state: 'CO',
                          zip: '80218'}
          
          get "/api/v1/validate_address?address1=#{query_hash1}&address2=#{query_hash2}"
          
          body = JSON.parse(last_response.body, symbolize_names: true)
          
          expect(last_response.status).to eq 200
          require 'pry'; binding.pry
        end
      end
    end
end