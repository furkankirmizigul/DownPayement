//SPDX-License-Identifier: GPL-3.0
 
pragma solidity >=0.6.0 <0.9.0;
 
 
 contract Deposit{
     address public seller;             //declaring variables 
     address constant public buyer = 0x5684e5BC874d470175bDd8C445464004289a78c6; // We have to initialize buyer to prevent other access to buyerConformationonf
    // uint public sentValue;
     bool public confOfBuyer;
     uint earnedAmount;
     uint possibleOrderAmount;
     uint constant unitPrice = 2 ether ;                //Unit price determined at the beginning 0,2 ETH constant 
     
    constructor(){
        seller = msg.sender;            //Seller determined as the contract sender 
        
     }
     
     receive() external payable{        //Contract open to external payements from network
     }
     
     function getBalance() public view returns(uint){
         return address(this).balance/1000000000000000000;                      //Current contract balance as ETH
     }
    
    function downPayement() public payable{        // Payable to receive payement with the transaction
        
        possibleOrderAmount = address(this).balance/unitPrice;          //Possible order amount with current balance is created since the unit price is fixed
        
        }
    
    function totalOrderAmount () public view returns (uint) {                       //Returns Possible Order Amount 
         return possibleOrderAmount;
         
    }
    
    function orderAmount (uint OrderAmount) public {                                        //Buyer sets the order amount
        require(msg.sender == buyer,"You are not authorized to give order");                //Only the Buyer is authorized             
         earnedAmount = OrderAmount * unitPrice;
         possibleOrderAmount = possibleOrderAmount - OrderAmount;                           //When the order created it is deducted from possible order amount 
    }
    
    function totalEarnedAmount () public view returns (uint) {                       //Earned Amount is depending on the order Earned Amount is updated with order
         return earnedAmount/1000000000000000000;
         
    }
    
    function buyerConformation (bool newVal) public{                                            //Buyers Conformation is Required for Withdrawel 
        require(msg.sender == buyer, "Conformation failed you are not authorized");           //Checking if the account trying to conform is the buyer  
         confOfBuyer = newVal;                                  //If the buyer sets conformation as true, the seller will have permission to withdraw from contract account
        }
 
    
    // Transfering ETH from the contract to another address (seller)
     //Transfering All Earned amount from contract
     
     
    function transferEarnedETH(address payable recipient) public {
         require(seller == msg.sender, "Transfer failed, you are not authorized"); // Checking that only seller can withdraw from the contract to their address
         require(confOfBuyer == true);                                                //Checking if the buyer conformed the transaction
              recipient.transfer(earnedAmount);                     //Withdraw all balance 
              earnedAmount = 0;                                     //After the Withdrawel Erned Aount is 0 Ain 
              confOfBuyer = false;                                  //After the Withdrawel Byers Cnformation is Flse Again 
            }
       
 }
 