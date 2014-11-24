require 'minitest_helper'

class CurrentApiTest < MiniTest::Test

  def test_current_status_for_different_chains
    client = Blockcypher::Client.new
    assert_equal 'BTC.main', client.current['name']

    client = Blockcypher::Client.new(chain: :test3)
    assert_equal 'BTC.test3', client.current['name']
  end

  def test_current_status_for_different_coins
    client = Blockcypher::Client.new(coin: :ltc)
    assert_equal 'LTC.main', client.current['name']

    client = Blockcypher::Client.new(coin: :uro)
    assert_equal 'URO.main', client.current['name']
  end

end
