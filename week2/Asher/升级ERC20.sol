// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleToken is ERC20 {
    address public owner;
    uint256 public maxSupply;
    
    event TokensMinted(address to, uint256 amount);
    event TokensBurned(address from, uint256 amount);
    
    constructor() ERC20("Simple Token", "STK") {
        owner = msg.sender;
        maxSupply = 1000000 * 10**decimals();
        
        _mint(msg.sender, 1000 * 10**decimals());
    }
    
    function mint(address to, uint256 amount) external {
        require(msg.sender == owner, "Only owner can mint");
        require(totalSupply() + amount <= maxSupply, "Exceeds max supply");
        
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }
    
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }
    
    function getRemaining() external view returns (uint256) {
        return maxSupply - totalSupply();
    }
}