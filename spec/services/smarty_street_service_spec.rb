require 'spec_helper'

RSpec.describe SmartyStreetService do
  describe 'validate address' do
    it 'validates address' do
      VCR.use_cassette('validate_address') do
        query_hash1 = { street: '2298 West 28th Ave',
                        city: 'Denver',
                        state: 'CO',
                        zip: '80211'}
        query_hash2 = { street: '1138 Corona St',
                        city: 'Denver',
                        state: 'CO',
                        zip: '80218'}
        place_info  = SmartyStreetService.validate_address([query_hash1, query_hash2].to_json)
        body = JSON.parse(place_info[1], symbolize_names: true)
        expect(place_info.first).to eq(200)
        expect(body[:message]).to eq("Both addresses validated.")
      end
    end

    describe 'bad addr' do
      it 'promps user if bad addresses' do
        VCR.use_cassette('validate_address_bad_street') do
          query_hash1 = { street: '2298 West 28th Ave',
                          city: 'Denver',
                          state: 'CO',
                          zip: '80211'}
          query_hash2 = { street: '11 Corona St',
                          city: 'Denver',
                          state: 'CO',
                          zip: '80218'}
          place_info  = SmartyStreetService.validate_address([query_hash1, query_hash2].to_json)
          body = JSON.parse(place_info[1], symbolize_names: true)
          expect(place_info.first).to eq(400)
          expect(body[:message]).to eq("One of these addresses is not valid.")
        end 
      end
    end
  end
end
