// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MyNFT {
    string public name = "Evian NFT";
    string public symbol = "ENFT";

    uint256 public totalSupply;
    uint256 public maxSupply = 100;

    mapping(uint256 => address) public ownerOf;

    function mint() public {
        require(totalSupply < maxSupply, "Max supply reached");

        totalSupply++;
        ownerOf[totalSupply] = msg.sender;
    }
}
