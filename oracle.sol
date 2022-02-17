pragma solidity 0.8.12; // SPDX-License-Identifier: MIT

//An Oracle is a database management system used not for only storing data but effectively
//managing that data.
//It provides high performance, authorized access and failure recovery features.

contract Oracle {
    address admin;
    uint256 public rand;

    constructor() {
        admin = msg.sender;
    }

    function setRand(uint256 _rand) external {
        rand = _rand;
        require(msg.sender == admin);
    }
}

//Build is a random number generator which produces a random number
//within a spcified range using cryptographic hashing

contract GenerateRandomNumber {
    Oracle oracle;

    constructor(address oracleAddress) {
        oracle = Oracle(oracleAddress);
    }

    function randRange(uint256 range) external view returns (uint256) {
        // we need to grab some dynamically changing information or data from the blockchain so we
        // use one of the hash functions CHFs . here we use keccak256 from abi.encodepacked which
        // basically helps concatenate arguments nicely.

        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        oracle.rand,
                        block.timestamp,
                        block.difficulty,
                        msg.sender
                    )
                )
            ) % range;
    }
}
