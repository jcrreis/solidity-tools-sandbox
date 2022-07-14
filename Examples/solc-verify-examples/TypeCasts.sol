//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

interface Counter {

    function add(uint num) external returns (uint);
}

contract FakeCounter is Counter{
    uint public counter;

    function add(uint num) public returns (uint){
        counter += 0;
        return counter;
    }
}

contract CounterLibrary is Counter{
    uint public counter;

    function add(uint num) public returns (uint){
        counter += num;
        return counter;
    }
}
// Como é bytecode level, dá falso positivos sempre que existe uma chamada externa
contract Game {
    function play(CounterLibrary c) public returns (uint){
        return c.add(1);
    }
    function getCounter(CounterLibrary c) public view returns (uint){
        return c.counter();
    }
}
