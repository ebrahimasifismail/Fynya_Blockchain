pragma solidity >=0.4.21 <0.6.0;

contract Fynya_Token {
    string  public name = "Fynya Gold June 2020 Token";
    string  public symbol = "FYNJunGold2020";
    string  public standard = "Fynya Gold June 2020 Token v0.1";
    string  public strStartDate = "23-06-2020 12:00:00";
    string  public strEndDate = "23-09-2020 12:00:00";
    string  public TradingPeriod = "Monday to Friday";
    string  public TradingUnit = "1 FYNJunGold2020 = 1 kg";
    uint256 public totalSupply;
    uint256 public startDate = 1592913600;
    uint256 public endDate = 1600862400;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );
    
    event TransferFromApp(
        address indexed _from,
        address indexed _to,
        uint256 _value,
        uint256 _token
    );
    
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor (uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }
    
    function test() public view notExpired returns (uint) {
      return now;
    }

    function transfer(address _to, uint256 _value) public notExpired returns (bool success) {
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }
    
    function _transfer(address _to, uint256 _value, uint _token) public notExpired returns (bool success) {
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit TransferFromApp(msg.sender, _to, _value, _token);

        return true;
    }
    

    function approve(address _spender, uint256 _value) public notExpired returns (bool success) {
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public notExpired returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }
    
    modifier notExpired {
        require(now < endDate);
        _;
    }
}
