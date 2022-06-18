// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract MultiVariableRequest is ChainlinkClient, ConfirmedOwner {
  using Chainlink for Chainlink.Request;

  bytes32 private externalJobId;
  uint256 private oraclePayment;

  uint256 public Value2;
  uint256 public Value1;

  constructor() ConfirmedOwner(msg.sender){
    setChainlinkToken(LINK_TOKEN_ADDRESS);
    setChainlinkOracle(OPERATOR_ADDRESS);
    externalJobId = "externalJobId";
    oraclePayment = (0.0 * LINK_DIVISIBILITY); // n * 10**18
  }

  function requestValue1AndValue2()
    public
    onlyOwner
  {
    Chainlink.Request memory req = buildChainlinkRequest(externalJobId, address(this), this.fulfillValue1AndValue2.selector);
    req.add("input1", "inputVariable1");
    req.add("input2", "inputVariable2");
    req.add("input3", "inputVariable3");
    req.add("path1", "data,results1");
    req.add("path2", "data,results2");
    sendOperatorRequest(req, oraclePayment);
  }

  event RequestFulfilledValue1AndValue2(
    bytes32 indexed requestId,
    uint256 indexed Value2,
    uint256 indexed Value1
  );

  function fulfillValue1AndValue2(
    bytes32 requestId,
    uint256 _Value2,
    uint256 _Value1
  )
    public
    recordChainlinkFulfillment(requestId)
  {
    emit RequestFulfilledValue1AndValue2(requestId, _Value2, _Value1);
    Value1 = _Value1;
    Value2 = _Value2;
  }

}
