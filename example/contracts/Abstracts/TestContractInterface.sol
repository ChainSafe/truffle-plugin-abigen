pragma solidity <0.6.0;

contract TestContractInterface {

  address public owner;

  constructor() internal {
    owner = msg.sender;
  }

  modifier Owner (address _owner) {
    require(msg.sender == _owner);
    _;
  }

  function testOpcodes() public;
  
  //can await any of these in the main js file to see if anything fails
  function test_revert() public { assembly{ revert(0, 0) } }

  function test_invalid() public { assembly{ invalid() } }

  function test_stop() public { assembly{ stop() } }
}

