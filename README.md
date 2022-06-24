# Chainlink Job Spec Template Smart Contract Archive

### What is a Job?

Chainlink nodes require jobs to do anything useful. For example, posting asset price data on-chain requires jobs. Chainlink nodes support the following job types:

(1) [Webhook](https://docs.chain.link/docs/jobs/types/webhook/)

(2) [Direct Request](https://docs.chain.link/docs/jobs/types/direct-request/)

(3) [Flux Monitor](https://docs.chain.link/docs/jobs/types/flux-monitor/)

(4) [Off-chain Reporting (OCR)](https://docs.chain.link/docs/jobs/types/offchain-reporting/)

(5) [Cron](https://docs.chain.link/docs/jobs/types/cron/)

(6) [Keeper](https://docs.chain.link/docs/jobs/types/keeper/)

Job specs are represented by TOML `.toml` files.

Requesting smart contracts are represented by solidity `.sol` files.

### References: 

  [0] https://docs.chain.link/docs/jobs/

  [1] https://github.com/smartcontractkit/chainlink/tree/develop/core/testdata/tomlspecs
