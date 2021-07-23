//SPDX-License-Identifier:MIT
pragma solidity ^0.8.6;

import "./Layer3.sol";

contract Organization {
    
    uint public orgId;
    string public orgName;
    string public orgLink;
    uint public creationTime;
    uint public activityCount;
    
    uint totalAddedActivity; //include removed activities
    
    event UpdateInfo(uint OrgId, string OrgName, string Orglink);
    
    function updateInfo(uint _orgId, string memory _orgName, string memory _orglink) public {
        require(msg.sender == owner, "must be owner");
        orgId = _orgId;
        orgName = _orgName;
        orgLink = _orglink;
        emit UpdateInfo(_orgId, _orgName, _orglink);
    }
    
    //owner
    address public owner;
    function setNewOwner(address newOwnerAddress) public {
        require(msg.sender == owner, 'must be owner');
        owner = newOwnerAddress;
    }
    
    //constructor
    constructor(uint _orgId, string memory _orgName, string memory _orglink) {
        orgId = _orgId;
        orgName = _orgName;
        orgLink = _orglink;
        owner = tx.origin;
        creationTime = block.timestamp;
    }
    
    //Acitivitys
    event AddActivity(Activity);
    event RemoveActivity(Activity);
    
    mapping(uint => Activity) public acitivityById;
    
    address[] public allActivityAdresses;
    
    struct Activity {
        uint id;
        string name;
        address acitivityContractAddress;
    }
    
    function viewAllActivityAddress() public view returns(address[] memory) {
        return allActivityAdresses;
    }
    
    function addNewActivity(string memory _activityName, string memory _period, string memory _link) public {
        require(msg.sender == owner, "must be owner");
        ActivityContract newActivty = new ActivityContract(totalAddedActivity, _activityName, orgName, _period, _link);
        acitivityById[activityCount] = Activity(totalAddedActivity, _activityName, address(newActivty));
        allActivityAdresses.push(address(newActivty));
        activityCount++;
        totalAddedActivity++;
        emit AddActivity(Activity(totalAddedActivity, _activityName, address(newActivty)));
    }
    
    function removeActivityById(uint _id) public {
        require(msg.sender == owner, "must be owner");
        activityCount--;
        delete allActivityAdresses[_id];
        delete acitivityById[_id];
        emit RemoveActivity(acitivityById[_id]);
    }
    
    
}
