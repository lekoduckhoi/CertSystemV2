pragma solidity ^0.8.6;

import "./Layer2.sol";

contract CertSystemLayer1 {
    
    string public systemName = "Blockchain-based Certificate System";
    address public creator;
    uint public orgCount;
    
    // 3 options: 50/150/unlimited Certificate Activity   PackagePrice[0] = pack50Price; PackagePrice[1] = pack150Price , PackagePrice[2] = packunlimitedPrice;
    uint[3] public PackagePrice;
    
    function updatePrice(uint _pack50Price, uint _pack150Price, uint _packUnlimitedPrice) public {
        require(msg.sender == creator, 'must be creator');
        PackagePrice = [_pack50Price, _pack150Price, _packUnlimitedPrice];
    }
    
    //Organization
    event Register(Organization);
    event UpdatePackage(uint OrgId, uint UpdatedPaceType);
    
    Organization[] allOrganizations;
    
    mapping(uint => uint[3]) public totalAffordPackById;       //org id 1 => [totalPack50, totalPack150, totalPackUnlimited];
    
    struct Organization {
        uint orgId;
        string orgName;
        address orgOwner;
        address orgContractAddress;
    }
    
    function viewAllOrgAddress() public view returns(Organization[] memory) {
        return allOrganizations;
    }
    function viewTotalPackById(uint _id) public view returns(uint[3] memory) {
        return totalAffordPackById[_id];
    }
    
    function register(string memory _orgName, string memory _orglink, uint firstPackType) public payable {   // firstPackType can be 0,1,2 => 50,150,unlimited
        require(firstPackType < 3, "package does not exists");
        require(msg.value == PackagePrice[firstPackType], "wrong value");
        OrganizationContract newOrganization = new OrganizationContract(orgCount, _orgName, _orglink);
        allOrganizations.push(Organization(orgCount, _orgName, msg.sender, address(newOrganization)));
        totalAffordPackById[orgCount][firstPackType]++;
        orgCount++;
        emit Register(Organization(orgCount, _orgName, msg.sender, address(newOrganization)));
    }   
    
    function updatePackage(uint _orgId, uint addPackType) public payable { 
        require(msg.sender == allOrganizations[_orgId].orgOwner);
        require(addPackType < 3, "wrong pack type");
        require(msg.value == PackagePrice[addPackType], "wrong value");
        totalAffordPackById[_orgId][addPackType]++;
        emit UpdatePackage(_orgId, addPackType);
    }
    
    //withdraw function for creator
    function withdraw() public {
        require(msg.sender == creator, "must be creator");
        payable(creator).transfer(address(this).balance);
    }
    
    
}
