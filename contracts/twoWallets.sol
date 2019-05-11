pragma solidity >=0.4.21 <0.6.0;

contract TwoWallets {
  mapping(address => uint) balances;

  event Send(address ethFrom, address ethTo, uint ethAmnt);

  constructor () public{

  }

  function sendETH(address toAddr, uint amount) public returns(bool isSuccess){
    bool success = false;
    if(balances[msg.sender] >= amount){
      balances[msg.sender] -= amount;
      balances[toAddr] += amount;

      emit Send(msg.sender, toAddr, amount);
      success = true;
    }
    else{
      emit Send(msg.sender, toAddr, 0);
    }

    return success;
  }

  function getBalance() public view returns (uint){
    return balances[msg.sender];
  }


}
