pragma solidity >=0.4.21 <0.6.0;

import "./nf-token-metadata.sol";
import "./ownable.sol";
import "./Fynya_Token.sol";


contract Asset is
  NFTokenMetadata,
  Ownable
{

  struct Certificate {
      uint certificate_id;
      string consignment_name;
      string consignment_quantity;
      string consignment_standard;
      string assay_transaction_id;
      address consignment_owner;
      address warehousePublicAddress;
      bool isAssayed;
      bool isInsured;
      bool isCustomsCleared;
      bool ShippingCleared;
}

  mapping(uint => bool) isAssayed;
  mapping(uint => bool) isInsured;
  mapping(uint => bool) isCustomsCleared;
  mapping(uint => bool) isShippingCleared;
 
  uint[] CertificatesAssayedList;
  uint[] CertificatesInsuredList;
  uint[] CertificatesCutsomsClearedList;
  uint[] CertificatesShippedList;
 
  mapping(address => bool) isAssayingAuthority;
  mapping(address => bool) isInsuringAuthority;
  mapping(address => bool) isCustomsAuthority;
  mapping(address => bool) isShippingAuthority;
  mapping(address => bool) isWarehouse;
 
  address[] AssayerList;
  address[] InsurerList;
  address[] CustomsList;
  address[] ShipperList;
  address[] WarehouseList;
   
  Certificate[] public Certificates;
  uint token_balance;
  Fynya_Token _token = Fynya_Token(address(0x94A008C18020905a1E2c4fa81136528694a9834D));
   
  constructor()
    public
  {
    nftName = "Fynya Token";
    nftSymbol = "FYN";
  }
 
  function addAssayer(address _newAssayer) public onlyOwner returns (bool) {
    AssayerList.push(_newAssayer);
    isAssayingAuthority[_newAssayer] = true;
    return true;
  }
 
  function addInsurer(address _newInsurer) public onlyOwner returns (bool) {
      InsurerList.push(_newInsurer);
      isInsuringAuthority[_newInsurer] = true;
      return true;
  }
 
  function addCustoms (address _newCustoms) public onlyOwner returns (bool) {
      CustomsList.push(_newCustoms);
      isInsuringAuthority[_newCustoms] = true;
      return true;
  }
 
  function addShipper(address _newShipper) public onlyOwner returns (bool) {
      ShipperList.push(_newShipper);
      isShippingAuthority[_newShipper] = true;
      return true;
  }
 
  function addWarehouse(address _warehouse) public onlyOwner returns (bool) {
      WarehouseList.push(_warehouse);
      isWarehouse[_warehouse] = true;
      return true;
  }
 
//   function mint(address _to ) external  onlyOwner returns(uint) {
//     uint _tokenId=Certificates.length;
//     super._mint(_to, _tokenId);
//     super._setTokenUri(_tokenId, "");
//     return(_tokenId);
//   }
 
  function fynyaTokenBalance(address _enquire) public view returns (uint balance) {
      return(_token.fynyatokenbalance(_enquire));
    }
   
  function fynyaTokenApprove(address _to, uint _value) public payable returns (bool success) {
      return _token.approve(_to, _value);
  }
 
  function fynyaTokenTransfer(address _to, uint _value) public payable returns (bool success) {
      return _token.transfer(_to, _value);
  }
 
  function findSender() public view returns (address sender) {
      return _token.getMsgSender();
  }
 
  function toAssay(
      string calldata _consignment_name,
      string calldata _consignment_quantity,
      string calldata _consignment_standard,
      string calldata _assay_transaction_id,
      address _consignment_owner,
      address _warehousePublicAddress
      ) external OnlyAssayer  returns(uint) {
        Certificate memory newCertificate = Certificate({
           certificate_id: Certificates.length,
           consignment_quantity: _consignment_quantity,
           consignment_standard: _consignment_standard,
           consignment_owner: _consignment_owner,
           assay_transaction_id: _assay_transaction_id,
           warehousePublicAddress: _warehousePublicAddress,
           consignment_name: _consignment_name,
           isAssayed: false,
           isInsured: false,
           isCustomsCleared: false,
           ShippingCleared: false
        });
        super._mint(_consignment_owner, Certificates.length);
        super._setTokenUri(Certificates.length, "");
        newCertificate.isAssayed = true;
        Certificates.push(newCertificate);
        CertificatesAssayedList.push(Certificates.length);
        return(Certificates.length - 1);
  }
 
  function toInsure(uint _tokenId) external OnlyInsurer  returns(uint) {
      Certificates[_tokenId].isInsured = true;
      CertificatesInsuredList.push(_tokenId);
      return(_tokenId);
  }
 
  function toCustoms(uint _tokenId) external OnlyCustoms  returns(uint) {
      Certificates[_tokenId].isCustomsCleared = true;
      CertificatesCutsomsClearedList.push(_tokenId);
      return(_tokenId);
  }
 
  function toShipping(uint _tokenId) external OnlyShipper returns(uint) {
      Certificates[_tokenId].ShippingCleared = true;
      CertificatesShippedList.push(_tokenId);
      return(_tokenId);
  }
 
 
  modifier OnlyAssayer {
    require(isAssayingAuthority[msg.sender] == true);
    _;
  }
 
  modifier OnlyInsurer {
    require(isInsuringAuthority[msg.sender] == true);
    _;
  }
   
  modifier OnlyCustoms {
    require(isCustomsAuthority[msg.sender] == true);
    _;
  }
 
  modifier OnlyShipper {
      require(isShippingAuthority[msg.sender] == true);
      _;
  }
}
