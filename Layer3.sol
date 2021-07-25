//SPDX-License-Identifier:MIT
pragma solidity ^0.8.6;

import "./Layer1.sol";
import "./Layer2.sol";

contract ActivityContract {
    
    //layer1Contract info
    address public layer1ContractAddress;
    CertSystemLayer1 layer1Contract;
    
    //Activity Info
    uint public activityId;                    //1 2 3...     
    string public activityName;        //Blockchain Course 
    address public orgAddress;          //organization contract address
    string public actPic;              //ipfs of picture of activity
    string public link;                //viasm.edu.vn
    uint public maxCertificateNumber;  // 50 / 150 / unlimited(0)
    
    uint public certCount;          //total of available cert in contract
    uint totalAddedCert;            //including removed Certificate
    
    
    event UpdateInfo(string ActivityName, string Pic, string Link);
    function updateInfo(string memory _activityName, string memory _actPic, string memory _link) public {
        require(msg.sender == owner, 'NO');
        activityName = _activityName;
        actPic = _actPic;
        link = _link;
        emit UpdateInfo(_activityName, _actPic, _link);
    }
    
    //owner
    address public owner;
    function setNewOwner(address newOwner) public {
        require(msg.sender == owner, 'NO');
        owner = newOwner;
    }
 
    //constructor
    constructor(uint _activityId, string memory _activityName, address _orgAddress, string memory _actPic, string memory _link, uint _packagetype) {
        //act info
        activityId = _activityId;
        activityName = _activityName;
        orgAddress = _orgAddress;
        actPic = _actPic;
        link = _link;
        owner = tx.origin;
        //package type
        if(_packagetype == 0) {
            maxCertificateNumber = 50;            
        } else if(_packagetype == 1) {
            maxCertificateNumber = 150;
        } // else maxCertificateNumber = 0 by default, => unlimited
        //layer1 contract info
        layer1ContractAddress = OrganizationContract(msg.sender).layer1ContractAddress();
        layer1Contract = CertSystemLayer1(layer1ContractAddress);
    }
    
    //cert
    event AddCertificate(Certificate newcert);
    event RemoveCertificate(Certificate removecert);
    
    mapping(string => Certificate) public certificateById;
    
    string[] public allCertId;
    
    struct Certificate {
        uint certNumber;
        string issueTo;
        string id;    //sha1
        string ipfsHash;
    }
    /*
    function viewAllCertId() public view returns(string[] memory) {
        return allCertId;
    }
    */
    function addNewCerificate(string memory _issueTo, string memory _id, string memory _ipfsHash) public {
        require(msg.sender == owner, "NO");
        if(maxCertificateNumber != 0) require(certCount < maxCertificateNumber, "LR");
        certificateById[_id] = Certificate(totalAddedCert, _issueTo, _id, _ipfsHash);
        allCertId.push(_id);
        certCount++;
        totalAddedCert++;
        //for verify system
        require(layer1Contract.setIpfsToActAddress(_ipfsHash), "CS");
        emit AddCertificate(Certificate(totalAddedCert, _issueTo, _id, _ipfsHash));
    }
    
    function removeCertById(string memory _id) public {
        require(msg.sender == owner, "NO");
        //for verify system
        require(layer1Contract.deleteIpfs(certificateById[_id].ipfsHash), "CD");
        //delete certificate Info
        delete certificateById[_id];
        delete allCertId[certificateById[_id].certNumber];
        certCount--;
        emit RemoveCertificate(certificateById[_id]);
    }

}