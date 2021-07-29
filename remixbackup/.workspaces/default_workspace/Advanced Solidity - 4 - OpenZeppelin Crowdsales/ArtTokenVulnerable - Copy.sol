pragma solidity ^0.5.0;

import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";

contract ArtTokenVulnerable {
    
    using SafeMath for uint; 
    
    address payable owner = msg.sender;
    string public symbol = "ART";
    uint public exchange_rate = 100;

    mapping(address => uint) balances;

    function balance() public view returns(uint) {
        return balances[msg.sender];
    }

    function transfer(address recipient, uint value) public {
        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[recipient] = balances[recipient].add(value);
    }

    function purchase() public payable {
        uint amount = msg.value * exchange_rate;
        balances[msg.sender] += amount;
        owner.transfer(msg.value);
    }

    function mint(address recipient, uint value) public {
        require(msg.sender == owner, "You do not have permission to mint tokens!");
        balances[recipient] += value;
    }

    function withdrawBalance() public{
        // function will withdraw remaining balance from msg.sender 
        
        
        // Set amount variable to balance of msg.sender before withdraw. 
        uint amount = balances[msg.sender];
        
        //Set the balance to zero. 
        balances[msg.sender] = 0;
        
        // Commence withdrawal
        // Change call.value(balances) to call.value(amount)
       (bool success, ) = msg.sender.call.value(balances[msg.sender])("");
        if( ! success ){
            revert();
        }

    }
}
