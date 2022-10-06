// SPDX-Lincense-Identifier: MIT
pragma solidity ^0.8.7;

contract Cron {
    uint256 public currentPrice;

    function uintFunction(uint256 _price) public {
        currentPrice = _price;
    }
}
