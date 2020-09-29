pragma solidity <0.6.0;

import "./Abstracts/TestContractInterface.sol";

contract BooleanOperators is TestContractInterface {

  function testOpcodes() public {

     //not
     assembly { pop( not(0x1f)) }

     //and
     assembly { pop(and(2,3)) }

     //or
     assembly { pop(or(3,3)) }

     //xor
     assembly { pop(xor(3,3)) }

  }

}