# TD Credential Registry

Blockchain-backed credential verification for certificates, training records, licenses and other documents.

## Overview

The registry stores a cryptographic `documentHash` rather than the source document itself. A verifier can compare a supplied hash with the on-chain record and confirm whether a credential is valid and not revoked.

## Features

- Issuer authorization
- Credential issuance
- Document-hash verification
- Credential revocation
- Public verification function
- Wallet-compatible frontend

## Technology

- Solidity 0.8.24
- EVM-compatible chains
- ethers.js 6
- MetaMask or another EVM wallet

## Repository structure

```text
contracts/
└── TDCredentialRegistry.sol

frontend/
└── index.html
```

## Deploy

1. Open https://remix.ethereum.org/
2. Compile `contracts/TDCredentialRegistry.sol` with Solidity `0.8.24`.
3. Deploy to an EVM testnet.
4. Use the admin account to authorize an issuer with `setIssuer(address,true)`.
5. An authorized issuer can call `issue(credentialId,documentHash)`.
6. A verifier can use `verify(credentialId,documentHash)` or the frontend.

## Privacy

Do not put personally identifiable information, certificates, transcripts or other sensitive source documents directly on a public blockchain. Hash only data appropriate for public verification and keep underlying documents in a suitable off-chain system.

## Production extensions

Potential client extensions include issuer dashboards, QR verification links, batch issuance, revocation reasons, organization branding, APIs, audit logs and enterprise identity integration.

## Security

This is a portfolio/testnet demonstration and has not been independently audited. Production deployment requires security review, testing and appropriate privacy, legal and compliance controls.

## Author

**Todd Adrian**  
GitHub: https://github.com/TODD43

## License

MIT — Copyright (c) 2026 Todd Adrian
