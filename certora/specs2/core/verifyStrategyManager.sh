if [[ "$2" ]]
then
    RULE="--rule $2"
fi

solc-select use 0.8.12  

certoraRun certora/harnesses/StrategyManagerHarness.sol \
    lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol lib/openzeppelin-contracts/contracts/mocks/ERC1271WalletMock.sol \
    certora/munged/pods/EigenPodManager.sol certora/munged/pods/EigenPod.sol certora/munged/pods/DelayedWithdrawalRouter.sol \
    certora/munged/strategies/StrategyBase.sol certora/munged/core/DelegationManager.sol \
    certora/munged/core/Slasher.sol certora/munged/permissions/PauserRegistry.sol \
    --verify StrategyManagerHarness:certora/specs2/core/StrategyManager.spec \
    --optimistic_loop \
    --send_only \
    --staging \
    --settings -optimisticFallback=true,-optimisticUnboundedHashing=true \
    $RULE \
    --loop_iter 2 \
    --packages @openzeppelin=lib/openzeppelin-contracts @openzeppelin-upgrades=lib/openzeppelin-contracts-upgradeable \
    --msg "StrategyManager $1 $2" \