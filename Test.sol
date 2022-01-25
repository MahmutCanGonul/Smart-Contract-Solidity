// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

//import "hardhat/console.sol";
contract RecieveEther
{
  
    uint8 private clientCount;
    mapping (address => uint) private balances;
    address payable public owner;

  // Log the event about a deposit being made by an address and its amount
    event LogDepositMade(address indexed accountAddress, uint amount);
    
    constructor(address payable _owner) public payable
    {
         require(address(this).balance >= msg.value,"Not Enough Ether!");
         owner = _owner;
         clientCount=0;
    }
    
    function enroll(uint amount) public returns (uint) {
        if (clientCount < 3) {
            clientCount++;
            balances[msg.sender] = amount;
        }
        return balances[msg.sender];
    }
    

    function deposit() public payable returns (uint) {
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }
   
    
    function withdraw(uint withdrawAmount) public  returns (uint remainingBal) {
        // Check enough balance available, otherwise just return balance
        require(msg.sender == owner,"No Match Address!");
        if (withdrawAmount <= balances[msg.sender]) {
            balances[msg.sender] -= withdrawAmount;
            owner.transfer(withdrawAmount);
        }
        return balances[msg.sender];
    }

    function transfer(address  to_address, uint amount) public  returns (uint newBalance){
        require(owner.balance >=amount,"Not Enough Ether!");
        balances[to_address]  += amount;
        balances[msg.sender] -= amount;
        return balances[to_address]; 
    }

   function from_balance() public view returns (uint) {
        return balances[msg.sender];
    }
   
   function to_balance(address to_address) public view returns (uint) {
        return balances[to_address];
    }
  
   function depositsBalance() public view returns (uint) {
        return address(this).balance;
    }


}
