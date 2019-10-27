pragma solidity >=0.4.21 <0.6.0;

import "./nf-token-metadata.sol";
import "./ownable.sol";


contract Asset is
  NFTokenMetadata,
  Ownable
{

  struct Item{
      string name;
      uint qty;
      uint std;
      uint cert_qty;
      uint expry;
      uint insurance;
      uint custom_clearance;
    }
   
    Item[] public Items;
 
  constructor()
    public
  {
    nftName = "Fynya Token";
    nftSymbol = "FYN";
  }

 
  function mint(address _to,string calldata name, uint qty ) external  onlyOwner returns(uint) {
    uint _tokenId=Items.length;
    Items.push(Item(name, qty, 0, 0,0, 0, 0 ));
    super._mint(_to, _tokenId);
    super._setTokenUri(_tokenId, "");
    return(_tokenId);
  }
 
 
  function assay(uint _tokenId,uint _cert_qty,uint _std,uint _expry) external onlyOwner  returns(uint) {
     
      Items[_tokenId].cert_qty=_cert_qty;
      Items[_tokenId].std=_std;
      Items[_tokenId].expry=_expry;
      return(_tokenId);
  }
 
  function insure(uint _tokenId,uint _insurance_id) external onlyOwner  returns(uint) {
     
      Items[_tokenId].insurance=_insurance_id;
      return(_tokenId);
  }
  function customs(uint _tokenId,uint _customs_id) external onlyOwner  returns(uint) {
     
      Items[_tokenId].custom_clearance=_customs_id;
      return(_tokenId);
  }

}