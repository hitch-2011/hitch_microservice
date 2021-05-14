require 'spec_helper'
require 'rack/test'
require './app/controllers/application_controller'


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
          query_hash2 =  {street: '1138 Corona St',
                          city: 'Denver',
                          state: 'CO',
                          zip: '80218'}

           get "/validate_address", params: JSON.generate([query_hash1, query_hash2])

          body = JSON.parse(last_response.body, symbolize_names: true)
          expect(last_response.status).to eq 200
          expect(body[:message]).to eq("Both addresses validated.")

      end
    end

  end

  describe 'sad path' do
    it 'can return a 400 for bad addresses' do
      VCR.use_cassette('bad_addr') do
        query_hash1 = { street: '2298 West 28th Ave',
                        city: 'Denver',
                        state: 'CO',
                        zip: '80211'}
        query_hash2 =  {street: "",
                        city: 'Denver',
                        state: 'CO',
                        zip: '80218'}

         get "/validate_address", params: JSON.generate([query_hash1, query_hash2])
         get "/validate_address", params: JSON.generate([query_hash1, query_hash2])

        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(last_response.status).to eq 400
        expect(body[:message]).to eq("One of these addresses is not valid.")
      end
    end
  end
end
