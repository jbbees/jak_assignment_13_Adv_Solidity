pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/drafts/Counters.sol";
import "./ICryptoRight.sol";

contract CryptoRight is ICryptoRight {                        // inherit the ICryptoRight import code
    
    // import counters. 
    using Counters for Counters.Counter;                     

    Counters.Counter copyright_ids;         // create a new counter that points to current copyright ID

    struct Work {
        address owner;
        string uri;
    }

    mapping(uint => Work) public copyrights;

    //function copyrights(uint copyright_id) public returns(IWork)

    event Copyright(uint copyright_id, address owner, string reference_uri);

    event OpenSource(uint copyright_id, string reference_uri);

    event Transfer(uint copyright_id, address new_owner);

    modifier onlyCopyrightOwner(uint copyright_id) {
        require(copyrights[copyright_id].owner == msg.sender, "You do not have permission to alter this copyright!");
        _;
    }

    function copyrightWork(string memory reference_uri) external {   
        
        // increment the uint associated with the mapping 
        copyright_ids.increment();
        uint id = copyright_ids.current();
        
        // update the copyrights mapping 
        copyrights[id] = Work(msg.sender, reference_uri);

        // fire the event 
        emit Copyright(id, msg.sender, reference_uri);
    }

    // Generates a new copyright_id of type uint and maps it to a given uri by calling copyright_uri
    function openSourceWork(string memory reference_uri) external {
        
        // increment the uint associated with the mapping 
        copyright_ids.increment();
        uint id = copyright_ids.current();

        // update the copyright mapping 
        copyrights[id].uri = reference_uri;
        
        // no need to set address(0) in the copyrights mapping as this is already the default for empty address types
        
        // fire the event 
        emit OpenSource(id, reference_uri);
    }

    // Re-maps a given copyright_id to a new copyright owner.
    // This function must only be callable by the address of the owner of the given copyright_id 
    function transferCopyrightOwnership(uint copyright_id, address new_owner) public onlyCopyrightOwner(copyright_id) {             // external means it can only be called outside the contract 
        // Re-maps a given copyright_id to a new copyright owner.
        copyrights[copyright_id].owner = new_owner;            

        emit Transfer(copyright_id, new_owner);
    }

    //Re-maps a given copyright_od to the 0x000000000000000000000000 addresss 
    function renounceCopyrightOwnership(uint copyright_id) external onlyCopyrightOwner(copyright_id) {
        // Re-maps a given copyright_id to the 0x0000000000000000000000000000000000000000
        transferCopyrightOwnership(copyright_id, address(0));

        emit OpenSource(copyright_id, copyrights[copyright_id].uri);
    }

    modifier onlyCopyrightOwner(uint copyright_id) {
        require(copyrights[copyright_id].owner == msg.sender, "You do not have permission to alter this copyright.");
    }
    
}
