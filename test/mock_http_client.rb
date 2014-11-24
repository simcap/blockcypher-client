require 'digest'
require 'yaml'

# Allow to provide a mock http client for testing
# 
# Basically patch the Call#http_client to return a MockHttpClient

module Blockcypher
  class Client
    module Api

      class Call
        def http_client
          MockHttpClient.new(config)
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
          filename_prefix = Digest::MD5.hexdigest "#{verb}#{base_uri}#{path}" 
          filepath = find_file(filename_prefix)
          MockResponse.new(filepath)
        rescue 
          raise "No mock response file #{filepath} for #{verb} call for #{base_uri}#{path}"
        end

        def find_file(prefix)
          files_with_prefix = File.join(__dir__, 'fixtures/mocked_responses', "#{prefix}*")
          matches = Dir.glob(files_with_prefix)
          raise "No file starting with #{prefix}" if matches.empty?
          matches.first
        end
      end

      Header = Struct.new(:request_uri)

      class MockResponse
        attr_reader :body, :status


        def initialize(filepath)
          @body = File.open(filepath).read
          _, status = File.basename(filepath).match(/_(\d{3}\z)/).to_a
          @status = status || 200
        end

        def ok?
          (200..299).include? status
        end

        def header
          Header.new('')
        end
      end

    end
  end
end
