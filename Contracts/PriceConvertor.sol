// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConvertor {
    function getPrice() internal view returns(uint256){
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    (,int price,,,) = priceFeed.latestRoundData();
    return uint(price) * 1e10;
   }

   function getConversionRate(uint256 ethAmount) internal view returns(uint256){
    uint256 ethPrice = getPrice();
    uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
    return ethAmountInUSD;
   }

}