pragma solidity ^0.5.0;

import "./PupperCoin.sol";

// importing ERC20.sol didn't solve the DeclarationError 
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// @TODO: Inherit the crowdsale contracts
contract PupperCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {

    // main contstructor & inherited contructors 
    // main constructor will need params from all constructors inherited 
    constructor(uint rate, address payable wallet, PupperCoin token, uint goal, uint open, uint close) 
       Crowdsale(rate, wallet, token) 
       // we won't need the Minted Crowdsale constructor because it doesn't do anything different/
       CappedCrowdsale(goal) 
       TimedCrowdsale(open, close) 
       RefundableCrowdsale(goal) public {}
       
        
}

contract PupperCoinSaleDeployer {

    address public token_sale_address;                         // stores the contract address of the PupperCoinSale 
    address public token_address;                              // stores the contract address of the Puppercoin token 

    constructor(
        // @TODO: Fill in the constructor parameters!
        
        string memory name,
        string memory symbol,
        address payable wallet,                                // this address will get the funds from the Token sale. 
        uint goal
        
    )
        public
    {
        // @TODO: create the PupperCoin and keep its address handy
        
        // invoke the Puppercoin contract 
        PupperCoin token = new PupperCoin(name, symbol, 0);  // we pass an initial supply of 0 Puppercoins. 
        
        token_address = address(token);                      // after token is made, stores the contract address 

        // @TODO: create the PupperCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        
        PupperCoinSale token_sale = new PupperCoinSale(1, wallet, token, goal, now, now + 24 weeks);     // we hardcode 1 so 1 token = 1 wei
                                                                   
        token_sale_address = address(token_sale);

        // make the PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}
