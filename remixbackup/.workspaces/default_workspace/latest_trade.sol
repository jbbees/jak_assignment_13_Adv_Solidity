pragma solidity ^0.5.0;

// contract to publish the most recent price we bought BTC at.
contract LatestTrade {
    string coin = "BTC";                 //set to BTC
    uint price;                          //defaults to uint 256 if no value
                                         // we use uint becasue we assume BTC cannot have negative value
    bool is_buy_order;                   // do we buy or not? 
    
    
    
    // setter function - setting data 
    // create function with function keyword and name of function() 
    // explicity pass the data-types and variables for the arguments withing the () and the name o
    
    function updateTrade(
        string memory newCoin,   // decorating string with memory. tell EVM compiler how string is stored. memory means EVM doesn't have to store it and discard it.  
        uint newPrice, 
        bool is_buy
    ) public {             // declare if the function is public or private followed by {} is it only called internally?
        coin = newCoin;
        price = newPrice;
        is_buy_order = is_buy;    // Buy or Sell Order?
    }

    // getter function - getting data. return the current value. 
    // in solidity you need to explicity specify what's being returned in the variable types.
    // this function takes no arguments, is public, and 
    // 
    // this function is free for gas. just reading data from the blockchain. 
    
    function getLatestTrade() public returns (string memory, uint, bool) {                  
            return(coin, price, is_buy_order);
    }
    
}