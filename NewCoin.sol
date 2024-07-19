// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract NewCoin {
    mapping(address => uint) balances;
    string public ticker = "NCO";
    uint limit = 1000000;
    bool burnable = true;
    uint totalTokens = 0;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function mint(uint _amount) public {
        require(owner == msg.sender);
        require(limit <= totalTokens + _amount);
        balances[msg.sender] += _amount;
    }

    function send(address _sender, address _receiver, uint _amount) public {
        require(balances[_sender] >= _amount);
        balances[_sender] -= _amount;
        balances[_receiver] += _amount;
    }

    function burn(address _owner, uint _amount) public {
        require(balances[_owner] >= _amount);
        require(_owner == msg.sender);
        balances[_owner] -= _amount;
        totalTokens -= _amount;
    }
}
