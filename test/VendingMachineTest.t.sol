// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {VendingMachine} from "../src/VendingMachine.sol";

contract VendingMachineTest is Test {
    VendingMachine vendingMachine;
    address public user;

    // Run before each test function
    function setUp() public {
        vendingMachine = new VendingMachine();
        user = address(this);
    }

    function test_addProduct() public {
        // Arrange
        string memory name = "Coke";
        uint price = 100;
        uint256 stock = 10;
        string memory image = "coke.jpg";
        VendingMachine.ProductCategories productType = VendingMachine.ProductCategories.FOODS;

        // Act
        vendingMachine.addProduct(productType, name, price, stock, image);
        VendingMachine.Product[] memory products = vendingMachine.getProduct(productType);

        // Assert
        assertEq(products.length, 1);
        assertEq(products[0].name, name);
        assertEq(products[0].price, price);
        assertEq(products[0].stock, stock);
        assertEq(products[0].image, image);
    }

    function test_updateProductStock() public {
        // Arrange
        string memory name = "Coke";
        uint price = 100;
        uint256 stock = 10;
        string memory image = "coke.jpg";
        VendingMachine.ProductCategories productType = VendingMachine.ProductCategories.FOODS;

        vendingMachine.addProduct(productType, name, price, stock, image);

        // Act
        vendingMachine.updateProductStock(productType, 0, 5);
        VendingMachine.Product[] memory products = vendingMachine.getProduct(productType);

        // Assert
        assertEq(products[0].stock, stock + 5);
    }

    function test_buyProduct() public payable {
        // Arrange
        string memory name = "Coke";
        uint price = 100;
        uint256 stock = 10;
        string memory image = "coke.jpg";
        VendingMachine.ProductCategories productType = VendingMachine.ProductCategories.FOODS;

        vendingMachine.addProduct(productType, name, price, stock, image);

        // Act: Provide sufficient value to the contract
        uint256 expectedBalance = address(vendingMachine).balance + price * 1 ether;
        vendingMachine.buyProduct{value: price * 1 ether}(productType, 0);
        VendingMachine.Product[] memory products = vendingMachine.getProduct(productType);
        VendingMachine.Transaction[] memory transactions = vendingMachine.getTransaction();

        // Assert: Check the product stock decreases after purchase
        assertEq(products[0].stock, stock - 1);

        // Assert: Check the transaction is successful
        assertEq(transactions.length, 1);
        assertEq(transactions[0].productName, name);
        assertEq(transactions[0].productPrice, price);

        // Assert: Check the contract balance increased by the price
        assertEq(address(vendingMachine).balance, expectedBalance);
    }
}