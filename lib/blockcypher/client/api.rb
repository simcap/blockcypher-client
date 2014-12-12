require 'json'

module Blockcypher
  class Client
    module Api
      def transactions(txs_hash)
        new_call.get("/txs/#{txs_hash}")
      end
      alias_method :txs, :transactions

      def new_transaction(inputs, outputs, value)
        body = { inputs: [ {addresses: Array(inputs)} ], 
                 outputs: [ {addresses: Array(outputs), value: value} ]}
        new_call.post("/txs/new", body: body.to_json)
      end
      alias_method :new_tx, :new_transaction
        
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
        attr_reader :http_client, :config

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
            raise Blockcypher::BadResponse.new(response)
          end
        end

        def params
          config.token ? { token: config.token } : {}
        end

        def parse_json(body)
          JSON.parse(body) 
        end
      end
    end
  end

  class BadResponse < StandardError
    def initialize(response)
      @response = response
    end

    def message
      "Http error #{@response.status} while calling '#{request_uri}'"
    end

    private 

    def request_uri
      "#{@response.header.request_uri.to_s}"
    end
  end
end
