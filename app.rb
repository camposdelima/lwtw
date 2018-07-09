require 'sinatra'
require "net/http"
require "uri"

before do
  content_type 'application/json'
end

def tweeps
  url = URI.parse('http://tweeps.locaweb.com.br/tweeps')
  req = Net::HTTP::Get.new(url)
  req.add_field("username", "a@a.com.br")
  
  Net::HTTP.new(url.host, url.port).start { |http|
    res = http.request(req)
    json_response = JSON.parse(res.body)
    json_response['statuses']
  }
  .select { |item|
    isReply = item['in_reply_to_user_id'] != 42 
    isMention = item['text'].include? '@locaweb'
    isReply && isMention
  }
  .sort_by{ |item|
    [ item['user']['followers_count'], item['retweet_count'], item['favorite_count']  ]
  }
  .reverse  
  .map { |item| 
    profileLink = 'http://twitter.com/'+item['user']['screen_name']
    {
      'screen_name' =>  item['user']['screen_name'],  
      'followers_count' => item['user']['followers_count'],      
      'retweet_count' => item['retweet_count'],
      'favorite_count' => item['favorite_count'],
      'text' => item['text'],
      'created_at' => item['created_at'],
      'profile_link' => profileLink,
      'link' => profileLink+'/status/'+item['id_str']
    }
  }
end


get '/most_relevants' do    
  tweeps.to_json
end

get '/most_mentions' do
  tweeps.group_by{ |item|
    item['screen_name']
  }.to_json
end 

get '/' do
  content_type 'text/html'
  send_file 'index.html'
end