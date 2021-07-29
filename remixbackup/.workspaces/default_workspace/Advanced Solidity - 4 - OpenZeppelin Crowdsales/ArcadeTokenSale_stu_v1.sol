pragma solidity ^0.5.0;

// @TODO: Import ArcadeTokenMintable from ./ArcadeTokenMintable_stu_v2.sol

import "./ArcadeTokenMintable_stu_v2.sol";        // make sure we comment out the mint line in the ERC20 constructor

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract ArcadeTokenSale is Crowdsale, MintedCrowdsale {

    // @TODO: Build the constructor, passing in the parameters that Crowdsale needs
    
    constructor(
        uint rate, 
        address payable wallet, 
        ArcadeToken token
        )
    
    //secondary Crowdsale constructor, passes rate, wallet, and token 
    
    Crowdsale(rate, wallet, token) public {
        // empty constructor 
    }

}

contract ArcadeTokenSaleDeployer {

    // @TODO: Add public addresses to keep track of the token_address and arcade_sale_address
    
    address public arcade_sale_address;            //store contract address of ArcadeTokenSale when deplpyed
    address public token_address;                  //store contact address of ArcadeTokenMintable 

    constructor(
        string memory name,
        string memory symbol,
        address payable wallet // this address will receive all Ether raised by the sale
    )
        public
    {
        // @TODO: create the ArcadeToken and keep its address handy
        // Your code here!
         
        ArcadeToken token = new ArcadeToken(name, symbol, 0);                  // intitial supply is zero. 
        
        token_address = address(token);              //this allows us to easily fetch the token's address for later.
        
        // @TODO: create the ArcadeTokenSale and tell it about the token, then keep its address handy
        // Your code here!
        
        // pass rate, wallet, token 
        ArcadeTokenSale arcade_sale = new ArcadeTokenSale(1, wallet, token);      // rate is 1. 1 token = 1 Ether 
        
        arcade_sale_address = address(arcade_sale);
        

        // @TODO: make the ArcadeTokenSale contract a minter, then have the ArcadeTokenSaleDeployer renounce its minter role
        // Your code here!
        
        token.addMinter(arcade_sale_address);        //  ArcadeTokenSale is the minter not ArcadeTokenDeployer 
        token.renounceMinter();                      //  Taking the minter role away from ArcadeTokenDeployer
        
    }
}
