pragma solidity <0.6.0;

import "./Abstracts/TestContractInterface.sol";

contract Memory is TestContractInterface {


  function testOpcodes() public {

    uint b = uint256(1234567);

    assembly{

        //load the free memory pointer
        let a := mload(0x40)
        //store uint256 of apples in first 32 bytes
        mstore(a, b)
        //add 4
        mstore8(a, 4)
        //this gonna be 0
        pop(msize())

    }

  }
  
}