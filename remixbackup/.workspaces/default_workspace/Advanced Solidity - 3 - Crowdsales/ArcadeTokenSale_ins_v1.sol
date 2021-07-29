pragma solidity ^0.5.0;

import "./ArcadeTokenMintable_ins_v2.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract ArcadeTokenSale is Crowdsale, MintedCrowdsale {
    
    constructor(uint rate, address payable wallet, ArcadeToken token)
        Crowdsale(rate, wallet, token) public {
            //this will be empty
        }
    
}


contract ArcadeTokenSaleDeveloper {
    
    address public arcade_sale_address;
    address public token_address;
    
    constructor (string memory name, string memory symbol, address payable wallet) public {
        ArcadeToken token = new ArcadeToken(name, symbol, 0);                                                 //ArcadeTokenSaleDeveloper is the owner of tokens and can mint tokens
        token_address  address(token);
        
        // create Arcade token sealed
        ArcadeTokenSale arcade_sale = new ArcadeTokenSale(1, wallet, token);
        arcade_sale_address = address(arcade_sale);
    }
    
}