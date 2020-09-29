pragma solidity <0.6.0;

import "./Abstracts/TestContractInterface.sol";

//if any of these fail ya'll are fucked :'(
/*
* this contract deals with all the arithmetic opcodes that when popped off the stack
* return either the solution, 1 ,or 0
*/
contract Comparators is TestContractInterface {

  function testOpcodes() public {

    assembly{

      // 1 if x < y, 0 otherwise
      pop(lt(1,4))

      // 1 if x > y, 0 otherwise
      pop(gt(3,3))

      //1 if x < y, 0 otherwise, for signed numbers in two’s complement
      pop(slt(1,4))

      //1 if x < y, 1 otherwise, for signed numbers in two’s complement
      pop(sgt(3,3))

      //1 if x == y, 0 otherwise
      pop(eq(2,2))

      //1 if x == 0, 0 otherwise
      pop(iszero(1))

    }

  }

}