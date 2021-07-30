//SPDX-License-Identifier:MIT
pragma solidity ^0.8.6;

import "./Layer2.sol";
import "./Layer3.sol";

contract CertSystemLayer1 {
    
    address public creator;
    uint public orgCount;
    
    constructor() {
        creator = msg.sender;
    }
    
    //limit for Organization
    mapping(address => uint) public maxProgramNumberOfOrg;
    mapping(address => uint) public maxTotalCertOfOrg;
    
    function setLimit(address _orgAddress, uint _maxProgram, uint _maxCert) public {
        require(msg.sender == creator, "NC");
        maxProgramNumberOfOrg[_orgAddress] = _maxProgram;
        maxTotalCertOfOrg[_orgAddress] = _maxCert;
    } 
    
    //finalized function
    mapping(address => uint) public numberOfProgramHasPaid;
    function finalized(address _orgAddress) public {      // call this function once the organization pay
        require(msg.sender == creator, "NC");
        numberOfProgramHasPaid[_orgAddress] = maxProgramNumberOfOrg[_orgAddress];
    }
    
    //Organization
    event Register(Organization);
    
    Organization[] public allOrganizations;
    
    mapping(address => bool) public isOrgAddress;              //Organization address create by this contract returns true

    struct Organization {
        uint orgId;
        string orgName;
        address orgOwner;
        address orgContractAddress;
    }
    
    function register(string memory _orgName, string memory _orglink, string memory _orgPic) public payable {   // firstPackType can be 0,1,2 => 50,150,unlimited
        OrganizationContract newOrganization = new OrganizationContract(orgCount, _orgName, _orglink, _orgPic);
        allOrganizations.push(Organization(orgCount, _orgName, msg.sender, address(newOrganization)));
        isOrgAddress[address(newOrganization)] = true;
        orgCount++;
        emit Register(Organization(orgCount, _orgName, msg.sender, address(newOrganization)));
    }   
    
    //verify system
    mapping(string => address) public ipfsToProgramAddress;           //return which activity address contain the certificate ipfs  ||  call this mapping to verify ipfs
    
    function setIpfsToActAddress(string memory _ipfs, bool _isAddFunc) public returns(bool) {   //_isAddFunc is true in addCert(), false in removeCert() in Layer3 contract
        require(isOrgAddress[ProgramContract(msg.sender).orgAddress()], "NO");
        require(OrganizationContract(ProgramContract(msg.sender).orgAddress()).isProgramAddress(msg.sender), "NA");
        if(_isAddFunc) {
            ipfsToProgramAddress[_ipfs] = msg.sender;
        } else {
            ipfsToProgramAddress[_ipfs] = address(0);
        }
        return true;
    }
}