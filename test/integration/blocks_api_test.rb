require 'minitest_helper'

class BlocksApiTest < MiniTest::Test

  def test_get_blocks_details_for_main_btc
    hash = '000000000000000002f4d96fc5ab8705629fe4175bfe665afd4e5c19cab33663'
    
    client = Blockcypher::Client.new
    json = client.blocks(hash)

    assert_equal hash, json['hash']
    assert_equal 'BTC.main', json['chain']
  end

end
