// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/contracts/libraries/BeaconChainProofsContract.sol";
import "../src/test/utils/ProofParsing.sol";


contract BeaconChainProofsScript is Script, ProofParsing {
    function run() external {
        BeaconChainProofsContract beaconChainProofs = BeaconChainProofsContract(0x6c9aBEBdF40265028Da0aB1EE6CD2fEAa402ccD5);
        //setJSON("script/deneb_withdrawal_against_deneb_state.json");
        // setJSON("script/capella_withdrawal_against_deneb_state.json");
        setJSON("script/capella_withdrawal_against_capella_state.json");
        bytes memory withdrawalProof = abi.encodePacked(getWithdrawalProofCapella());
        bytes memory timestampProof = abi.encodePacked(getTimestampProofCapella());
        BeaconChainProofsContract.WithdrawalProof memory withdrawalProofStruct =
                BeaconChainProofsContract.WithdrawalProof(
                    abi.encodePacked(getWithdrawalProofCapella()),
                    abi.encodePacked(getSlotProof()),
                    abi.encodePacked(getExecutionPayloadProof()),
                    abi.encodePacked(getTimestampProofCapella()),
                    abi.encodePacked(getHistoricalSummaryProof()),
                    uint64(getBlockRootIndex()),
                    uint64(getHistoricalSummaryIndex()),
                    uint64(getWithdrawalIndex()),
                    getBlockRoot(),
                    getSlotRoot(),
                    getTimestampRoot(),
                    getExecutionPayloadRoot()
                );
        bytes32 beaconStateRoot = getBeaconStateRoot();
        bytes32[] memory withdrawalFields = getWithdrawalFields();
        uint64 denebForkTimestamp = 1705473120;


        vm.startBroadcast();
        beaconChainProofs.verifyWithdrawal(beaconStateRoot, withdrawalFields, withdrawalProofStruct, denebForkTimestamp);

        vm.stopBroadcast();

    }
}
