//SPDX-License-Identifier:MIT
pragma solidity ^0.8.6;

contract Activity {
    
    //Activity Info
    string public activityName;        //Blockchain Course
    string public organization;        //Viasm
    string public period;              //10/7/1021 -> 11/7/2021
    string public link;                //viasm.edu.vn
    uint public createdTime;           //1610101010
    
    uint public certCount;          //total of available cert in contract
    uint totalAddedCert;            //including removed Certificate
    
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
    constructor(string memory _activityName, string memory _organization, string memory _period, string memory _link) {
        activityName = _activityName;
        organization = _organization;
        period = _period;
        link = _link;
        owner = tx.origin;
        createdTime = block.timestamp;
    }
    
    //cert
    event AddCertificate(Certificate newcert);
    event RemoveCertificate(Certificate removecert);
    
    mapping(string => Certificate) public certificateById;
    
    string[] allCertId;
    
    struct Certificate {
        uint certNumber;
        string issueTo;
        string id;
        string ipfsHash;
    }
    
    function viewAllCertId() public view returns(string[] memory) {
        return allCertId;
    }
    
    function addNewCerificate(string memory _issueTo, string memory _id, string memory _ipfsHash) public {
        require(msg.sender == owner, "must be owner");
        certificateById[_id] = Certificate(totalAddedCert, _issueTo, _id, _ipfsHash);
        allCertId.push(_id);
        certCount++;
        totalAddedCert++;
        ipfsHashExist[_ipfsHash] = true;
        emit AddCertificate(Certificate(totalAddedCert, _issueTo, _id, _ipfsHash));
    }
    
    function removeCertificateById(string memory _id) public {
        require(msg.sender == owner, "must be owner");
        delete allCertId[certificateById[_id].certNumber];
        delete certificateById[_id];
        certCount--;
        ipfsHashExist[certificateById[_id].ipfsHash] = false;
        emit RemoveCertificate(certificateById[_id]);
    }

    //verify
    mapping(string => bool) public ipfsHashExist;
    
}
