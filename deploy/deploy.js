const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const compiled_contract = require('../compile/compile');

const interface_abi = compiled_contract.abi;
const bytecode = compiled_contract.evm.bytecode.object;
// console.log("compiled contract", compiled_contract);
// console.log('interface_abi', interface_abi)
// console.log('bytecode', bytecode)

const provider = new HDWalletProvider(
    'history dolphin enable arrest case lens battle patient brush punch license educate',
    'https://rinkeby.infura.io/v3/1456cd94a86d409696c6589e6b2974dd'
)

const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();
    console.log('account address', accounts[0]);
    const asset = await new web3.eth.Contract(interface_abi)
        .deploy({ data: bytecode })
        .send({ from: accounts[0], gas: 6000000 });

    console.log('Contract deployed to', asset.options.address);
}
deploy();