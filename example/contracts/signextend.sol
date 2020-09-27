pragma solidity <0.6.0;

import "./Abstracts/TestContractInterface.sol";

contract Signextend is TestContractInterface {


  function testOpcodes() public {

    assembly{ pop(signextend(1,10))}

  }

}