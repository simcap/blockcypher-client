module Blockcypher
  class Client
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

      def chain
        Call.new(base_uri).get
      end

      class Call
        def initialize(base_uri)
          @http = HTTPClient.new(
            base_url: base_uri.to_s,
            default_header: {Accept: 'application/json'}
          ) 
        end

        def get(path = '')
          response = @http.get_content(path)
          parse_json(response)
        rescue HTTPClient::BadResponseError => e
          raise "Unexpected http status #{e.res.status} calling '#{e.res.header.request_uri.to_s}'"
        end

        private

        def parse_json(response)
          JSON.parse(response) 
        end
      end
    end
  end
end
