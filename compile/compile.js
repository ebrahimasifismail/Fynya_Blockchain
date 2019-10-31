const path = require('path');
const fs = require('fs');
const solc = require('solc');
const path_to = '/home/techversant/NFT/Fynya_Blockchain/contracts'

var inputs = {
    language: 'Solidity',
    sources: {
        'Asset.sol' : {
            content: fs.readFileSync(path_to+'/Asset.sol', 'utf8')
        },
        'erc721-enumerable.sol' : {
            content: fs.readFileSync(path_to+'/erc721-enumerable.sol', 'utf8')
        },
        'erc721-metadata.sol' : {
            content: fs.readFileSync(path_to+'/erc721-metadata.sol', 'utf8')
        },
        'erc721-token-receiver.sol' : {
            content: fs.readFileSync(path_to+'/erc721-token-receiver.sol', 'utf8')
        },
        'erc721.sol' : {
            content: fs.readFileSync(path_to+'/erc721.sol', 'utf8')
        },
        'nf-token-enumerable.sol' : {
            content: fs.readFileSync(path_to+'/nf-token-enumerable.sol', 'utf8')
        },
        'nf-token-metadata.sol' : {
            content: fs.readFileSync(path_to+'/nf-token-metadata.sol', 'utf8')
        },
        'nf-token.sol' : {
            content: fs.readFileSync(path_to+'/nf-token.sol', 'utf8')
        },
        'ownable.sol' : {
            content: fs.readFileSync(path_to+'/ownable.sol', 'utf8')
        },
        'safe-math.sol' : {
            content: fs.readFileSync(path_to+'/safe-math.sol', 'utf8')
        },
        'address-utils.sol' : {
            content: fs.readFileSync(path_to+'/address-utils.sol', 'utf8')
        },
        'erc165.sol' : {
            content: fs.readFileSync(path_to+'/erc165.sol', 'utf8')
        },
        'supports-interface.sol' : {
            content: fs.readFileSync(path_to+'/supports-interface.sol', 'utf8')
        },
        'Fynya_Token.sol' : {
            content: fs.readFileSync(path_to+'/Fynya_Token.sol', 'utf8')
        }
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
console.log(JSON.parse(solc.compile(JSON.stringify(inputs))));
module.exports = JSON.parse(solc.compile(JSON.stringify(inputs))).contracts['Asset.sol'].Asset;