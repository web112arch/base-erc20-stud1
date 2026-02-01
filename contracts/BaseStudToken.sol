// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BaseStudToken is
    ERC20,
    ERC20Capped,
    ERC20Burnable,
    Pausable,
    Ownable
{
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 cap_,
        uint256 initialSupply
    )
        ERC20(name_, symbol_)
        ERC20Capped(cap_)
        Ownable(msg.sender)
    {
        require(initialSupply <= cap_, "Initial supply exceeds cap");
        _mint(msg.sender, initialSupply);
    }

    /* ========== ADMIN ========== */

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    /* ========== INTERNAL OVERRIDES ========== */

    function _update(
        address from,
        address to,
        uint256 value
    ) internal override(ERC20, ERC20Capped) whenNotPaused {
        super._update(from, to, value);
    }
}