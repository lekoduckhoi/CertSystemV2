//SPDX-License-Identifier:MIT
pragma solidity ^0.8.6;

import "./Layer3.sol";
import "./Layer1.sol";

contract OrganizationContract {
    
    CertSystemLayer1 public layer1Contract;
    
    uint public orgId;
    string public orgName;
    string public orgLink;
    string public orgPic;
    uint public activityCount;
    uint[3] public totalUsedPack;     // [numberOfPack50, numberOfPack150, numberOfPackUnlimited]
    
    event UpdateInfo(uint OrgId, string OrgName, string Orglink);
    
    function updateInfo(uint _orgId, string memory _orgName, string memory _orglink, string memory _orgPic) public {
        require(msg.sender == owner, "NO");
        orgId = _orgId;
        orgName = _orgName;
        orgLink = _orglink;
        orgPic = _orgPic;
        emit UpdateInfo(_orgId, _orgName, _orglink);
    }
    
    //owner
    address public owner;
    function setNewOwner(address newOwner) public {
        require(msg.sender == owner, 'NO');
        owner = newOwner;
    }
    
    //constructor
    constructor(uint _orgId, string memory _orgName, string memory _orglink, string memory _orgPic) {
        orgId = _orgId;
        orgName = _orgName;
        orgLink = _orglink;
        orgPic = _orgPic;
        owner = tx.origin;
        layer1Contract = CertSystemLayer1(msg.sender);
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
    
    mapping(address => bool) public isActAddress;
    
    function viewAllActivities() public view returns(Activity[] memory) {
        return allActivities;
    }
    
    function addNewActivity(string memory _activityName, string memory _actPic, string memory _link, uint _packageType) public {
        require(msg.sender == owner, "NO");
        require(_packageType < 3, 'WPT');
        require(totalUsedPack[_packageType] < layer1Contract.totalAffordPackById(orgId, _packageType),"PL");
        ActivityContract newActivty = new ActivityContract(activityCount, _activityName, _actPic, _link, _packageType);
        allActivities.push(Activity(activityCount,_packageType, _activityName, address(newActivty)));
        isActAddress[address(newActivty)] = true;
        activityCount++;
        totalUsedPack[_packageType]++;
        emit AddActivity(Activity(activityCount,_packageType, _activityName, address(newActivty)));
    }
    
}