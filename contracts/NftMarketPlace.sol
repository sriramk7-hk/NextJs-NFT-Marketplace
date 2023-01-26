// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

error NftMarketplace__PriceMustBeAboveZero();
error NftMarketplace__NotApprovedForMarketPlace();
error NftMarketplace__AlreadyListed(address nftAddress, uint256 tokenId);

contract NftMarketplace {

    struct Listing{
        uint256 price;
        address seller;
    }

    event ItemListed(address indexed seller, address indexed nftAddress, address indexed tokenId, uint256 price);

    //NFTAddress -> TokenId -> Listing
    mapping (address => mapping (uint256 => Listing) ) private s_listing;

    modifier notListed(address nftAddress, uint256 tokenId, address owner) {
        Listing memory listing = s_listing[nftAddress][tokenId];
        if(listing.price > 0){
            revert NftMarketplace__AlreadyListed(nftAddress, tokenId); 
        }
    }


    function listItem(address nftAddress, uint256 tokenId, uint256 price) external {
        if(price <= 0){
            revert NftMarketplace__PriceMustBeAboveZero();
        }

        IERC721 nft = IERC721(nftAddress);
        if(nft.getApproved(tokenId) != (this)){
            revert NftMarketplace__NotApprovedForMarketPlace();
        }
        s_listing[nftAddress][tokenId] = Listing(price, msg.sender);
        emit ItemListd(msg.sender, nftAddress, tokenId, price);
    }

}