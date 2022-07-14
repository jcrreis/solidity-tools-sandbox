//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

// ver se slither apanha 
//(NÃO DETETA VULNERABILIDADE TYPE CASTS!!!)
abstract contract  CounterLibrary { 
    function add(uint) public virtual returns(uint);
    
}
abstract contract CounterLib  {
    function add(uint) public virtual returns (uint);
}

contract Game {
    function play(CounterLibrary c) public {
        c.add(1);
    }
}
