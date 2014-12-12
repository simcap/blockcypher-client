require 'minitest_helper'

class TransactionsApiTest < MiniTest::Test

  def test_get_transaction_details_for_main_btc
    txs ='709c306928f966918dfe4488acc44d222ae363792a090e8783eb03267ac200ad' 

    client = Blockcypher::Client.new
    json =  client.txs(txs)

    assert_equal txs, json['hash']
  end

  def test_create_new_transaction
    addrs = ["1DEP8i3QJCsomS4BSMY2RpU1upv62aGvhD", "1FGAsJFNgWvFz2tWQAnRq8S6fVX9Zmuxje"]
    client = Blockcypher::Client.new
    json =  client.new_tx(addrs[0], addrs[1], 500)

    assert_equal addrs, json['tx']['addresses']
  end


end
