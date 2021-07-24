//SPDX-License-Identifier:MIT
pragma solidity ^0.8.6;

import "./Layer3.sol";
import "./Layer1.sol";

contract OrganizationContract {
    
    address public layer1ContractAddress;
    CertSystemLayer1 layer1Contract;
    
    uint public orgId;
    string public orgName;
    string public orgLink;
    uint public creationTime;
    uint public activityCount;
    uint[3] public totalUsedPack;     // [numberOfPack50, numberOfPack150, numberOfPackUnlimited]
    
    event UpdateInfo(uint OrgId, string OrgName, string Orglink);
    
    function updateInfo(uint _orgId, string memory _orgName, string memory _orglink) public {
        require(msg.sender == owner, "NO");
        orgId = _orgId;
        orgName = _orgName;
        orgLink = _orglink;
        emit UpdateInfo(_orgId, _orgName, _orglink);
    }
    
    function viewNumberOfPackRemain() public view returns(uint[3] memory) {
        uint[3] memory totalAffordPack = layer1Contract.viewTotalPackById(orgId);
        return([totalAffordPack[0] - totalUsedPack[0], totalAffordPack[1] - totalUsedPack[1], totalAffordPack[2] - totalUsedPack[2]]);
    }
    
    //owner
    address public owner;
    function setNewOwner(address newOwnerAddress) public {
        require(msg.sender == owner, 'NO');
        owner = newOwnerAddress;
    }
    
    //constructor
    constructor(uint _orgId, string memory _orgName, string memory _orglink) {
        orgId = _orgId;
        orgName = _orgName;
        orgLink = _orglink;
        owner = tx.origin;
        creationTime = block.timestamp;
        layer1Contract = CertSystemLayer1(msg.sender);
        layer1ContractAddress = msg.sender;
    }
    
    //Acitivities
    event AddActivity(Activity);
    event RemoveActivity(Activity);
    
    Activity[] allActivities;
    
    struct Activity {
        uint id;
        uint packageType;
        string name;
        address acitivityContractAddress;
    }
    
    function viewAllActivityAddress() public view returns(Activity[] memory) {
        return allActivities;
    }
    
    function addNewActivity(string memory _activityName, string memory _period, string memory _link, uint _packageType) public {
        require(msg.sender == owner, "NO");
        require(_packageType < 3, 'WPT');
        require(totalUsedPack[_packageType] < layer1Contract.viewTotalPackById(orgId)[_packageType], "PL");
        ActivityContract newActivty = new ActivityContract(activityCount, _activityName, address(this), _period, _link, _packageType);
        allActivities.push(Activity(activityCount,_packageType, _activityName, address(newActivty)));
        activityCount++;
        totalUsedPack[_packageType]++;
        emit AddActivity(Activity(activityCount,_packageType, _activityName, address(newActivty)));
    }
    
}
