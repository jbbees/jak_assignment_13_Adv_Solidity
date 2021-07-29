pragma solidity ^0.5.0;

contract TradeController {
    uint previous_price;          // 
    string trade_type;            // buy, sell, or hold. not gas optimized. using a boolean is better. 
    bool buy_anyway = false;
    
    
    // getter function to see results  
    function viewTrade() public view returns(uint, string memory) {       // set a s view so there's no gas expended. 
        return(previous_price, trade_type);
    }
    
    // function for action at certain price: is this a buy, sell, or hold signal? 
    
    // and &&
    // or ||
    // not !
    
    function makeTrade(uint current_price, bool buy_anyway) public {     
        if (current_price < previous_price || buy_anyway) {             // if current_price is less than previous price, OR buy_anyay is TRUE 
            
            // if first condition is false, then it will check if buy_anyway.
            // if buy_anway is false, then this first if is passed. 
            
            // buy logic 
            trade_type = "Buy";                                             
            previous_price = current_price;                                
        } else if (current_price > previous_price) {
            // sell logic 
            trade_type = "Sell";
            previous_price = current_price;
        } else {
            // hold logic
            // this means current_price and previous_price are the same value
            
        }
        
    }
    
    
    
}