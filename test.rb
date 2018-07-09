require './app.rb'
require 'rspec'
require 'rack/test'

describe 'The LwTw App' do
  include Rack::Test::Methods

  describe 'most_relevants' do
    before { get '/most_relevants' }

    it "has only locaweb mentions" do
      expectLocawebMentions()
    end

    it "has required columns" do      
      expectRequiredColumns(response_object.first)
    end
  end

  describe 'most_mentions' do
    before { get '/most_mentions' }

    it "has only locaweb mentions" do
      expectLocawebMentions()
    end

    it "has required columns" do      
      _mentions = response_object
      expect(_mentions).not_to be_empty
      expect(_mentions.keys).not_to be_empty
      _first_child = _mentions.keys.first
    
      expectRequiredColumns(_mentions[_first_child].first)
    end
  end

  def app
    Sinatra::Application
  end
  
  def response_object
    expect(last_response).to be_ok
    expect(last_response.content_type).to eq('application/json')    

    _json_object = JSON.parse(last_response.body)

    expect(_json_object).not_to be_empty
    
    _json_object
  end

  def expectRequiredColumns(item)
    expect(item.keys).to contain_exactly(
      'followers_count',
      'screen_name',
      'profile_link',
      'created_at',
      'link',
      'retweet_count',
      'text',
      'favorite_count'
    )
  end

  def expectLocawebMentions()
    expect(last_response.body).not_to match(/^.+text((?!@locaweb).)+\"created_at\"\:.+/m)
  end 
end