// SPDX-License-Identifier: BUSL-1.1
pragma solidity =0.8.12;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "src/contracts/core/AVSAllowlist.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";


contract DeployAllowlist is Script {
    AVSAllowlist public allowlist;
    AVSAllowlist public allowlistImplementation;
    address owner = 0x42596484594AFAc24691be2EA9f40D16e9e541Fd;
    function run() external {

        vm.startBroadcast();
        ProxyAdmin proxyAdmin = new ProxyAdmin();

        allowlistImplementation = new AVSAllowlist();
        allowlist = AVSAllowlist(
            address(
                new TransparentUpgradeableProxy(
                    address(allowlistImplementation),
                    address(proxyAdmin),
                    abi.encodeWithSelector(
                        allowlistImplementation.initialize.selector,
                        owner
                    )
                )
            )
        );

        vm.stopBroadcast();
    }
}