const path = require('path');
const fs = require('fs');
const solc = require('solc');


var inputs = {
    language: 'Solidity',
    sources: {
        'Fynya_Token.sol' : {
            content: fs.readFileSync('/home/techversant/NFT/Fynya_Blockchain/contracts/Fynya_Token.sol', 'utf8')
        },
    },
    settings: {
        outputSelection: {
            '*': {
                '*': [ '*' ]
            }
        }
    }
}; 
// const assetPath = path.resolve(__dirname, 'contracts', 'Asset.sol');
// const source = fs.readFileSync(assetPath, 'utf8');
// console.log('assetPath', assetPath)
// console.log('source', source)
// console.log(JSON.parse(solc.compile(JSON.stringify(inputs))).contracts['Assets.sol'].Asset);
module.exports = JSON.parse(solc.compile(JSON.stringify(inputs))).contracts['Fynya_Token.sol'].Fynya_Token;