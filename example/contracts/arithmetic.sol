pragma solidity <0.6.0;

import "./Abstracts/TestContractInterface.sol";

/*
* this contract deals with all the arithmetic opcodes that when popped off the stack
* return either the solution, 1 ,or 0
*/
contract Arithmetic is TestContractInterface {

  function testOpcodes() public {

    assembly{
      //addition
      pop(add(2,3))

      //subtraction
      pop(sub(3,1))

      //multiplication
      pop(mul(2,2))

      //division
      pop(div(4,2))

      //division for signed numbers in two's complement
      pop(sdiv(4,2))

      //modulus
      pop(mod(3,2))

      //modulus for signed numbers in two's complement
      pop(smod(3,2))

      //x to the power of y
      pop(exp(2,3))

      //(x + y) % m with arbitrary precision arithmetics
      pop(addmod(5, 3, 4))

      //(x * y) % m with arbitrary precision arithmetics
      pop(mulmod(3, 2, 4))

    }

  }

}

