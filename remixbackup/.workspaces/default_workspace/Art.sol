pragma solidity ^0.5.0;

// import Open Zepplin libraries

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/drafts/Counters.sol";

contract ArtToken is ERC721Full {                                    // this will be an ERC721 Token  
    
    // use the OpenZepplin Counters imported above
    using Counters for Counters.Counter;
    Counters.Counter token_ids;
    
    
    // struct is stored as compactibly as possible
    // similar to python dictionary or object
    // struct doesn't need to be public 
    
    // define the structure of a piece of art 
    struct ArtWork {
        string name;                             // name of the art piece 
        string artist;                           // name of the artist
        uint appraisal_value;                    // art piece appraisal value 
    }
    
    
    // events are like print statements
    // data stored on chain, but not acceissible to other contracts
    // establishes a paper trail.
    // events cost less gas.
    
    // create event every time a piece of art is appraised. 
    
    //  print(f"New appraisal of {token_id} for 4{appraisal_value}")
    
    event Appraisal(uint token_id, uint appraisal_value, string report_url); 
    
    
    // art_collection[0] => art_piece_1,
    // art_collection[1] => art_piece_2,
    // "I own art_collection [6] return art_piece_6"
    
    mapping(uint => Artwork) public art_collection;
    
    
    constructor() ERC721Full("ArtToken", "ART") public {
        
    }
    
    function registerArtwork(address owner, 
              string memory name, 
              string memory artist, 
              uint inital_value, 
              string memory token_url) public returns(uint) {
                  
                  token_ids.increment();
                  uint token_id = token_ids.current();
                  
                  _mint(owner, token_id);
                  _setTokenURI(token_id, token_url);
                  art_collection[token_id] = Artwork(name, artist, inital_value);
                  return token_id; 
              }
              
     function newAppraisal(
               uint token_id,
               uint new_value, 
               string memory report_uri 
        ) public returns(uint) {
            art_collection[token_id].appraisal_value = new_value;
            emit Appraisal(token_id, new_value, report_uri);
            return art_collection[token_id].appraisal_value; 
        }
    
}