require 'blockcypher/client/version'

require 'httpclient'
require 'json'

module Blockcypher
  module Api

    def transactions(txs_hash)
      Call.new(base_uri).get("/txs/#{txs_hash}")
    end
    alias_method :txs, :transactions

    def blocks(block_hash)
      Call.new(base_uri).get("/blocks/#{block_hash}")
    end

    def address(add)
      Call.new(base_uri).get("/addrs/#{add}")
    end

    def current
      Call.new(base_uri).get
    end
    alias_method :status, :current

    class Call

      def initialize(base_uri)
        @http = HTTPClient.new(base_url: base_uri.to_s) 
      end

      def get(path = '')
        parse_response(@http.get_content(path))
      end

      private

      def parse_response(response)
        JSON.parse(response) 
      end
    end
  end

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
