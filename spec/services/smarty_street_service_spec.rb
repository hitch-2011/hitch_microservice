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
        place_info   = SmartyStreetService.validate_address(query_hash1, query_hash2)
        
        expect(place_info.count).to eq(2)
        expect(place_info.first).to be_a Hash
      end
    end
  end
end