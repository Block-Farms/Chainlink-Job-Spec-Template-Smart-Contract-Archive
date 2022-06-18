// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract getBoolTemplate is ChainlinkClient, ConfirmedOwner {
  using Chainlink for Chainlink.Request;

  bool public boolean;
  
  bytes32 private externalJobId;
  uint256 private oraclePayment;

  event RequestBoolFulfilled(
    bytes32 indexed requestId,
    uint256 indexed boolean
  );

  constructor() ConfirmedOwner(msg.sender){
  setChainlinkToken(LINK_TOKEN_ADDRESS);
  setChainlinkOracle(OPERATOR_ADDRESS);
  externalJobId = "externalJobId";
  oraclePayment = (0.0 * LINK_DIVISIBILITY); // n * 10**18
  }

  function requestBool()
    public
    onlyOwner
  {
    Chainlink.Request memory req = buildChainlinkRequest(_jobId, address(this), this.fulfillBool.selector);
    req.add("get", "https://YOUR_API_ENDPOINT_URL");
    req.add("path", "data,results");
    sendChainlinkRequestTo(req, oraclePayment);
  }

  function fulfillBool(bytes32 _requestId, bool _boolean)
    public
    recordChainlinkFulfillment(_requestId)
  {
    emit RequestUintFulfilled(_requestId, _boolean);
    boolean = _boolean;
  }

}
