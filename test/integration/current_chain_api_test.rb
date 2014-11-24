require 'minitest_helper'

class CurrentChainApiTest < MiniTest::Test

  def test_current_chain_for_different_chains
    client = Blockcypher::Client.new
    assert_equal 'BTC.main', client.chain['name']

    client = Blockcypher::Client.new(chain: :test3)
    assert_equal 'BTC.test3', client.chain['name']
  end

  def test_current_chain_for_different_coins
    client = Blockcypher::Client.new(coin: :ltc)
    assert_equal 'LTC.main', client.chain['name']

    client = Blockcypher::Client.new(coin: :uro)
    assert_equal 'URO.main', client.chain['name']
  end

end
