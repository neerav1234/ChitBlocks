require("@nomiclabs/hardhat-waffle");
require('dotenv').config();

// Go to https://www.alchemyapi.io, sign up, create
// a new App in its dashboard, and replace "KEY" with its key
// const ALCHEMY_API_KEY = "https://eth-rinkeby.alchemyapi.io/v2/E-nfdgv8eUkPJjIrjaXZKo1YI4fuFQ27";

// Replace this private key with your Ropsten account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Be aware of NEVER putting real Ether into testing accounts
// const RINKEBY_PRIVATE_KEY = "YOUR ROPSTEN PRIVATE KEY";

module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      
      url: `https://eth-rinkeby.alchemyapi.io/v2/${process.env.RINKEBY_API_KEY}`,
      accounts: [`${process.env.RINKEBY_PRIVATE_KEY}`]
    }
  }
};