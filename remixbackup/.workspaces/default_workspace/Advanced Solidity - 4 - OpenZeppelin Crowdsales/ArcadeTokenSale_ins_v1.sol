pragma solidity ^0.5.0;

import "./ArcadeTokenMintable_ins_v1.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


// we create 2 contracts, one for the sale, a second for the deployment


contract ArcadeTokenSale is Crowdsale, MintedCrowdsale {
    
    constructor(uint rate, address payable wallet, ArcadeToken token)
        Crowdsale(rate, wallet, token) public {
            // invoke the Crowdsale.sol in this constructor. 
            // this is an empty constuctor because we imported code. 
        }
    
}



// temp contract 
contract ArcadeTokenSaleDeployer {
    
    // this contract helps deploy our tokens. it configures Arcade Token and Arcade Token Sale within the deployer 
    
    address public arcade_sale_address;                   // contract is the Arcadf
    address public token_address;                        // token contract is the ArcadeTokenMintable that mints tokens. minted token stored at this 
    
    
    // allows us to create the tokens 
    // wallet payable address is where we receive funds.
    
    constructor(string memory name, string memory symbol, address payable wallet) public {
        
        
        // create the Arcade token. name, symbol, initial suppy of zero
        ArcadeToken token = new ArcadeToken(name, symbol, 0);
        
        // takes the address of that token created and store it in the token_address variable
        token_address = address(token);
        
        
        // create token sale. invoke the ArcadeTokenSale constructor 
        
        // pass 1, the wallet, and the token we created. 
        ArcadeTokenSale arcade_sale = new ArcadeTokenSale(1, wallet, token);
        
        // store the address of the token sale in the arcade_sale_address variable. 
        arcade_sale_address = address(arcade_sale);
        
        
        // change minting roles. 
        
        // add minter role with arcade_sale_address. so ArcadeTokenSale contract is the minter of the token
        token.addMinter(arcade_sale_address);
        
        // take away minter role from the ArcadeTokenSale contructor within the ArcadeTokenSaleDeployer
        token.renounceMinter();
        
    }


    
}
