// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract VendingMachine {

    // Owner address
    address payable public owner;

    // Total balance obtained for the balance
    uint256 public ownerBalance;

    // Options on product categories
    enum ProductCategories {
        FOODS,
        DRINKS
    }

    // Product attributes
    struct Product {
        string name;
        uint price;
        uint256 stock;
        string image;
    }
    
    // Transaction attributes
    struct Transaction {
        address buyer;
        string productName;
        uint productPrice;
    }

    // List of transactions
    Transaction[] public transactions;

    // List product by ProductCategories enum as a key
    mapping(ProductCategories => Product[]) public products;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You don't have authorization to access this function");
        _;
    }

    function addProduct(
        ProductCategories _productType,
        string memory _name,
        uint _price,
        uint256 _stock,
        string memory _image
    ) public onlyOwner {
        products[_productType].push(Product(_name, _price, _stock, _image));
    }

    function updateProductStock(
        ProductCategories _productType,
        uint index,
        uint256 _amount
    ) public onlyOwner {
        require(index < products[_productType].length, "Index out of range");
        products[_productType][index].stock += _amount;
    }

    function buyProduct(
        ProductCategories _productType,
        uint index
    ) payable public {
        require(index < products[_productType].length, "Index out of range");
        Product storage product = products[_productType][index];
        require(product.stock > 0, "Out of stock");
        require(msg.value >= product.price * 1 ether, "Insufficient balance");
        require(msg.value == product.price * 1 ether, "Input an actual price");

        // Deduct product stock
        product.stock--;

        // Push the transaction to the transactions array
        transactions.push(Transaction({
            buyer: msg.sender,
            productName: product.name,
            productPrice: product.price
        }));

        // Update owner balance
        ownerBalance += product.price * 1 ether;
    }

    function withdrawBalance(uint256 _amount) public onlyOwner {
        require(_amount <= ownerBalance, "Insufficient balance");
        ownerBalance -= _amount;
        payable(owner).transfer(_amount);
    }

    function getProduct(ProductCategories _productType) public view returns (Product[] memory) {
        return products[_productType];
    }

    function getTransaction() public view returns (Transaction[] memory) {
        return transactions;
    }
}