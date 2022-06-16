// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract MultiDataTypeRequest is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  bytes public data;
  string public convertedBytes;
  uint256 public amount;

  uint256 constant private ORACLE_PAYMENT = 0 * LINK_DIVISIBILITY / 100 * 5;

  constructor(
  ) {
    setChainlinkToken(LINK_TOKEN_ADDRESS);
    setChainlinkOracle(OPERATOR_ADDRESS);
  }


  function requestAddressAndAmount(
  )
    public
  {
    bytes32 externalJobId = "job_id";
    Chainlink.Request memory req = buildChainlinkRequest(externalJobId, address(this), this.fulfillBytes.selector);
    req.add("get", "API_endpoint_url");
    req.add("path1", "data,results1");
    req.add("path2", "data,results2");
    sendOperatorRequest(req, ORACLE_PAYMENT);
  }

  event RequestFulfilled(
    bytes32 indexed requestId,
    bytes indexed data,
    uint256 amount
  );


  function fulfillBytes(
    bytes32 requestId,
    bytes memory bytesData,
    uint256 _amount
  )
    public
    recordChainlinkFulfillment(requestId)
  {
    emit RequestFulfilled(requestId, bytesData, _amount);
    data = bytesData;
    convertedBytes = string(data);
    amount = _amount;
  }

}
