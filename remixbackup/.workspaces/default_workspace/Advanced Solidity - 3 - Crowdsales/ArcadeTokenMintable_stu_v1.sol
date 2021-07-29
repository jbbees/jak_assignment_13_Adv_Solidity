pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

contract ArcadeToken is ERC20, ERC20Detailed, ERC20Mintable {            // we put all imported .sol files in contract line separated by commas , 
    
    // make a constructor 
    constructor(
        string memory name,
        string memory symbol,
        uint inital_supply
        )
        
        // pass the the name and symbol variables. 
        ERC20Detailed(name, symbol, 18) public {
            mint(msg.sender, inital_supply) ;                  //msg.sender is only person who can mint the initial token supply when contract is deployed.
        }
        
}
