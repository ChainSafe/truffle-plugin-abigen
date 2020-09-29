pragma solidity <0.6.0;

import "./Abstracts/TestContractInterface.sol";

contract Create is TestContractInterface {


  function testOpcodes() public {

    assembly { pop(create(10, 0x123, 32)) }

  }
}