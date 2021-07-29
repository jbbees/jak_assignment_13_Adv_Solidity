pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/drafts/Counters.sol";

contract CryptoFax is ERC721Full {

    constructor() ERC721Full("CryptoFax", "CARS") public { }

    using Counters for Counters.Counter;
    Counters.Counter token_ids;

    struct Car {
      //Implement car struct
      
      string vin;
      uint accidents;
    }

    // Stores token_id => Car
    // Only permanent data that you would need to use in a smart contract later should be stored on-chain
    mapping(uint => Car) public cars;               // mapping will be structured as an integet pointing to a Car

    event Accident(uint token_id, string report_uri);

    function registerVehicle(/* Function parameters */) public returns(/* Function returns */) {
      //Implement registerVehicle
      
      token_ids.increment();                                 // increment
      uint token_id = token_ids.current();
      
      _mint(owner, token_id);
      _setTokenURI(token_id, token_uri);
      
      cars[token_id] = Car(vin, 0);        // create a new car item
      
      return token_id; 
    }

    function reportAccident(/* Function parameters */) public returns(/* Function returns */) {
       //Implement reportAccident
       
       cars[token_id].accidents += 1;
       
       // Permanently associates the report_uri with the token_id on-chain via Events for a lower gas-cost than storing it directly. 
       emit Accident(token_id, report_uri);
       
       return cars[token_id].accidents;
       
    }
}
