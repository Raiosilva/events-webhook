require 'rails_helper'

RSpec.describe "Events", type: :request do

  describe 'Fetch Events Api Calls' do
    before(:all) do
      Event.create(
        :action => 'opened',
        :number => 1
      )
    end
    
    it 'It should return status that cannot make the request' do
      get "/issues/#{10}/events"

      expect(response).to have_http_status(422)
    end

    it 'should return  success status' do
      get "/issues/#{1}/events"

      expect(response).to have_http_status(200)
    end

    it 'should return message of error' do
      get "/issues/#{'2'}/events"

      expect(response).to have_http_status(422)
      expect(response.body).to eq(
       { :errors => 'Issue not found or value different to number'}.to_json
      )
    end
  end
end
