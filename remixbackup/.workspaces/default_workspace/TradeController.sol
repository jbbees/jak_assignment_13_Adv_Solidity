pragma solidity ^0.5.0;

contract TradeController {
    uint previous_price;
    string trade_type;                        // not the most gas-optimized using string. use boolean type for efficiency
    
    function makeTrade(uint current_price, bool buy_anyway) public {
        
        // and is &&
        // or ||
        // not !
        
        if (current_price < previous_price || buy_anyway) {
            // buy
            trade_type = "Buy";
            previous_price = current_price;
        } else if(current_price > previous_price) {
            // sell 
            trade_type = "Sell";
            previous_price = current_price;
        } else {
            // no change in price, hold
            trade_type = "Hold";
        }

        
    }
    
}