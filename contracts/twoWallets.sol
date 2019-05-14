pragma solidity >=0.4.21 <0.6.0;

contract TwoWallets {
  mapping(address => uint) balances;

  //log events
  event Send(address ethFrom, address ethTo, uint ethAmnt);

  constructor () public{

  }

  //Sends ethereum to an address
  function sendETH(address payable toAddr, uint amount) public returns(bool isSuccess){
    bool success = false;
    amount = ethToWei(amount);
    if(balances[msg.sender] >= amount){
      balances[msg.sender] -= amount;
      balances[toAddr] += amount;
      success = toAddr.send(amount);
      emit Send(msg.sender, toAddr, amount);
    }
    else{
      emit Send(msg.sender, toAddr, 0);
    }

    return success;
  }

  //returns the ethereum balance of the sender's address
  function getBalance() public view returns (string memory blanceString){
    return uint2str(balances[msg.sender]);
  }

  //uint to string function copied from oraclize api
  function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
    if (_i == 0) {
        return "0";
    }
    uint j = _i;
    uint len;
    while (j != 0) {
      len++;
      j /= 10;
    }
    bytes memory bstr = new bytes(len);
    uint k = len - 1;
    while (_i != 0) {
      bstr[k--] = byte(uint8(48 + _i % 10));
      _i /= 10;
    }
    return string(bstr);
  }

  function ethToWei(uint ETH) internal pure returns(uint totalWei){
    return ETH * (10**17);
  }

}
