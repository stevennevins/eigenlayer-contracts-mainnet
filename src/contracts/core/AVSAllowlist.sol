// SPDX-License-Identifier: BUSL-1.1
pragma solidity =0.8.12;

import "@openzeppelin-upgrades/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin-upgrades/contracts/access/OwnableUpgradeable.sol";

contract AVSAllowlist is Initializable, OwnableUpgradeable {
    // Event emitted when an address is added to the allowlist
    event AVSAddedToAllowlist(address indexed avs); 

    // Event emitted when an address is removed from the allowlist
    event AVSRemovedFromAllowlist(address indexed avs);

    // Mapping of addresses to their allowlist status
    mapping(address => bool) public allowlist;

    constructor() {
        _disableInitializers();
    }

    /**
     * @dev Initializes owner
     */
    function initialize(address initialOwner) external initializer {
        _transferOwnership(initialOwner);
    }

    /**
     * @notice Adds an address to the allowlist
     */
    function addAVSToAllowlist(address avs) external onlyOwner {
        allowlist[avs] = true;
        emit AVSAddedToAllowlist(avs);
    }

    /**
     * @notice Removes an address from the allowlist
     */
    function removeAVSFromAllowlist(address avs) external onlyOwner {
        allowlist[avs] = false;
        emit AVSRemovedFromAllowlist(avs);
    }
}