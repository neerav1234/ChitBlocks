//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;


contract Group {
    uint public end;
    uint public size = 65536;
    uint public current = 0;
    uint scheme1 =  1000000000000000 wei;
     struct Grp {
        uint256 totalDeposits;
        uint pointer;
        uint created;
        // mapping (uint=>address) members;
        address [10] members;
    }
    mapping (address => uint) public groupIds;
    // Grp[] public groups = new Grp[](size);

}