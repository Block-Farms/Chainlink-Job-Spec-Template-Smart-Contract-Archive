// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract RequestAddress is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  address public addressVariable;

  uint256 constant private ORACLE_PAYMENT = 0 * LINK_DIVISIBILITY / 100 * 5;

  constructor(
  ) {
    setChainlinkToken(LINK_TOKEN_ADDRESS);
    setChainlinkOracle(OPERATOR_ADDRESS);
  }

  function RequestAddress(
  )
    public
  {
    bytes32 externalJobId = "job_id";
    Chainlink.Request memory req = buildChainlinkRequest(externalJobId, address(this), this.fulfillAddress.selector);
    req.add("input", "inputVariable");
    req.add("path1", "data,results");
    sendOperatorRequest(req, ORACLE_PAYMENT);
  }

  event RequestFulfilled(
    bytes32 indexed requestId,
    address indexed addressVariable
  );

  function fulfillAddress(
    bytes32 requestId,
    address calldata _addressVariable
  )
    public
    recordChainlinkFulfillment(requestId)
  {
    emit RequestFulfilled(requestId, _addressVariable);
    addressVariable = _addressVariable;
  }

}
