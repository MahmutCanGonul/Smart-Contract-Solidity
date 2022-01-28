contract SendEther{

  event LogDepositMade(address indexed accountAddress, uint amount);
      fallback() external payable {}

      constructor(address payable _owner) public payable
    {
         require(address(this).balance >= msg.value,"Not Enough Ether!");
    }

  function sendViaCall(address payable _to,uint amount) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        amount = amount * (1 ether);
        require(address(this).balance >= amount && amount!=0,"Not enough Ether!"); 
        bool sent = _to.send(amount);
        require(sent, "Failed to send Ether");
    }

    function deposit() public payable returns (uint) {
        emit LogDepositMade(msg.sender, msg.value);
        return msg.sender.balance;
    }


}
