require 'minitest_helper'

class BlocksApiTest < MiniTest::Test

  def test_get_blocks_details_for_main_btc
    block = '000000000000000002f4d96fc5ab8705629fe4175bfe665afd4e5c19cab33663'
    
    client = Blockcypher::Client.new
    json = client.blocks(block)

    assert_equal block, json['hash']
    assert_equal 'BTC.main', json['chain']
  end

end
