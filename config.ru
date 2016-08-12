require 'faye'
require File.expand_path('../yup', __FILE__)
class FayeClient
  include Singleton

  def self.client
    @client ||= Faye::Client.new('http://localhost:4567/faye')
  end
end

Faye::WebSocket.load_adapter('thin')
use Faye::RackAdapter, :mount => '/faye', :timeout => 25

run Yup
