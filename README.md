# Chainlink-Job-Spec-Template-Smart-Contract-Database

What is a Job?
Chainlink nodes require jobs to do anything useful. For example, posting asset price data on-chain requires jobs. Chainlink nodes support the following job types:

(0) [Webhook](https://docs.chain.link/docs/jobs/types/webhook/)

(1) [Direct Request](https://docs.chain.link/docs/jobs/types/direct-request/)

(2) [Flux Monitor](https://docs.chain.link/docs/jobs/types/flux-monitor/)

(3) [Off-chain Reporting (a.k.a. OCR)](https://docs.chain.link/docs/jobs/types/offchain-reporting/)

(4) [Cron](https://docs.chain.link/docs/jobs/types/cron/)

(5) [Keeper](https://docs.chain.link/docs/jobs/types/keeper/)

Jobs are represented by TOML (.toml) specifications.

Reference: https://docs.chain.link/docs/jobs/
