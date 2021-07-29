pragma solidity ^0.5.0;

// import ERC20 and ERC20Detailed
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";

// new OpenZeppelin import ERC20Mintablle
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

contract ArcadeToken is ERC20, ERC20Detailed, ERC20Mintable {
   
    // token constructor, pass name, symbol, supply
    constructor (
        string memory name, 
        string memory symbol,
        uint initial_supply
        )
    
    // secondary contstructor passing in name, symbol, initial_supply
    // use 18 for supply param, Ethereum default
    ERC20Detailed(name, symbol, 18) public {
        
        
        //mint(msg.sender, initial_supply);                                 // when contract is deployed. it will call the mint function imported into the code. 
    }
    
}
