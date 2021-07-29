pragma solidity ^0.5.0;

contract CustomerSavings {
    
    
    address last_to_withdraw;
    uint last_withdraw_block;
    uint last_withdraw_amount;
    
    address last_to_deposit;
    uint last_deposit_block;
    uint last_deposit_amount;
    
    // call this endpoint to withdraw money 
    function withdraw(uint amount) public {                           //
        return recipient.transfer(amount);
        
        
          
    }
    
    //address.balance 
    
    // endpoint responsible for receiving ethereum.
    function deposit() public payable {                                                         // functions have to be marked as poyable if they are receiving money in ethereum. 
    
        
    }
    
    //if someone doesn't call the deposit function, transaction is not going to work. 
    
    
    // fallback function 
    // anyone can send Ethereum to this function. 
    function() external payable {                                // external flag
        // blank function 
      
    }
}

