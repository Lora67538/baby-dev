// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVoting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }
    
    Candidate[] public candidates;
    
    mapping(address => bool) public hasVoted;
    
    event Voted(address indexed voter, uint256 candidateId);
    
    constructor() {
        candidates.push(Candidate("Alice", 0));
        candidates.push(Candidate("Bob", 0));
    }
    
    function vote(uint256 candidateId) external {
        require(candidateId < candidates.length, "Invalid candidate");
        require(!hasVoted[msg.sender], "Already voted");
        
        hasVoted[msg.sender] = true;
        candidates[candidateId].voteCount++;
        
        emit Voted(msg.sender, candidateId);
    }
    
    function getVotes(uint256 candidateId) external view returns (uint256) {
        require(candidateId < candidates.length, "Invalid candidate");
        return candidates[candidateId].voteCount;
    }
    
    function getCandidateCount() external view returns (uint256) {
        return candidates.length;
    }
    
    function getResults() external view returns (uint256, uint256) {
        return (candidates[0].voteCount, candidates[1].voteCount);
    }
}