require 'minitest_helper'

class TestBlockcypher::Client < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Blockcypher::Client::VERSION
  end

  def test_false
    assert false
    raise 'Hell'
  end
end
