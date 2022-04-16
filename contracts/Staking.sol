//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "./Group.sol";
import "hardhat/console.sol";

contract Staking is Group {
    address public owner;
    address payable[] public members;
    mapping(address => uint256) public depositions;
    uint256 public auctionId;
    mapping(uint256 => address payable) public auctionHistory;
    uint256 totalDeposits;


    constructor() {
        owner = msg.sender;
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
        // allotGroup(msg.sender);
    }

    // function allotGroup(address callee) internal {
    //     groups[current].members[(groups[current].pointer)] = callee;
    //     groups[current].pointer++;
    //     groupIds[callee] = current;
    //     if (groups[current].pointer == 10) {
    //         current++;
    //     }
    // }

    function getMembers() public view returns (address payable[] memory) {
        return members;
    }

    function stake() external payable {
        if (block.timestamp < end) {
            revert("you are late");
        }
        if (msg.value != scheme1) {
            revert("you should pay 1 ether");
        }
        depositions[msg.sender] += msg.value;
        totalDeposits += msg.value;
    }

    function rewardWinner(address payable winner) public {
        winner.transfer(totalDeposits);
        totalDeposits = 0;
    }

    function getAuctionHistory(uint256 _auctionId)
        public
        view
        returns (address payable)
    {
        return auctionHistory[_auctionId];
    }

    function getTotal(uint _groupId) public view returns (uint256) {
        return totalDeposits;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
}
