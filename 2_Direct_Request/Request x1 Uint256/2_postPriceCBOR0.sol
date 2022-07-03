// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract PriceOracle is ChainlinkClient, ConfirmedOwner {
  using Chainlink for Chainlink.Request;

  uint256 public currentPrice;

  bytes32 private externalJobId;
  uint256 private oraclePayment;
  address private oracle;

  event RequestPriceFulfilled(bytes32 indexed requestId, uint256 indexed price);

  constructor() ConfirmedOwner(msg.sender){
    setChainlinkToken(LINK_TOKEN_ADDRESS);
    oracle = ORACLE_ADDRESS;
    externalJobId = "externalJobId";
    oraclePayment = (0.0 * LINK_DIVISIBILITY); // n * 10**18
  }

  function requestPrice()
    public
    onlyOwner
  {
    Chainlink.Request memory req = buildChainlinkRequest(externalJobId, address(this), this.fulfillPrice.selector);
    sendChainlinkRequestTo(oracle, req, oraclePayment);
  }

  function fulfillPrice(bytes32 _requestId, uint256 _price)
    public
    recordChainlinkFulfillment(_requestId)
  {
    emit RequestPriceFulfilled(_requestId, _price);
    currentPrice = _price;
  }

}
