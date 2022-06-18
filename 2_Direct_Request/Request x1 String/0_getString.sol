// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract RequestString is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  string public stringVariable;

  bytes32 private externalJobId;
  uint256 private oraclePayment;

  constructor(
  ) {
    setChainlinkToken(LINK_TOKEN_ADDRESS);
    setChainlinkOracle(OPERATOR_ADDRESS);
    externalJobId = "externalJobId";
    oraclePayment = (0.0 * LINK_DIVISIBILITY); // n * 10**18
  }

  function requestString(
  )
    public
  {
    Chainlink.Request memory req = buildChainlinkRequest(externalJobId, address(this), this.fulfillString.selector);
    req.add("get", "https://API_endpoint_url");
    req.add("path1", "data,results");
    sendOperatorRequest(req, oraclePayment);
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
