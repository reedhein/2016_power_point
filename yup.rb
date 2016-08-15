require 'rubygems'
require 'sinatra'
require 'haml'
require 'pry'
require 'thin'

class Yup < Sinatra::Base
  set env: :development
  set logging: true
  set port: 4567
  set bind: '0.0.0.0'
  set server: 'thin'

  get '/' do
    haml :index
  end

  post '/forward' do
    puts params
    puts 'forward called'
    FayeClient.client.publish('/commands', text: 'forward') if params[:key] == 'lazysecret'
  end

  post '/back' do
    FayeClient.client.publish('/commands', text: 'reverse') if params[:key] == 'lazysecret'
  end
  
  post '/restart' do 
    FayeClient.client.publish('/commands', text: 'begin') if params[:key] == 'lazysecret'
  end

  get '/error' do
  end

  error do
    haml :error
  end

  private

  run! if app_file == $0
end

