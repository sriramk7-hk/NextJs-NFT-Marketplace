// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

error NftMarketplace__PriceMustBeAboveZero();

contract NftMarketplace {

    function listItem(address nftAddress, uint256 tokenId, uint256 price) external {
        if(price <= 0){
            revert NftMarketplace__PriceMustBeAboveZero();
        }
    }

}