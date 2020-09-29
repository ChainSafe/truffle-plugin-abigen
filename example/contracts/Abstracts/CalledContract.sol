pragma solidity <0.6.0;

contract CalledContract {

//   modifier Owner (address _owner) {
//     require(msg.sender == _owner);
//     _;
//   }

  function isSameAddress(address a, address b) internal returns(bool){
    if (a == b) return true;
    return false;
  }
}
