//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "./Group.sol";
import "./Staking.sol";

contract Auctions {
    //parameters
    address payable public receiver;
    uint256 public auctionEndTime;

    //current state
    address public highestBidder;
    uint256 public highestBid;

    mapping(address => uint256) public pendingReturns; //bidder will first pay bid, then get refund, if not winner

    bool public ended = false;

    event IncresedHighestBid(address bidder, uint256 amount);
    event AuctionEnded(address winner, uint256 amount);

    Staking s;

    constructor(uint256 _biddingTime, address payable _receiver) {
        auctionEndTime = block.timestamp + _biddingTime;
        receiver = _receiver;
    }

    function bid() public payable {
        if (block.timestamp > auctionEndTime) {
            revert("The auction is already ended");
        }
        if (msg.value <= highestBid) {
            revert("There is already a higher bid");
        }
        if (highestBid != 0) {
            pendingReturns[highestBidder] += highestBid;
        }

        highestBid = msg.value;
        highestBidder = msg.sender;
        emit IncresedHighestBid(highestBidder, highestBid);
    }

    function withdraw() public returns (bool) {
        uint256 amount = pendingReturns[msg.sender];
        if (amount > 0) {
            pendingReturns[msg.sender] = 0;

            if (!(payable(msg.sender).send(amount))) {
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    function endAuction() public {
        if (block.timestamp < auctionEndTime) {
            revert("The auction is still alive");
        }
        if (ended) {
            revert("Auction already ended");
        }

        ended = true;
        s.rewardWinner(payable(highestBidder));
        emit AuctionEnded(highestBidder, highestBid);
    }
}
