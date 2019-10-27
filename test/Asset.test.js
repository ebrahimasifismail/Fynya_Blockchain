const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const compiled_contract = require('../compile');
console.log('compiled_contract', compiled_contract.abi)
const interface_abi = compiled_contract.abi;
const bytecode = compiled_contract.evm.bytecode.object;
const web3 = new Web3(ganache.provider());

let accounts;
let asset;

beforeEach( async () => {
    accounts = await web3.eth.getAccounts();
    asset = await new web3.eth.Contract(interface_abi)
        .deploy({ data: bytecode  })
        .send({from: accounts[0], gas: 4000000})

});

describe('deploys an NFT contract', () => {
    it('deploys a contract', async()=>{
        await assert.ok(asset.options.address);
        console.log(asset.options.address);
    })
})