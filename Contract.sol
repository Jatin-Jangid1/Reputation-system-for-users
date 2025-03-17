// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract ReputationSystem {
    struct User {
        uint256 reputationScore;
        bool exists;
    }

    mapping(address => User) public users;
    address public owner;

    event ReputationUpdated(address indexed user, uint256 newScore);
    event UserRegistered(address indexed user);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier userExists(address _user) {
        require(users[_user].exists, "User does not exist");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerUser(address _user) external onlyOwner {
        require(!users[_user].exists, "User already registered");
        users[_user] = User(0, true);
        emit UserRegistered(_user);
    }

    function updateReputation(address _user, uint256 _score) external onlyOwner userExists(_user) {
        users[_user].reputationScore = _score;
        emit ReputationUpdated(_user, _score);
    }

    function getReputation(address _user) external view userExists(_user) returns (uint256) {
        return users[_user].reputationScore;
    }
}
