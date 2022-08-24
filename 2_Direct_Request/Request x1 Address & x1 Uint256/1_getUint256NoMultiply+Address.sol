// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract getMultiDataTypeTemplate is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  address public addressVariable;
  uint256 public amount;

  bytes32 private externalJobId;
  uint256 private oraclePayment;

  constructor(
  ) {
    setChainlinkToken(LINK_TOKEN_ADDRESS);
    setChainlinkOracle(OPERATOR_ADDRESS);
    externalJobId = "externalJobId";
    oraclePayment = (0 * LINK_DIVISIBILITY) / 10; // n * 10**18
  }

  function requestAddressAndAmount(
  )
    public
  {
    Chainlink.Request memory req = buildChainlinkRequest(externalJobId, address(this), this.fulfillBytes.selector);
    req.add("get", "https://API_endpoint_url");
    req.add("path1", "data,results1"); // address
    req.add("path2", "data,results2"); // uint256
    sendOperatorRequest(req, oraclePayment);
  }

  event RequestFulfilled(bytes32 indexed requestId,address indexed addressVariable,uint256 amount);

  function fulfillBytes(bytes32 requestId, address _addressVariable, uint256 _amount)
    public
    recordChainlinkFulfillment(requestId)
  {
    emit RequestFulfilled(requestId, _addressVariable, _amount);
    addressVariable = _addressVariable;
    amount = _amount;
  }

}
