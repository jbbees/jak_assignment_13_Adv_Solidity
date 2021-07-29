pragma solidity ^0.5.0;

contract JointSavings {
    address account_one = 0xF22A5273803fBB1fC7cBC60c1a7A039320397CCC;         // MetaMask address AUTHORIZED to withdraw funds on this contract 
    address account_two = 0x1c726999f144e8C5c95949D10539E1282C9ea7Ed;         // Ganache address AUTHRORIZED to withdraw funds on this contract 
    uint public balanceContract;                                              // this allows us to check the balance of our contract while depositing and withdrawing 
    
    
    // other contract variables to keep track of last withdraw, blockm and amount
    address public last_to_withdraw;                                                 // tracks the last person to make a withdraw from the account. 
    uint public last_withdraw_block;                                                 // tracks last withdraw block 
    uint public last_withdraw_amount;                                                // tracks last withdraw amount
    
    // variables for last deposit, block, amount
    address public last_to_deposit;                                                  // last account to deposit
    uint public last_deposit_block;
    uint public last_deposit_amount;
    
    // time variables
    
    uint public unlock_time;                                                         // cast as uint. next time user is allowed to unlock
    uint public fakenow = now;                                                       // used to test contract when timelock hasn't expired. 
    
    // constructor to make contract re-useabel
    
    constructor(address payable _one, address payable _two) public {
        account_one = _one;
        account_two = _two;
    }
    
    //define a function named withdraw that will accept a uint named amount, and a payable address named recipient
    
    function withdraw(uint amount) public {     // we do not include a recipient argument. 
                                               
       // timelock require 
       require(unlock_time < now, "Account is timelocked.");   // first time run, the require passes becasue unlock_time starts at zero.  
                                               
       // add a msg.sender to your require statement for extra security, no need to pass an address. 
       // whoever calls the contract is the recipient, and code checks if they are an authorized account. 
       // check if msg.sender is account_one or account_two

       require(msg.sender == account_one || msg.sender == account_two, "Not authorized");     // msg.sender is in case the authorized accounts get hacked. 
          
            
        // update the last_to_withdraw if user value difference
        if(last_to_withdraw != msg.sender) {        // if current value in last_to_withdraw is different than current sender, write to block
            last_to_withdraw = msg.sender; 
        }
        
        
        // update the last withdraw block and amount 
        last_withdraw_block = block.number;         // block number is last blocj
        last_withdraw_amount = amount;              // 
        
        
        if(amount > address(this).balance /3) {
        // update unlock 24 hours from now. 
        unlock_time = now + 24 hours;                  // now is a function refers to what time this current block was mined at, plus 24 hours in the future. 
        } 
        
        // transfer funds to the contract sender. 
        // put the transfer of money code as last line in withdraw function. 
        msg.sender.transfer(amount);                 // we don't have to decalre the msg.sender as payable. msg.sender is payable by default,
        
        
    }
    
    // test function to test contract if timelock not released. 
    function fastforward() public {
        fakenow += 100 days; 
    }
    
    function deposit() public payable {
        
        // update the last_to_deposit if the sender is different from the last value
        if(last_to_deposit != msg.sender) {
            last_to_deposit = msg.sender;
        }
        
        // update the last deposit block and deposit amount
        last_deposit_block = block.number;
        last_deposit_amount = msg.value;                         // value sent to that function in wei 
        
    }
    
    // fallback function in case an outside source sends us any miscellanous Ethereum 
    function() external payable{}
    
}