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
      int assay_transaction_id;
      int LCApproval_transaction_id;
      int insurance_transaction_id;
      int customs_transaction_id;
      int shipping_transaction_id;
      int paymentApprovedTransaction_id;
      address consignment_owner;
      address warehousePublicAddress;
}

  mapping(uint => bool) isAssayed;
  mapping(uint => bool) isLCApproved;
  mapping(uint => bool) isInsured;
  mapping(uint => bool) isCustomsCleared;
  mapping(uint => bool) isShippingCleared;
  mapping(uint => bool) isPaymentApproved;
 
  uint[] CertificatesAssayedList;
  uint[] CertificatesLCApprovedList;
  uint[] CertificatesInsuredList;
  uint[] CertificatesCutsomsClearedList;
  uint[] CertificatesShippedList;
  uint[] CertificatesPaymentApprovedList;
 
  mapping(address => bool) isAssayingAuthority;
  mapping(address => bool) isInsuringAuthority;
  mapping(address => bool) isBank;
  mapping(address => bool) isCustomsAuthority;
  mapping(address => bool) isShippingAuthority;
  mapping(address => bool) isWarehouse;
 
  address[] AssayerList;
  address[] BankList;
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
  
  function addBank(address _newBank) public onlyOwner returns (bool) {
    BankList.push(_newBank);
    isBank[_newBank] = true;
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
      int _assay_transaction_id,
      address _consignment_owner,
      address _warehousePublicAddress
      ) external OnlyAssayer  returns(uint) {
        Certificate memory newCertificate = Certificate({
           certificate_id: Certificates.length,
           consignment_quantity: _consignment_quantity,
           consignment_standard: _consignment_standard,
           consignment_owner: _consignment_owner,
           assay_transaction_id: _assay_transaction_id,
           LCApproval_transaction_id: -1,
           insurance_transaction_id: -1,
           customs_transaction_id: -1,
           shipping_transaction_id: -1,
           paymentApprovedTransaction_id: -1,
           warehousePublicAddress: _warehousePublicAddress,
           consignment_name: _consignment_name
        });
        super._mint(_consignment_owner, Certificates.length);
        super._setTokenUri(Certificates.length, "");
        Certificates.push(newCertificate);
        isAssayed[Certificates.length - 1] = true;
        CertificatesAssayedList.push(Certificates.length - 1);
        return(Certificates.length - 1);
  }
 
  function toInsure(uint _tokenId, int _insurance_transaction_id) external OnlyInsurer  returns(uint) {
      isInsured[_tokenId] = true;
      Certificates[_tokenId].insurance_transaction_id = _insurance_transaction_id;
      CertificatesInsuredList.push(_tokenId);
      return(_tokenId);
  }
  
  function LCApprove(uint _tokenId, int _lc_approve_transaction_id) external OnlyBank  returns(uint) {
      isLCApproved[_tokenId] = true;
      Certificates[_tokenId].LCApproval_transaction_id = _lc_approve_transaction_id;
      CertificatesLCApprovedList.push(_tokenId);
      return(_tokenId);
  }
 
  function toCustoms(uint _tokenId, int _customs_transaction_id) external OnlyCustoms  returns(uint) {
      isCustomsCleared[_tokenId] = true;
      Certificates[_tokenId].customs_transaction_id = _customs_transaction_id;
      CertificatesCutsomsClearedList.push(_tokenId);
      return(_tokenId);
  }
 
  function toShipping(uint _tokenId, int _shipping_transaction_id) external OnlyShipper returns(uint) {
      isShippingCleared[_tokenId] = true;
      Certificates[_tokenId].shipping_transaction_id = _shipping_transaction_id;
      CertificatesShippedList.push(_tokenId);
      return(_tokenId);
  }
  
  function PaymentApprove(uint _tokenId, int _payment_approve_transaction_id) external OnlyBank  returns(uint) {
      isPaymentApproved[_tokenId] = true;
      Certificates[_tokenId].paymentApprovedTransaction_id = _payment_approve_transaction_id;
      CertificatesPaymentApprovedList.push(_tokenId);
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
  
  modifier OnlyBank {
      require(isBank[msg.sender] == true);
      _;
  }
}
