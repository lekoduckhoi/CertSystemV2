//SPDX-License-Identifier:MIT
pragma solidity ^0.8.6;

import "./Layer3.sol";

contract Organization {
    
    uint public orgId;
    string public orgName;
    string public orgLink;
    uint public activityCount;
    
    //owner
    address owner;
    function setNewOwner(address newOwnerAddress) public {
        require(msg.sender == owner, 'must be owner');
        owner = newOwnerAddress;
    }
    
    //Acitivitys
    struct Acitivity {
        uint id;
        string name;
        address acitivityContractAddress;
    }
    
    function addNewActivity(string memory _activityName, string memory _period, string memory _link) public {
        require(msg.sender == owner, "must be owner");
        activityCount++;
        Activity newActivty = new Activity(_activityName, orgName, _period, _link);
        
    }
    
}
