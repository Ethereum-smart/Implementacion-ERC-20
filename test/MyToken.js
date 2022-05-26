const { expect } = require("chai")
const { ethers } = require("hardhat")

const initialSupply = 100000;
const tokenName = "MyToken";
const tokenSymbol = "MTK";

describe("My token test", function() {

  before( async function(){
    const availableSigners = await ethers.getSigners();
    this.deployer = availableSigners[0];

    const MyToken = await ethers.getContractFactory("MyToken");
    this.myToken = await MyToken.deploy(tokenName, tokenSymbol);
    await this.myToken.deployed();
  })

  it("should have the correct name", async function() {
    const name = await this.myToken.name();
    expect(name).to.be.equal(tokenName);
  })

  it("should have the correct symbol", async function() {
    const symbol = await this.myToken.symbol();
    expect(symbol).to.be.equal(tokenSymbol);
  })

  it('Should have totalSupply passed in during deploying', async function() {
    const [ fetchedTotalSupply, decimals ] = await Promise.all([
      this.myToken.totalSupply(),
      this.myToken.decimals(),
    ]);
    const expectedTotalSupply = ethers.BigNumber.from(initialSupply).mul(ethers.BigNumber.from(10).pow(decimals));
    expect(fetchedTotalSupply.eq(expectedTotalSupply)).to.be.true;
  });

})