// SPDX-License-Identifier: MIT
// block-farms.io
// Discord=https://discord.gg/PgxRVrDUm7

pragma solidity ^0.8.7;

import '@chainlink/contracts/src/v0.8/ChainlinkClient.sol';
import '@chainlink/contracts/src/v0.8/ConfirmedOwner.sol';

contract FetchFromArray is ChainlinkClient, ConfirmedOwner {
    using Chainlink for Chainlink.Request;

    bytes32 public bytesVariable;

    bytes32 private externalJobId;
    uint256 private oraclePayment;

    event RequestBytes(bytes32 indexed requestId, bytes32 bytesVariable);

    constructor() ConfirmedOwner(msg.sender) {
        setChainlinkToken(LINK_TOKEN_ADDRESS);
        setChainlinkOracle(ORACLE_ADDRESS);
        externalJobId = "externalJobId";
        oraclePayment = (0.0 * LINK_DIVISIBILITY); // n * 10**18
    }

    function requestBytes() public returns (bytes32 requestId) {
        Chainlink.Request memory req = buildChainlinkRequest(externalJobId, address(this), this.fulfill.selector);
        req.add("input", "inputVariable");
        req.add("path", "data,results");
        return sendChainlinkRequest(req, oraclePayment);
    }

    function fulfill(bytes32 _requestId, bytes32 memory _bytesVariable) public recordChainlinkFulfillment(_requestId) {
        emit RequestBytes(_requestId, _bytesVariable);
        bytesVariable = _bytesVariable;
    }

}
