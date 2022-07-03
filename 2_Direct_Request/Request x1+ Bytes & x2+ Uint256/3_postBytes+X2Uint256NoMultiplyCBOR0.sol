// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract postMultiDataTypeTemplate is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  bytes public data;
  string public convertedString;
  uint256 public number1;
  uint256 public number2;

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
    Chainlink.Request memory req = buildChainlinkRequest(externalJobId, address(this), this.fulfillBytesAndUint.selector);
    req.add("path1", "data,path1");
    req.add("path2", "data,path2");
    req.add("path3", "data,path3");
    sendOperatorRequest(req, oraclePayment);
  }

  event RequestFulfilled(bytes32 indexed requestId, bytes indexed data, uint256 number1, uint256 number2);

  function fulfillBytesAndUint(bytes32 requestId, bytes memory bytesData, uint256 _number1, uint256 _number2)
    public
    recordChainlinkFulfillment(requestId)
  {
    emit RequestFulfilled(requestId, bytesData, _number1, _number2);
    data = bytesData;
    convertedString = string(data);
    number1 = _number1;
    number2 = _number2;
  }

}
