// Get fund from users
//withdraw funds
//set minimum funding in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {PriceConvertor} from "Contracts/PriceConvertor.sol";

contract FundMe {

   using PriceConvertor for uint256;
    uint public minimumUSD = 5e18;
    address[] public funders;

   address public owner;

   constructor(){
      owner = msg.sender;
   }

    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;


    function Fund() public payable {
       require(msg.value.getConversionRate()  >= minimumUSD, "didn't send enough eth");
       funders.push(msg.sender);
       addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function Withdraw() public  onlyOwner {
   
      for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++ ){
         address funder = funders[funderIndex] ;
         addressToAmountFunded[funder] = 0;

      }

      funders = new address[](0);
       
       (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
       require(callSuccess, "call failed");
         
       
    }

   //address : 0x694AA1769357215DE4FAC081bf1f309aDC325306
   modifier  onlyOwner(){
      require(msg.sender == owner, "sender is not owner");
      _;
   }
   
}