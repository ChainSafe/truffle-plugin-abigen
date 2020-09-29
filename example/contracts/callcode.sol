pragma solidity <0.6.0;

import "./Abstracts/CalledContract.sol";
import "./Abstracts/TestContractInterface.sol";

contract Call is CalledContract, TestContractInterface {

  CalledContract calledContract;

  constructor() public {
    calledContract = new CalledContract();
  }

  function testOpcodes() public {

    //https://ethereum.stackexchange.com/questions/67980/solidity-assembly-function-call-parameter-alignment?noredirect=1&lq=1

    address contractAddr = address(calledContract);
    bytes4 sig = bytes4(keccak256("isSameAddress(address,address)")); //Function signature
    address a = msg.sender;

     assembly {
         let ptr := mload(0x40)       //Find empty storage location using "free memory pointer"
         mstore(ptr,sig)              //Place signature at begining of empty storage
         mstore(add(ptr,0x04),a)      //First address parameter. just after signature
         mstore(add(ptr,0x24),a)      //2nd address parameter - first padded. add 32 bytes (not 20 bytes)
         mstore(0x40,add(ptr,0x64))   //Reset free pointer before the function call so we can actually use it!
                                      //New free pointer position after the output values of the called function.

         let success := callcode(
                         5000,         //5k gSas
                         contractAddr, //To addr
                         0,            //No wei passed
                         ptr,          //Inputs are at location of ptr
                         0x44,         //Inputs size two padded, so 68 bytes
                         ptr,          //Store output over input
                         0x20)         //Output is 32 bytes long
     }

  }
  
}
