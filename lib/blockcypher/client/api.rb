module Blockcypher
  class Client
    module Api
      def transactions(txs_hash)
        new_call.get("/txs/#{txs_hash}")
      end
      alias_method :txs, :transactions

      def blocks(block_hash)
        new_call.get("/blocks/#{block_hash}")
      end

      def address(add)
        new_call.get("/addrs/#{add}")
      end

      def create_address
        new_call.post('/addrs')
      end

      def chain
        new_call.get
      end

      private 

      def new_call
        Call.new(config)
      end

      class Call

        attr_reader :http_client

        def initialize(config)
          @config = config
          @http_client = HTTPClient.new(
            base_url: @config.base_uri.to_s,
            default_header: { Accept: 'application/json' }
          ) 
        end

        def post(path, options = {})
          perform(:post, path, options)
        end

        def get(path = '')
          perform(:get, path)
        end

        private

        def perform(verb, path, options = {})
          options.merge!(query: params)
          response = http_client.public_send(verb.to_s, path, options) 
          if response.ok?
            parse_json(response.body)
          else
            raise "Http error #{response.status} while calling '#{response.header.request_uri.to_s}'"
          end
        end

        def params
          @config.token ? { token: @config.token } : {}
        end

        def parse_json(body)
          JSON.parse(body) 
        end
      end
    end
  end
end
