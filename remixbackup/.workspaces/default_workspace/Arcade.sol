pragma solidity ^0.5.0;

// read in git hub repository
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol"

contract ArcadeToken{
    address payable owner = msg.sender;     //transfer money. owner can take all the ARCD from this contract
    string public symbol = 'ARCD';
    uint public exchange_rate = 100; 
    
    
    mapping(address => uint) balances; 
    
    // let us lookup a balance
    function balance() public view returns(uint) {             // view is not altering the blockchain
        return balances[msg.sender];                               
    }
    
    function transfer(address recipient, uint value) public {               // we are not marking address as payable. no ehtereum being transferred
        balances[msg.sender] -= value;         // take from sender
        //balances[msg.sender] = balances[msg.sender].sub(value);           //using safemath 
        balances[recipient] += value;          // add to recipient 
    }
    
    //getting tokens in first place
    
    function purchase() public payable {
        uint amount  = exchange_rate * msg.value;       // number of tokens we want to issue
        balances[msg.sender] += amount; 
        owner.transfer(msg.value); 
    }
    
    // mint new tokens
    
    function mint(address recipient, uint value) public {
        require(msg.sender == owner, "You do not have minting permissions.");      // require statement. we only want owner to mint new tokens. 
        balances[recipient] += value;
    }
}