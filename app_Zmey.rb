require 'sinatra'
require 'yaml/store'
votes={}
CHOICES = {
  'fluffy' => 'fluffy',
  'naked'  => 'naked',
  'dirty'  => 'dirty',
  'clean'  => 'clean',
  'angry'  => 'angry',
}
post '/cast' do
  @title = 'Thank you for your vote!'
  @vote  = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    if @store['votes'] == nil
      @store['votes'] = {}
    end

    if @store['votes'][@vote]
      @store['votes'][@vote] = @store['votes'][@vote] + 1
    else
      @store['votes'][@vote] = 1
    end
  end
  erb :cast
end

 get '/' do
  erb :dirty
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end

