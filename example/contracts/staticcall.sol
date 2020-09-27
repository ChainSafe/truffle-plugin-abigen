pragma solidity <0.6.0;

import "./Abstracts/TestContractInterface.sol";

contract Staticcall is TestContractInterface {


  function testOpcodes() public {

    assembly{
        pop(staticcall(
                        5000, //gas
                        0x23, //address
                        0   , //argoffset
                        0   , //argslength
                        0   , //return offset
                        0     //return length

        ))

        

    }
  
  }
  
}