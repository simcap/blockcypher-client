# Blockcypher::Client

Allow usage of the [Blockcypher API](http://dev.blockcypher.com/reference.html) through Ruby

## Installation

    $ gem install blockcypher-client

## Testing

At the moment mainly integratino test hitting the live chains

    $ rake


## Usage

```ruby
# Creates new default client (coin = btc, chain = main)
client = Blockcypher::Client.new 
client.current                    # Return JSON for the current chain info 

litecoin = Blockcypher::Client.new(coin: :ltc)
litecoin = litecoin.transactions('4e6b95993b770e7d1084af128f971d6b44c5e32cbf3acc35eee84f69c6b4f9ea')

 # Client for bitcoin on the test3 blockchain
bitcoin_test = Blockcypher::Client.new(chain: :test3)
```
