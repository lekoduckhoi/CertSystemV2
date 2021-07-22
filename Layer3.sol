pragma solidity ^0.8.6;

contract Activity {
    
    //Activity Info
    string public activityName;             //Blockchain Course
    string public organization;        //Viasm
    string public period;              //10/7/1021 -> 11/7/2021
    string public link;                //viasm.edu.vn
    uint public createdTime;           //1610101010
    
    function updateInfo(string memory _activityName, string memory _organization, string memory _period, string memory, string memory _link) public {
        require(msg.sender == owner, 'must be owner');
        activityName = _activityName;
        organization = _organization;
        period = _period;
        link = _link;
    }
    
    //owner
    address owner;
    function setNewOwner(address newOwnerAddress) public {
        require(msg.sender == owner, 'must be owner');
        owner = newOwnerAddress;
    }
 
    //constructor
    constructor(string memory _activityName, string memory _organization, string memory _period, string memory, string memory _link) {
        activityName = _activityName;
        organization = _organization;
        period = _period;
        link = _link;
        owner = tx.origin;
        createdTime = block.timestamp;
    }
    
    //cert
    event AddCertificate();
    
    struct Certificate {
        string issueTo;
        string id;
        string ipfsHash;
    }
    
    Certificate[] public certificates;
    
    
 
    
    
    
    
    
    
    
    
    
    
}
