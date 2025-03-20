// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract HolidayCardNFT {
    string public name = "HolidayCardNFT";
    string public symbol = "HCNFT";
    uint256 private _tokenIds;

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => string) private _tokenURIs;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Mint(address indexed to, uint256 indexed tokenId, string tokenURI);

    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Invalid address");
        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token does not exist");
        return owner;
    }

    function mintNFT(address recipient, string memory tokenURI) public returns (uint256) {
        require(recipient != address(0), "Invalid recipient");
        _tokenIds++;
        uint256 newItemId = _tokenIds;
        _owners[newItemId] = recipient;
        _balances[recipient] += 1;
        _tokenURIs[newItemId] = tokenURI;

        emit Mint(recipient, newItemId, tokenURI);
        emit Transfer(address(0), recipient, newItemId);
        
        return newItemId;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "Token does not exist");
        return _tokenURIs[tokenId];
    }
}
