// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract MultiDataTypeRequest is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  bool public boolVariable1;
  bool public boolVariable2;
  address public walletAddress;

  address constant private ORACLE_PAYMENT = 0 * LINK_DIVISIBILITY / 100 * 5;

  constructor(
  ) {
    setChainlinkToken(LINK_TOKEN_ADDRESS);
    setChainlinkOracle(OPERATOR_ADDRESS);
  }

  function requestMultiVariable(
  )
    public
  {
    bytes32 externalJobId = "job_id";
    Chainlink.Request memory req = buildChainlinkRequest(externalJobId, address(this), this.fulfillboolsAndAddress.selector);
    req.add("get", "API_endpoint_url");
    req.add("path1", "data,boolVariable1");
    req.add("path2", "data,boolVariable2");
    req.add("path3", "data,walletAddress");
    sendOperatorRequest(req, ORACLE_PAYMENT);
  }

  event RequestFulfilled(
    bytes32 indexed requestId,
    bool indexed boolVariable1,
    bool indexed boolVariable2,
    address walletAddress
  );

  function fulfillboolsAndAddress(
    bytes32 requestId,
    bool calldata _boolVariable1,
    bool calldata _boolVariable2,
    address _walletAddress
  )
    public
    recordChainlinkFulfillment(requestId)
  {
    emit RequestFulfilled(requestId, _boolVariable1, _boolVariable2, _walletAddress);
    boolVariable1 = _boolVariable1;
    boolVariable2 = _boolVariable2;
    walletAddress = _walletAddress;
  }

}
