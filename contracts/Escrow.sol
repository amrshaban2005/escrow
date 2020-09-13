pragma solidity >=0.4.16 <0.8.0;

contract Escrow{
    
    address public lawyer;
    address public payer;
    address payable public payee;
    uint public amount;
    
    constructor (address _payer,address payable _payee, uint _amount) public{
        lawyer=msg.sender;
        payer=_payer;
        payee=_payee;
        amount=_amount;
    }
    
    function deposit()payable public {
        require(msg.sender==payer,"only payer");
        require(address(this).balance <= amount,"can't send more than escrow amount");
    }
    
    function release ()public{
        require(msg.sender==payee,"only lawyer can release funds");
        require(address(this).balance == amount,"can't release funds before full amount is sent");
        payee.transfer(amount);
    }
    
    function balanceOf()view public returns (uint){
        return address(this).balance;
    }
    
}