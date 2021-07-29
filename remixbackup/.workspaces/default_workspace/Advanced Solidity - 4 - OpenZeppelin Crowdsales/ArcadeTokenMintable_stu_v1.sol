pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

contract ArcadeToken is ERC20, ERC20Detailed, ERC20Mintable {
    
    constructor(
        string memory name,                                // we do not end with ; inside () because this is a list of params for the constructor()
        string memory symbol,
        uint initial_supply
        )
        
    //Secondary constructor ERC20Detailed 
    
    ERC20Detailed(name, symbol, 18) public {              // this contructor is only called once at deployment 
        //mint(msg.sender, initial_supply);                 // mints initial supply of token on deployment. only the deployer is the owner, msg.sender, only they can mint tokens. 
    }
}
