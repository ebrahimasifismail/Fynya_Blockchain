const path = require('path');
const fs = require('fs');
const solc = require('solc');


var inputs = {
    language: 'Solidity',
    sources: {
        'Assets.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/Asset.sol', 'utf8')
        },
        'erc721-enumerable.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/erc721-enumerable.sol', 'utf8')
        },
        'erc721-metadata.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/erc721-metadata.sol', 'utf8')
        },
        'erc721-token-receiver.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/erc721-token-receiver.sol', 'utf8')
        },
        'erc721.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/erc721.sol', 'utf8')
        },
        'nf-token-enumerable.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/nf-token-enumerable.sol', 'utf8')
        },
        'nf-token-metadata.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/nf-token-metadata.sol', 'utf8')
        },
        'nf-token.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/nf-token.sol', 'utf8')
        },
        'ownable.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/ownable.sol', 'utf8')
        },
        'safe-math.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/safe-math.sol', 'utf8')
        },
        'address-utils.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/address-utils.sol', 'utf8')
        },
        'erc165.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/erc165.sol', 'utf8')
        },
        'supports-interface.sol' : {
            content: fs.readFileSync('/home/ismail/ERC721/contracts/supports-interface.sol', 'utf8')
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
// console.log(JSON.parse(solc.compile(JSON.stringify(inputs))).contracts['Assets.sol'].Asset);
module.exports = JSON.parse(solc.compile(JSON.stringify(inputs))).contracts['Assets.sol'].Asset;