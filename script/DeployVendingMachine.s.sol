//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {VendingMachine} from "../src/VendingMachine.sol";

contract DeployVendingMachine is Script {

    function run() external returns (VendingMachine) {
        vm.startBroadcast();
        VendingMachine vendingMachine = new VendingMachine();
        vm.stopBroadcast();
        return vendingMachine;
    }
}