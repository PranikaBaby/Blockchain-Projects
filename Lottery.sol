// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Lottery{
    address public manager;
    address payable[] public  players;
    address payable public winner;

    constructor(){
        manager=msg.sender;
    }
    function participate() public payable{
        require(msg.value==1 ether,"Please pay 1 ether only");
        players.push(payable (msg.sender));
    }
    function getbalance() public view returns (uint){
    require(manager==msg.sender,"You are not the manager");
    return address(this).balance;
    }

    function random() public view returns (uint){
    return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players.length)));
    }
    function pickWinner() public {
        require(manager==msg.sender,"You are not a manager");
        require(players.length>=3, "Players are less than 3");

        uint r=random();
        uint index=r%players.length;
        winner=players[index];
        winner.transfer(getbalance());
        players=new address payable[](0);
}


    }
