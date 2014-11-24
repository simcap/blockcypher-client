$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'blockcypher/client'

require 'pry'
require 'digest'
require 'minitest/autorun'

module Blockcypher
  class Client
    module Api

      class MockResponse
        attr_reader :body

        def initialize(body)
          @body = body
        end

        def ok?
          true
        end
      end

      class MockHttpClient
        attr_reader :base_uri

        def initialize(config)
          @base_uri = config.base_uri
        end

        def get(path, *args)
          mock_response(:get, path)
        end

        def post(path, *args)
          mock_response(:post, path)
        end

        private

        def mock_response(verb, path)
          filename = Digest::MD5.hexdigest "#{verb}#{base_uri}#{path}" 
          filepath = find_file(filename)
          MockResponse.new File.open(filepath).read
        rescue Errno::ENOENT
          raise "No mock response file #{filepath} for #{verb} call for #{base_uri}#{path}"
        end

        def find_file(filename)
          File.join(__dir__, 'fixtures/mocked_responses', filename)
        end
      end

      class Call
        def http_client
          MockHttpClient.new(config)
        end
      end
    end
  end
end
