pragma solidity ^0.5.0;

//import OpenZeppelin token libs from github

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";     // extend additional features of ERC20 toksn 

contract ArcadeToken is ERC20, ERC20Detailed {                                        
    // our contract will inherit the ERC20 OpenZepplein imported code using the is keyword.
    
    // adding on top of token code imported
    address payable owner;
    
    
    // modifiers permit 
    //
    modifier onlyOwner {
        require(msg.sender == owner, "You do not have permssion.");     
        _;                                                              //  if the require statement passes, the _; kicks back to the function to run the rest of the code.  
    }
    
    
    // pass the name, symbol, and 18-decimal places 
    // contstructor should mint an inital supply
    
    // pass to the constructor the intial supply.
    // I am the owner 
    
    // constructor is public, anyone can deploy this contract, but mint function is internal and called 
    
    // constructor function is only called when you deploy the contract. 
    
    // since we imported ERC20Detailed.sol, we need to reference that programs constructor in our main constructor inline
    // main constructor passes initial_supply. ERC20Detailed constructor is then added. Passes the name, symboil, and 18-digits
    
    constructor(uint initial_supply) ERC20Detailed("Arcade Token", "ARCD", 18) public {                       // pass token name, token symbol, 18 decimakl places
        owner = msg.sender;                 // set the owner to the person who calls minting function
        _mint(owner, initial_supply);       // use mint() function to make more tokens. cannot be called externally, only internally. only owner can call mint function.
        
    }
    
    // public mint function requires modifier. 
    // before executing code, it will kick to the onlyOwner modifier and then kick back to mint()
    function mint(address recipient, uint amount) public onlyOwner {                                       // this function requires the onlyOwner modifier to pass. 
        // _mint() is only callable if onlyOwner modifier msg.sender==owner.
        _mint(recipient, amount);      // this will only call the mint() function if modifier passes. 
    }
    
    



    
}

