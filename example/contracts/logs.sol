pragma solidity <0.6.0;


import "./Abstracts/TestContractInterface.sol";

contract Logs is TestContractInterface {

  function testOpcodes() public {

     uint256 _id = 0x420042;

     //log0
     log0(
         bytes32(0x50cb9fe53daa9737b786ab3646f04d0150dc50ef4e75f59509d83667ad5adb20)
     );

     //log1
     log1(
         bytes32(0x50cb9fe53daa9737b786ab3646f04d0150dc50ef4e75f59509d83667ad5adb20),
         bytes32(0x50cb9fe53daa9737b786ab3646f04d0150dc50ef4e75f59509d83667ad5adb20)
     );

     //log2
     log2(
         bytes32(0x50cb9fe53daa9737b786ab3646f04d0150dc50ef4e75f59509d83667ad5adb20),
         bytes32(0x50cb9fe53daa9737b786ab3646f04d0150dc50ef4e75f59509d83667ad5adb20),
         bytes32(uint256(msg.sender))
     );

     //log3
     log3(
         bytes32(0x50cb9fe53daa9737b786ab3646f04d0150dc50ef4e75f59509d83667ad5adb20),
         bytes32(0x50cb9fe53daa9737b786ab3646f04d0150dc50ef4e75f59509d83667ad5adb20),
         bytes32(uint256(msg.sender)),
         bytes32(_id)
     );

     //log4
     log4(
         bytes32(0x50cb9fe53daa9737b786ab3646f04d0150dc50ef4e75f59509d83667ad5adb20),
         bytes32(0x50cb9fe53daa9737b786ab3646f04d0150dc50ef4e75f59509d83667ad5adb20),
         bytes32(uint256(msg.sender)),
         bytes32(_id),
         bytes32(_id)

     );

  }
  
}