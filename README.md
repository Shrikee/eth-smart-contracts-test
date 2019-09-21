# eth-Smart Contracts test

using Solidity to build smart contract, web3 to access contract data, metamask browser extension, nuxt.js as frontend.

## Installation

- run npm i inside project root and in frontend dir
- create .env inside frontend dir with:

```js
CONTRACT_ADDRESS;
SENDER_ADDRESS;
```

## Usage

At index page you can create new item(Shop) and system will add lat-lng coordinates and timestamp to this item and push it to smart contract.

List page will display all items you have added with values I mentioned above.

Details page will give you the location(pin on the map with coords) of user when he submitted the item.
