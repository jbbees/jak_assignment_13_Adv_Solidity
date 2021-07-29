pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import

contract ArcadeToken is ERC20, ERC20Detailed {
    
    
    // token needs to know 3 things: name 
    constructor(
        string memory name,
        string memory symbol,
        uint initial_supply
        )
        
        ERCO20Detailed(name, symbol, 18) public {
            mint(msg.sender, inital_supply) ;                  //msg.sender is only person who can mint the initial token supply when contract is deployed.
        }
}
