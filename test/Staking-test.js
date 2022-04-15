const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Staking", function () {
  it("Should return the new ending once it's changed", async function () {
    const Staking = await ethers.getContractFactory("Staking");
    const staking = await Staking.deploy();
    await staking.deployed();

    expect(await staking.stake()).to.equal("it worked!");

    
  });
});