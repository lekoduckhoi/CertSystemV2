//SPDX-License-Identifier:MIT
pragma solidity ^0.8.6;

import "./Layer2.sol";
import "./Layer3.sol";

contract CertSystemLayer1 {
    
    address public creator;
    uint public orgCount;
    
    // 3 options: 50/150/unlimited Certificate Activity   PackagePrice[0] = pack50Price; PackagePrice[1] = pack150Price , PackagePrice[2] = packunlimitedPrice;
    uint[3] public PackagePrice;
    
    
    function updatePrice(uint _pack50Price, uint _pack150Price, uint _packUnlimitedPrice) public {
        require(msg.sender == creator, 'NC');
        PackagePrice = [_pack50Price, _pack150Price, _packUnlimitedPrice];
    }
    
    constructor() {
        creator = msg.sender;
    }
    
    //Organization
    event Register(Organization);
    event UpdatePackage(uint OrgId, uint UpdatedPaceType);
    
    Organization[] public allOrganizations;
    
    mapping(uint => uint[3]) public totalAffordPackById;       //org id 1 => [totalPack50, totalPack150, totalPackUnlimited];
    mapping(address => bool) public isOrgAddress;              //Organization address create by this contract returns true

    struct Organization {
        uint orgId;
        string orgName;
        address orgOwner;
        address orgContractAddress;
    }
    
    function register(string memory _orgName, string memory _orglink, string memory _orgPic, uint firstPackType) public payable {   // firstPackType can be 0,1,2 => 50,150,unlimited
        require(firstPackType < 3, "PNF");
        require(msg.value == PackagePrice[firstPackType], "WV");
        OrganizationContract newOrganization = new OrganizationContract(orgCount, _orgName, _orglink, _orgPic);
        allOrganizations.push(Organization(orgCount, _orgName, msg.sender, address(newOrganization)));
        isOrgAddress[address(newOrganization)] = true;
        totalAffordPackById[orgCount][firstPackType]++;
        orgCount++;
        emit Register(Organization(orgCount, _orgName, msg.sender, address(newOrganization)));
    }   
    
    function updatePackage(uint _orgId, uint addPackType) public payable { 
        require(msg.sender == allOrganizations[_orgId].orgOwner);
        require(addPackType < 3, "WPT");
        require(msg.value == PackagePrice[addPackType], "WV");
        totalAffordPackById[_orgId][addPackType]++;
        emit UpdatePackage(_orgId, addPackType);
    }
    
    //withdraw function for creator
    function withdraw() public {
        require(msg.sender == creator, "must be creator");
        payable(creator).transfer(address(this).balance);
    }
    
    //verify system
    mapping(string => address) public ipfsToActAddress;           //return which activity address contain the certificate ipfs  ||  call this mapping to verify ipfs
    
    function setIpfsToActAddress(string memory _ipfs) public returns(bool) {
        require(isOrgAddress[ActivityContract(msg.sender).orgAddress()], "NO");
        require(OrganizationContract(ActivityContract(msg.sender).orgAddress()).isActAddress(msg.sender), "NA");
        ipfsToActAddress[_ipfs] = msg.sender;
        return true;
    }

    function deleteIpfs(string memory _ipfs) public returns(bool) {
        require(isOrgAddress[ActivityContract(msg.sender).orgAddress()], "NO");
        require(OrganizationContract(ActivityContract(msg.sender).orgAddress()).isActAddress(msg.sender), "NA");
        ipfsToActAddress[_ipfs] = address(0);
        return true;
    }
    
}