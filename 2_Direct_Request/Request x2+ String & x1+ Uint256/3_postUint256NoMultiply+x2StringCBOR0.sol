// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract postMultiDataTypeTemplate is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  string public stringVariable1;
  string public stringVariable2;
  uint256 public number;

  bytes32 private externalJobId;
  uint256 private oraclePayment;

  constructor(
  ) {
    setChainlinkToken(LINK_TOKEN_ADDRESS);
    setChainlinkOracle(OPERATOR_ADDRESS);
    externalJobId = "externalJobId";
    oraclePayment = (0.0 * LINK_DIVISIBILITY); // n * 10**18
  }

  function requestMultiVariable(
  )
    public
  {
    Chainlink.Request memory req = buildChainlinkRequest(externalJobId, address(this), this.fulfillStringsAndUint256.selector);
    req.add("path1", "data,stringVariable1");
    req.add("path2", "data,stringVariable2");
    req.add("path3", "data,number");
    sendOperatorRequest(req, oraclePayment);
  }

  event RequestFulfilled(bytes32 indexed requestId, string indexed stringVariable1, string indexed stringVariable2, uint256 number);

  function fulfillStringsAndUint256(bytes32 requestId, string calldata _stringVariable1, string calldata _stringVariable2, uint256 _number)
    public
    recordChainlinkFulfillment(requestId)
  {
    emit RequestFulfilled(requestId, _stringVariable1, _stringVariable2, _number);
    stringVariable1 = _stringVariable1;
    stringVariable2 = _stringVariable2;
    number = _number;
  }

}
