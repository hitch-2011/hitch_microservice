class ApplicationController < Sinatra::Base
  before do 
    content_type :json
  end

  get '/api/v1/validate_address' do
    require 'pry'; binding.pry
    address = SmartyStreetService.validate_address(params[:address1], params[:address2])
  end
end