# Smart-Contract-Solidity
Simple Bank Transaction With Solidity 

This code is example of transafer Ether to another address

![image](https://user-images.githubusercontent.com/75094927/151043493-3721ae3c-0fb5-469d-a8ee-a521e39e7f5a.png)


Objects:


      uint8 private clientCount; 
      mapping (address => uint) private balances; // Return the balance from the address
      address payable public owner; // Owner Address
      
      
      
1- Log the event about a deposit being made by an address and its amount
  
     event LogDepositMade(address indexed accountAddress, uint amount);

2-Creating constructor
      
      
      constructor(address payable _owner) public payable
    {
         require(address(this).balance >= msg.value,"Not Enough Ether!");
         owner = _owner;
         clientCount=0;
    }
    
3-return The balance of the user after enrolling

     function enroll(uint amount) public returns (uint) {
        if (clientCount < 3) {
            clientCount++;
            balances[msg.sender] = amount;
        }
        return balances[msg.sender];
       }
       
4- Deposit ether into bank, requires method is "payable" and return The balance of the user after the deposit is made

    function deposit() public payable returns (uint) {
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }
   
5- The balance remaining for the user and withdraw ether from bank

    function withdraw(uint withdrawAmount) public  returns (uint remainingBal) {
        // Check enough balance available, otherwise just return balance
        require(msg.sender == owner,"No Match Address!");
        if (withdrawAmount <= balances[msg.sender]) {
            balances[msg.sender] -= withdrawAmount;
            owner.transfer(withdrawAmount);
        }
        return balances[msg.sender];
     }

6- Transfer to another account address

    function transfer(address  to_address, uint amount) public  returns (uint newBalance){
        require(owner.balance >=amount,"Not Enough Ether!");
        balances[to_address]  += amount;
        balances[msg.sender] -= amount;
        return balances[to_address]; 
      }

7- Return the balances of accounts

    function from_balance() public view returns (uint) {
        return balances[msg.sender];
    }
   
     function to_balance(address to_address) public view returns (uint) {
        return balances[to_address];
    }
  
     function depositsBalance() public view returns (uint) {
        return address(this).balance;
    }
