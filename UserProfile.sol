//SPDX-License-Identifier:MIT
pragma solidity ^0.8.6;

import "./Layer1.sol";

contract ProfileFactory {
    
    CertSystemLayer1 layer1Conract;
    address public creator;
    
    constructor(address _layer1Address) {
        layer1Conract = CertSystemLayer1(_layer1Address);
        creator = msg.sender;
    }
    
    event CreateProfile(address User, address ProfileAddress);
    
    mapping(address => address) public profileAddressOfUser;
    
    function createProfile(string memory _name, string memory _idNumber, string memory _picIpfs, string memory _cvIpfs) public {
        require(profileAddressOfUser[msg.sender] == address(0), "AU");
        UserProfile _newProfile = new UserProfile(layer1Conract, _name, _idNumber, _picIpfs, _cvIpfs);
        profileAddressOfUser[msg.sender] = address(_newProfile);
        emit CreateProfile(msg.sender, address(_newProfile));
    }
}

contract UserProfile {
    
    CertSystemLayer1 layer1Conract;
    
     //info
    address public userAddress;
    string public name;
    string public idNumber;
    string public picIpfs;
    string public cvIpfs;
    uint public certCount;
    
    uint public totalAddedCert;    //include delete one
    
    constructor(CertSystemLayer1 _layer1Contract, string memory _name, string memory _idNumber, string memory _picIpfs, string memory _cvIpfs) {
        layer1Conract = _layer1Contract;
        userAddress = tx.origin;
        name = _name;
        idNumber = _idNumber;
        picIpfs = _picIpfs;
        cvIpfs = _cvIpfs;
    }
    
    event UpdateInfo(string Name, string IdNumber, string PicIpfs, string CvIpfs);
    
    function updateInfo(string memory _name, string memory _idNumber, string memory _picIpfs, string memory _cvIpfs) public {
        require(msg.sender == userAddress, "NU");
        name = _name;
        idNumber = _idNumber;
        picIpfs = _picIpfs;
        cvIpfs = _cvIpfs;
        emit UpdateInfo(_name, _idNumber, _picIpfs, _cvIpfs);
    } 
    
    //add cert to profile
    event AddCert(string Ipfs);
    event RemoveCert(string Ipfs);
    
    string[] public allCertIpfs;
    
    mapping(string => uint) public ipfsToIndex;
    mapping(string => bool) public ipfsExist;
    
    function viewAllCertIpfs() public view returns(string[] memory) {
        return allCertIpfs;
    }
    
    function addCertificate(string memory _ipfs) public {
        require(msg.sender == userAddress, "NU");
        address _actAddress = layer1Conract.ipfsToActAddress(_ipfs);
        require(_actAddress != address(0), "NF");
        allCertIpfs.push(_ipfs);
        ipfsToIndex[_ipfs] = totalAddedCert;
        ipfsExist[_ipfs] = true;
        certCount++;
        totalAddedCert++;
        emit AddCert(_ipfs);
    }
    
    function removeCertificate(string memory _ipfs) public {
        require(msg.sender == userAddress, "NU");
        require(ipfsExist[_ipfs], "NE");
        delete allCertIpfs[ipfsToIndex[_ipfs]];
        delete ipfsExist[_ipfs];
        certCount--;
        emit RemoveCert(_ipfs);
    }
    
    
}