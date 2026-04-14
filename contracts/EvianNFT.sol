// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/token/ERC721/ERC721.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/access/Ownable.sol";

contract EvianNFT is ERC721, Ownable {
    uint256 public mintPrice = 0.01 ether;
    uint256 public maxSupply;
    uint256 public totalSupply;
    bool public paused;

    mapping(uint256 => string) private _tokenURIs;

    constructor(uint256 _maxSupply) ERC721("EvianNFT", "ENFT") Ownable(msg.sender) {
        maxSupply = _maxSupply;
    }

    function mint(string memory tokenURI_) external payable {
        require(!paused, "Minting is paused");
        require(totalSupply < maxSupply, "Max supply reached");
        require(msg.value >= mintPrice, "Insufficient ETH sent");

        totalSupply += 1;
        uint256 tokenId = totalSupply;

        _safeMint(msg.sender, tokenId);
        _tokenURIs[tokenId] = tokenURI_;
    }

    function setMintPrice(uint256 _newPrice) external onlyOwner {
        mintPrice = _newPrice;
    }

    function setPaused(bool _paused) external onlyOwner {
        paused = _paused;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(ownerOf(tokenId) != address(0), "Token does not exist");
        return _tokenURIs[tokenId];
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
