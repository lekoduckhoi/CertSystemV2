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
    uint public programCount;
    int public totalCertCount;
    
    event UpdateInfo(uint OrgId, string OrgName, string Orglink);
    
    function updateInfo(uint _orgId, string memory _orgName, string memory _orglink, string memory _orgPic) public {
        require(msg.sender == owner, "NO");
        orgId = _orgId;
        orgName = _orgName;
        orgLink = _orglink;
        orgPic = _orgPic;
        emit UpdateInfo(_orgId, _orgName, _orglink);
    }
    
    function modifyTotalCert(bool _isAddFunc) public returns(bool) {  //use in layer 3 when add cert or remove cert // _isAddFunc is true in addFunc, false in removeFunc
        require(isProgramAddress[msg.sender], "NP");
        if(_isAddFunc) {
            totalCertCount++;
        } else {
            totalCertCount--;
        }
        return true;
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
    
    //programs
    event AddProgram(Program);
    event RemoveProgram(Program);
    
    Program[] public allPrograms;
    
    struct Program {
        uint id;
        string name;
        address programContractAddress;
    }
    
    mapping(address => bool) public isProgramAddress;
    
    function addNewProgram(string memory _programName, string memory _programPic, string memory _link) public {
        require(msg.sender == owner, "NO");
        require(programCount < layer1Contract.maxProgramNumberOfOrg(address(this)), "MP");
        ProgramContract newProgram = new ProgramContract(programCount, _programName, _programPic, _link);
        allPrograms.push(Program(programCount, _programName, address(newProgram)));
        isProgramAddress[address(newProgram)] = true;
        programCount++;
        emit AddProgram(Program(programCount, _programName, address(newProgram))); 
    }
    
}