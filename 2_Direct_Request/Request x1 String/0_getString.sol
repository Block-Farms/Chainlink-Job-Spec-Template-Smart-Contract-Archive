// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract RequestString is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  string public stringVariable;

  uint256 constant private ORACLE_PAYMENT = 0 * LINK_DIVISIBILITY / 100 * 5;

  constructor(
  ) {
    setChainlinkToken(LINK_TOKEN_ADDRESS);
    setChainlinkOracle(OPERATOR_ADDRESS);
  }

  function requestString(
  )
    public
  {
    bytes32 externalJobId = "job_id";
    Chainlink.Request memory req = buildChainlinkRequest(externalJobId, address(this), this.fulfillString.selector);
    req.add("get", "API_endpoint_url");
    req.add("path1", "data,results");
    sendOperatorRequest(req, ORACLE_PAYMENT);
  }

  event RequestFulfilled(
    bytes32 indexed requestId,
    string indexed stringVariable
  );

  function fulfillString(
    bytes32 requestId,
    string calldata _stringVariable
  )
    public
    recordChainlinkFulfillment(requestId)
  {
    emit RequestFulfilled(requestId, _stringVariable);
    stringVariable = _stringVariable;
  }

}
