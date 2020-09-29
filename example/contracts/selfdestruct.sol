pragma solidity <0.6.0;

import "./Abstracts/TestContractInterface.sol";

contract SelfDestruct is TestContractInterface {


  function testOpcodes() public {
     
     assembly { selfdestruct(0x02) }

  }
  
}     
     
