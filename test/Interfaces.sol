// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.4;

interface Erc20 {
	// function approve(address, uint256) external returns (bool);
	function transfer(address, uint256) external returns (bool);
	function balanceOf(address) external returns (uint256);
	function transferFrom(address, address, uint256) external returns (bool);
}

// NOTE: i see no reason to have an interface here, nothing needs to reference it besides the contract itself
// Allows anyone to claim a token if they exist in a merkle root.
// interface IDestributor {
  // Returns the address of the token distributed by this contract.
  // function token() external view returns (address);
  // function admin() external view returns (address);
  // Allows an admin to overwrite the current distribution with a new one
  // function distribute(address, address, uint256, bytes32) external;
  // Claim the given amount of the token to the given address. Reverts if the inputs are invalid.
  // function claim(uint256, address, uint256, bytes32[]) external;
  // Returns true if the index has been marked claimed.
  // function claimed(uint256, uint256) external view returns (bool);
  // Allows an admin to pause the current distribution
  // function pause(bool) external returns (bool);
// }
