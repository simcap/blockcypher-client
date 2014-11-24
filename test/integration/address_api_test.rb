require 'minitest_helper'

class AddressApiTest < MiniTest::Test

  def test_get_address_details_for_main_btc
    add = '1PuwQ6uWXNeGcEnLCAXmRJozdLZ9M4NWQ7' 

    client = Blockcypher::Client.new
    json =  client.address(add)

    assert_equal add, json['address']
  end

  def test_generate_address
    client = Blockcypher::Client.new
    json = client.create_address
    refute_nil json['private']
    refute_nil json['public']
    refute_nil json['address']
  end

end
