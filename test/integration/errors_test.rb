require 'minitest_helper'

class ErrorsApiTest < MiniTest::Test

  def test_404_not_found
    client = Blockcypher::Client.new
    assert_raises Blockcypher::BadResponse do |error|
      json = client.blocks('')
      assert_match /404/, error.message
    end
  end

end
