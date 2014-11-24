require 'blockcypher/client/version'
require 'blockcypher/client/api'

require 'httpclient'
require 'json'

module Blockcypher
  class Client
    include Api 

    attr_reader :config

    def initialize(options = {})
      chain = options[:chain] || :main
      coin = options[:coin] || :btc
      @config = Config.new(
        URI("http://api.blockcypher.com/v1/#{coin}/#{chain}"), 
        options[:token]
      )
    end
  end

  Config = Struct.new(:base_uri, :token) do
    undef []=, base_uri=, token=
  end
end
