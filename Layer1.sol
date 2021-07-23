pragma solidity ^0.8.6;

import "./Layer2.sol";

contract CertSystemLayer1 {
    
    string public systemName = "Blockchain-based Certificate System";
    address public creator;
    
    uint public package50Price;
    uint public package150Price;
    uint public packageUnlimitedPrice;
    
    function updatePrice(uint _package50Price, uint _package150Price, uint _packageUnlimitedPrice) public {
        require(msg.sender == creator, 'must be creator');
        package50Price = _package50Price;
        package150Price = _package150Price;
        packageUnlimitedPrice = _packageUnlimitedPrice;
    }
    
    
}
