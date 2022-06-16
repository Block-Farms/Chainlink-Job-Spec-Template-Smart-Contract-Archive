// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract PriceOracle is ChainlinkClient, ConfirmedOwner {
  using Chainlink for Chainlink.Request;

  uint256 constant private ORACLE_PAYMENT = 0 * LINK_DIVISIBILITY;
  uint256 public currentPrice;
  address private _oracle = oracle_address;
  bytes32 private _jobId = "external_job_id";

  event RequestPriceFulfilled(
    bytes32 indexed requestId,
    uint256 indexed price
  );

  constructor() ConfirmedOwner(msg.sender){
    setChainlinkToken(LINK_TOKEN_ADDRESS);
  }

  function requestPrice()
    public
    onlyOwner
  {
    Chainlink.Request memory req = buildChainlinkRequest(_jobId, address(this), this.fulfillPrice.selector);
    sendChainlinkRequestTo(_oracle, req, ORACLE_PAYMENT);
  }

  function fulfillPrice(bytes32 _requestId, uint256 _price)
    public
    recordChainlinkFulfillment(_requestId)
  {
    emit RequestPriceFulfilled(_requestId, _price);
    currentPrice = _price;
  }

}
