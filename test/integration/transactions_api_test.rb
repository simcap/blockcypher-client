require 'minitest_helper'

class TransactionsApiTest < MiniTest::Test

  def test_get_transaction_details_for_main_btc
    txs ='709c306928f966918dfe4488acc44d222ae363792a090e8783eb03267ac200ad' 

    client = Blockcypher::Client.new
    json =  client.txs(txs)

    assert_equal txs, json['hash']
  end

end
