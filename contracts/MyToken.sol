// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyToken {

    string private constant tokenName = "Enerva";
    string private constant tokenSymbol = "ENV";
    uint8 private constant countDecimals = 18;
    uint256 private totalSupplyBalance;

    mapping( address => uint256 ) balances;
    mapping(address => mapping(address => uint256)) allowed;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    modifier canTransfer( address _from, uint256 _value ) {
        require( balances[_from] >= _value, "Has no funds");
        _;
    }

    constructor ( uint256 total ) {
        totalSupplyBalance = total;
        balances[msg.sender] = total;
    }
    
    function name() public pure returns(string memory) {
        return tokenName;
    }

    function symbol() public pure returns(string memory) {
        return tokenSymbol;
    }

    function decimals() public pure returns(uint8) {
        return countDecimals;
    }

    function totalSupply() public view returns(uint256) {
        return totalSupplyBalance;
    }

    function balanceOf( address _owner ) public view returns(uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) 
        public 
        canTransfer( msg.sender, _value ) 
        returns (bool success) 
    {
        balances[_to] = balances[_to] + _value;
        balances[msg.sender] = balances[msg.sender] - _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        success = true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require( _value <= balances[_from], "There are not enough funds to do the transfer" );
        require( _value <= allowed[_from][msg.sender], "Sender not allowed" );

        balances[_from] = balances[_from] - _value;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(_from, _to, _value);
        success = true;
    }

}