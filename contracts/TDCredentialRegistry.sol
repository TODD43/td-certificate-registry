// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title TD Credential Registry
/// @notice Demo registry for issuing and verifying hashed credentials.
/// @dev Educational/testnet demo. Do not store sensitive documents on-chain.
contract TDCredentialRegistry {
    address public admin;
    mapping(address => bool) public issuers;

    struct Credential {
        bytes32 documentHash;
        address issuer;
        uint64 issuedAt;
        bool revoked;
    }

    mapping(bytes32 => Credential) public credentials;

    event IssuerUpdated(address indexed issuer, bool enabled);
    event CredentialIssued(bytes32 indexed credentialId, address indexed issuer, bytes32 documentHash);
    event CredentialRevoked(bytes32 indexed credentialId, address indexed issuer);

    modifier onlyAdmin(){ require(msg.sender == admin, "not admin"); _; }
    modifier onlyIssuer(){ require(issuers[msg.sender], "not issuer"); _; }

    constructor(){ admin = msg.sender; issuers[msg.sender] = true; }

    function setIssuer(address issuer, bool enabled) external onlyAdmin {
        require(issuer != address(0), "zero");
        issuers[issuer] = enabled;
        emit IssuerUpdated(issuer, enabled);
    }

    function issue(bytes32 credentialId, bytes32 documentHash) external onlyIssuer {
        require(credentialId != bytes32(0) && documentHash != bytes32(0), "missing data");
        require(credentials[credentialId].issuedAt == 0, "already exists");
        credentials[credentialId] = Credential(documentHash, msg.sender, uint64(block.timestamp), false);
        emit CredentialIssued(credentialId, msg.sender, documentHash);
    }

    function revoke(bytes32 credentialId) external onlyIssuer {
        Credential storage c = credentials[credentialId];
        require(c.issuedAt != 0, "not found");
        require(c.issuer == msg.sender, "not issuer");
        c.revoked = true;
        emit CredentialRevoked(credentialId, msg.sender);
    }

    function verify(bytes32 credentialId, bytes32 documentHash) external view returns(bool valid, address issuer, uint64 issuedAt) {
        Credential memory c = credentials[credentialId];
        valid = c.issuedAt != 0 && !c.revoked && c.documentHash == documentHash;
        issuer = c.issuer;
        issuedAt = c.issuedAt;
    }
}
