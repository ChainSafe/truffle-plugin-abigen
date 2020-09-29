pragma solidity <0.6.0;

import "./Abstracts/TestContractInterface.sol";

contract Env is TestContractInterface {


  function testOpcodes() public {

    assembly{
        pop(address())
        pop(balance(address()))
        pop(origin())
        pop(gasprice())
        pop(number())

        //blockhash of previous block
        pop(blockhash(sub(number(),1)))
        pop(coinbase())
        pop(timestamp())
        pop(difficulty())
        pop(gaslimit())
        pop(gas())

    }

  }

}