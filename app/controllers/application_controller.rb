require 'rack/test'
require "sinatra/namespace"
require 'json'

class ApplicationController < Sinatra::Base
  register Sinatra::Namespace
  before do
    content_type :json
  end

    get '/validate_address' do
    address = SmartyStreetService.validate_address(params[:params])
  end
end
