//SPDX-License-Identifier:MIT
pragma solidity ^0.8.6;

import "./Layer1.sol";
import "./Layer2.sol";

contract ProgramContract { 
    
    //layer1,2 Contract info
    CertSystemLayer1 layer1Contract;
    OrganizationContract layer2Contract;
    
    //Activity Info
    uint public programId;                    //1 2 3...     
    string public programName;        //Blockchain Course 
    address public orgAddress;          //organization contract address
    string public programPic;              //ipfs of picture of activity
    string public link;                //viasm.edu.vn
    
    uint public totalAddedCert;            //including removed Certificate
    
    
    event UpdateInfo(string ProgramName, string Pic, string Link);
    function updateInfo(string memory _programName, string memory _programPic, string memory _link) public {
        require(msg.sender == owner, 'NO');
        programName = _programName;
        programPic = _programPic;
        link = _link;
        emit UpdateInfo(_programName, _programPic, _link);
    }
    
    //owner
    address public owner;
    function setNewOwner(address newOwner) public {
        require(msg.sender == owner, 'NO');
        owner = newOwner;
    }
 
    //constructor
    constructor(uint _programId, string memory _programName, string memory _programPic, string memory _link) {
        //act info
        programId = _programId;
        programName = _programName;
        orgAddress = msg.sender;
        programPic = _programPic;
        link = _link;
        owner = tx.origin;
        //layer1 contract info
        layer2Contract = OrganizationContract(msg.sender);
        layer1Contract = layer2Contract.layer1Contract();
    }
    
    //cert
    event AddCertificate(Certificate Newcert);
    event RemoveCertificate(Certificate Removecert);
    
    mapping(string => Certificate) public certificateById;
    
    string[] public allCertId;
    
    struct Certificate {
        uint certNumber;
        string issueTo;
        string id;    //sha1
        string ipfsHash;
    }
    
    function addNewCerificate(string memory _issueTo, string memory _id, string memory _ipfsHash) public {
        require(msg.sender == owner, "NO");
        require(uint(layer2Contract.totalCertCount()) < layer1Contract.maxTotalCertOfOrg(orgAddress), "MC");
        require(layer2Contract.modifyTotalCert(true), "CM");
        certificateById[_id] = Certificate(totalAddedCert, _issueTo, _id, _ipfsHash);
        allCertId.push(_id);
        totalAddedCert++;
        //for verify system
        require(layer1Contract.setIpfsToActAddress(_ipfsHash, true), "CS");
        emit AddCertificate(Certificate(totalAddedCert, _issueTo, _id, _ipfsHash));
    }
    
    function removeCertById(string memory _id) public {
        require(msg.sender == owner, "NO");
        require(keccak256(abi.encodePacked((allCertId[certificateById[_id].certNumber]))) != keccak256(abi.encodePacked((""))), "AR"); //check if cert exists
        require(layer2Contract.modifyTotalCert(false), "CM");
        //for verify system
        require(layer1Contract.setIpfsToActAddress(certificateById[_id].ipfsHash, false), "CS");
        //delete certificate Info
        delete certificateById[_id];
        delete allCertId[certificateById[_id].certNumber];
        emit RemoveCertificate(certificateById[_id]);
    }

}