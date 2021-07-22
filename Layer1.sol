pragma solidity ^0.8.6;

contract CertSystemLayer1 {
    
    address owner;
    constructor() {
        owner = msg.sender;
    }
    
    
    //organizations
    struct Organization {
        string name;
        string weblink;
        address CourseFacContract;
        uint8 numberOfCourse;
        
    }
    
    Organization[] oraganizations;
    
    //function register for organization
    
    function register(string memory _name) public {
        require(msg.sender == owner, "must be owner");
        //oraganizations.push(Organization())
    }
}
