//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "./Group.sol";

contract Staking is Group {
    address public owner;
    address payable[] public members;
    mapping(address => uint256) public depositions;
    uint public auctionId;
    mapping(uint=>address payable) public auctionHistory;
    uint public totalDeposits;

    constructor() {
        owner = msg.sender;
        totalDeposits=0;
    }

    // function initGroup(address[10] memory _members) external {
    //     groups[current].created = block.timestamp;
    //     groups[current].members = _members;
    //     for (uint256 i = 0; i < 10; i++) {
    //         groupIds[_members[i]] = current;
    //     }
    // }

    function enter() public {
        members.push(payable(msg.sender));
    }

    function getMembers() public view returns (address payable[] memory) {
        return members;
    }

    function stake() external payable {
        if(block.timestamp < end){
            revert("you are late");
        }
        depositions[msg.sender] += msg.value;
        totalDeposits+=msg.value;
    }

    function rewardWinner(address payable winner) public {
        winner.transfer(totalDeposits);
        totalDeposits=0;
    }

    function getAuctionHistory(uint _auctionId) public view returns (address payable) {
        return auctionHistory[_auctionId];
    }

    function getTotal() public view returns (uint) {
        return totalDeposits;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
}