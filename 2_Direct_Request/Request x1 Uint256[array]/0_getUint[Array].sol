// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract RequestUint256Array is ChainlinkClient, ConfirmedOwner {
  using Chainlink for Chainlink.Request;

  uint256 constant private ORACLE_PAYMENT = 0 * LINK_DIVISIBILITY / 100 * 5;
  uint256[] public array;

  constructor() ConfirmedOwner(msg.sender){
    setChainlinkToken(LINK_TOKEN_ADDRESS);
    setChainlinkOracle(OPERATOR_ADDRESS);
  }

  function requestArray()
    public
    onlyOwner
  {
    bytes32 _jobId = "JOB_ID";
    Chainlink.Request memory req = buildChainlinkRequest(_jobId, address(this), this.fulfillArray.selector);
    req.add("get", "API_ENDPOINT_URL");
    req.add("path", "data,results");
    sendOperatorRequest(req, ORACLE_PAYMENT);
  }

  event RequestFulfilledArray(
    bytes32 indexed requestId,
    uint256[] _array
  );

  function fulfillArray(
    bytes32 requestId,
    uint256[] memory _array
  )
    public
    recordChainlinkFulfillment(requestId)
  {
    emit RequestFulfilledArray(requestId, _array);
    array = _array;
  }
}
