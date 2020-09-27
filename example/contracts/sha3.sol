pragma solidity <0.6.0;

import "./Abstracts/TestContractInterface.sol";

contract Sha3 is TestContractInterface {


  function testOpcodes() public {

    assembly{

    pop(calldataload(0))

    }

  }

}