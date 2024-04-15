# Vending Machine Smart Contract

## Overview

This repository contains a Solidity smart contract for a decentralized vending machine. The vending machine contract enables users to add products, update their stock, and purchase items using cryptocurrency. It also allows the owner to withdraw accumulated funds.

## Features

- Add and manage products under different categories (e.g., foods, drinks).
- Update product stock levels.
- Purchase products using cryptocurrency.
- Secure ownership management with access control.

## Getting Started

Follow these steps to deploy and interact with the vending machine contract:

### Prerequisites

- Foundry and Forge installed on your machine.

### Installation and Deployment

1. Clone the repository:
   ```bash
   git clone https://github.com/mishraji874/Vending-Machine-Smart-Contract.git
2. Navigate to the project directory:
    ```bash
    cd Vending-Machine-Smart-Contract
3. Initialize Foundry and Forge:
    ```bash
    forge init
4. Create the ```.env``` file and paste the [Alchemy](https://www.alchemy.com/) api for the Sepolia Testnet and your Private Key from the Metamask.

5. Compile and deploy the smart contracts:

    If you want to deploy to the local network anvil then run this command:
    ```bash
    forge script script/DeployVendingMachine.s.sol --rpc-url {LOCAL_RPC_URL} --private-key {PRIVATE_KEY}
    ```
    If you want to deploy to the Sepolia testnet then run this command:
    ```bash
    forge script script/DeployVendingMachine.s.sol --rpc-url ${SEPOLIA_RPC_URL} --private-key ${PRIVATE_KEY}
### Running Tests

Run the automated tests for the smart contract:

```bash
forge test