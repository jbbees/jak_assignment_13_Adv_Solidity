pragma solidity ^0.5.0;


// import OpenZeplin to get ERC20
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";

contract ArcadeToken is ERC20, ERC20Detailed {
   
   // using is will allow contract to inherit 
   
   address payable owner;            // add owner to token. owner defined in token constructor
   
   
   modifier onlyOwner {
       require(msg.sender == owner, "You do not have permission.");    // is the sender the owner. if so, 
       _;     // shortcut that says when onlyOwner
   }
       
   constructor(uint inital_supply) ERC20Detailed("Arcade Token", "ARCD", 18) public {
       owner = msg.sender;    // owner is who calls the function
       _mint(owner, inital_supply);
   }
   
   function mint(address recipient, uint amount) public {
       
       require(msg.sender == owner, "You do not have permission.");    // only the person calling the function can use this. 
       _mint(recipient, amount);     // creates new tokens and assigns to the recipient. 
   }
}