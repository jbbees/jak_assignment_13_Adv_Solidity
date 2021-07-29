pragma solidity ^0.5.0;

//import SafeMath to resolve math operator vulnerability 

//import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";


contract ArtTokenVulnerable {
    
    // using SafeMath for uint;                                           // bring SafeMath code into contract that you imported. 
    
    address payable owner = msg.sender;
    string public symbol = "ART";
    uint public exchange_rate = 100;

    mapping(address => uint) balances;

    function balance() public view returns(uint) {
        return balances[msg.sender];
    }
    
    // Security Risk: Math operation vulnerability 
    function transfer(address recipient, uint value) public {
        balances[msg.sender] -= value;                                    // Security Risk: contract callers could subtract less than zero. Import safemath 
        // balances[msg.sender] = balances[msg.sender].sub(value);        // Using safemath disallows going below 0, it simply returns 0. 
        balances[recipient] += value;
        // balances[msg.sender] = balances[msg.sender].add(value)
    }

    function purchase() public payable {
        uint amount = msg.value * exchange_rate;
        balances[msg.sender] += amount;                                     // Security Risk, use SafeMath operators
        owner.transfer(msg.value);
    }

    // Security Risk: anyone can call the minting function 
    function mint(address recipient, uint value) public {                    // Security Risk: mint only passes in a recipient balance and increase their balance. No checks to control/ 
        // use a require statement to prevent anyone minting tokens. 
        balances[recipient] += value;
    }
    
    // Security Risk: Re-Entrance 
    function withdrawBalance() public{                                        // Calling withdraw balance, if successful, it withdraws remaining balance for msg.sender
       (bool success, ) = msg.sender.call.value(balances[msg.sender])("");    // Calls the value of the msg.value of the BALANCE 
        if( ! success ){                                                        
            revert();                                                         // If NOT successful the withdrawal, reverts.  
        }

        balances[msg.sender] = 0;                                             // sets the balance of msg.sender to zero. 
        
        // Fix 
        
        //uint amount = balances[msg.sender];                                 // put the remaining balance of msg.sender in an amount variable 
        //balances[msg.sender] = 0;                                           // set the balance of msg.sender 
        
        //(bool success, ) = msg.sender.call.value(balances[msg.sender])("");    // make the withdrawal os call.value(amount[msg.sender) not the balance. 
        //if( ! success ){
          //  revert();
        //}
        
        
    }
}
