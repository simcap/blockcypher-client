require 'blockcypher/client/version'
require 'blockcypher/client/api'

require 'httpclient'
require 'json'

module Blockcypher
  class Client
    include Api 

    attr_reader :base_uri

    def initialize(options = {})
      @chain = options[:chain] || :main
      @coin = options[:coin] || :btc
      @base_uri = URI("https://api.blockcypher.com/v1/#{@coin}/#{@chain}")
    end
  end
end
