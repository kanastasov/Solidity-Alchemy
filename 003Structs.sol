// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }

	struct Vote {
		Choices choice;
		address voter;
	}
	Vote public vote;
	// TODO: create a vote struct and a public state variable

	function createVote(Choices choice) external {
		vote = Vote(choice, msg.sender);
	}
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address votingAddr = address(2);

    function setUp() public {
        vm.startPrank(votingAddr);
        myContract = new Contract();
    }

    function testVoteYes() public {
        myContract.createVote(Contract.Choices.Yes);
        (Contract.Choices choice, address voter) = myContract.vote();
        assertEq(uint(choice), uint(Contract.Choices.Yes), "it should set the vote to Yes");
        assertEq(voter, votingAddr, "it should set the voter to the msg.sender");
    }

    function testVoteNo() public {
        myContract.createVote(Contract.Choices.No);
        (Contract.Choices choice, address voter) = myContract.vote();
        assertEq(uint(choice), uint(Contract.Choices.No), "it should set the vote to No");
        assertEq(voter, votingAddr, "it should set the voter to the msg.sender");
    }
}


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }

	struct Vote {
		Choices choice;
		address voter;
	}
	
	function createVote(Choices choice) external view returns(Vote memory) {
		Vote memory vote = Vote(choice, msg.sender);
		return vote;
	}
	// TODO: make a new createVote function
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address votingAddr = address(2);

    function setUp() public {
        vm.startPrank(votingAddr);
        myContract = new Contract();
    }

    function testVoteYes() public {
        Contract.Vote memory vote = myContract.createVote(Contract.Choices.Yes);
        assertEq(uint(vote.choice), uint(Contract.Choices.Yes), "it should set the vote to Yes");
        assertEq(vote.voter, votingAddr, "it should set the voter to the msg.sender");
    }

    function testVoteNo() public {
        Contract.Vote memory vote = myContract.createVote(Contract.Choices.No);
        assertEq(uint(vote.choice), uint(Contract.Choices.No), "it should set the vote to No");
        assertEq(vote.voter, votingAddr, "it should set the voter to the msg.sender");
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import "forge-std/console.sol";

contract Contract {
	enum Choices { Yes, No }
	error Contract_CanVoteOnlyOnce();
	error Contract_NoExistingVote();
	
	struct Vote {
		Choices choice;
		address voter;
	}
	Vote none = Vote(Choices(0), address(0));

	Vote[] public votes;
	
	function createVote(Choices choice) external {
		if(hasVoted(msg.sender)){
			revert Contract_CanVoteOnlyOnce();
		}
		Vote memory vote = Vote(choice, msg.sender);
		votes.push(vote);
	}

	function hasVoted(address voter) public view returns(bool) {
		return findVote(voter).voter == voter;
	}

	function findChoice(address voter) external view returns(Choices) {
		return findVote(voter).choice;
	}

	function findVote(address voter) internal view returns(Vote storage) {
		for(uint i = 0; i < votes.length; i++) {
			if(votes[i].voter == voter) {
				return votes[i];
			}
		}
		return none;
	}


	function changeVote(Choices choice) external {
		Vote storage vote = findVote(msg.sender);
		require(vote.voter != none.voter);
		vote.choice = choice;
	}

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address votingAddr = address(2);

    function setUp() public {
        vm.startPrank(votingAddr);
        myContract = new Contract();
    }

    function testVoteYes() public {
        myContract.createVote(Contract.Choices.Yes);
        (Contract.Choices choice, address voter) = myContract.votes(0);
        assertEq(uint(choice), uint(Contract.Choices.Yes), "it should set the vote to Yes");
        assertEq(voter, votingAddr, "it should set the voter to the msg.sender");
    }

    function testVoteNo() public {
        myContract.createVote(Contract.Choices.No);
        (Contract.Choices choice, address voter) = myContract.votes(0);
        assertEq(uint(choice), uint(Contract.Choices.No), "it should set the vote to No");
        assertEq(voter, votingAddr, "it should set the voter to the msg.sender");
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import "forge-std/console.sol";

contract Contract {
	enum Choices { Yes, No }
	error Contract_CanVoteOnlyOnce();
	error Contract_NoExistingVote();
	
	struct Vote {
		Choices choice;
		address voter;
	}
	Vote none = Vote(Choices(0), address(0));

	Vote[] public votes;
	
	function createVote(Choices choice) external {
		if(hasVoted(msg.sender)){
			revert Contract_CanVoteOnlyOnce();
		}
		Vote memory vote = Vote(choice, msg.sender);
		votes.push(vote);
	}

	function hasVoted(address voter) public view returns(bool) {
		return findVote(voter).voter == voter;
	}

	function findChoice(address voter) external view returns(Choices) {
		return findVote(voter).choice;
	}

	function findVote(address voter) internal view returns(Vote storage) {
		for(uint i = 0; i < votes.length; i++) {
			if(votes[i].voter == voter) {
				return votes[i];
			}
		}
		return none;
	}


	function changeVote(Choices choice) external {
		Vote storage vote = findVote(msg.sender);
		require(vote.voter != none.voter);
		vote.choice = choice;
	}

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address votingAddr = address(2);

    function setUp() public {
        vm.startPrank(votingAddr);
        myContract = new Contract();
    }

    function testVoteYes() public {
        myContract.createVote(Contract.Choices.Yes);
        assertEq(myContract.hasVoted(votingAddr), true, "it should register the address as having voted");
        Contract.Choices choice = myContract.findChoice(votingAddr);
        assertEq(uint(choice), uint(Contract.Choices.Yes), "it should find the voting choice for the voter");
    }

    function testVoteNo() public {
        myContract.createVote(Contract.Choices.No);
        assertEq(myContract.hasVoted(votingAddr), true, "it should register the address as having voted");
        Contract.Choices choice = myContract.findChoice(votingAddr);
        assertEq(uint(choice), uint(Contract.Choices.No), "it should find the voting choice for the voter");
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import "forge-std/console.sol";

contract Contract {
	enum Choices { Yes, No }
	error Contract_CanVoteOnlyOnce();
	error Contract_NoExistingVote();
	
	struct Vote {
		Choices choice;
		address voter;
	}
	Vote none = Vote(Choices(0), address(0));

	Vote[] public votes;
	
	function createVote(Choices choice) external {
		if(hasVoted(msg.sender)){
			revert Contract_CanVoteOnlyOnce();
		}
		Vote memory vote = Vote(choice, msg.sender);
		votes.push(vote);
	}

	function hasVoted(address voter) public view returns(bool) {
		return findVote(voter).voter == voter;
	}

	function findChoice(address voter) external view returns(Choices) {
		return findVote(voter).choice;
	}

	function findVote(address voter) internal view returns(Vote storage) {
		for(uint i = 0; i < votes.length; i++) {
			if(votes[i].voter == voter) {
				return votes[i];
			}
		}
		return none;
	}


	function changeVote(Choices choice) external {
		Vote storage vote = findVote(msg.sender);
		require(vote.voter != none.voter);
		vote.choice = choice;
	}

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address votingAddr = address(2);

    function setUp() public {
        vm.startPrank(votingAddr);
        myContract = new Contract();
    }

    function testVoteYes() public {
        myContract.createVote(Contract.Choices.Yes);
        assertEq(myContract.hasVoted(votingAddr), true, "it should register the address as having voted");
        vm.expectRevert();
        myContract.createVote(Contract.Choices.Yes);
    }

    function testVoteNo() public {
        myContract.createVote(Contract.Choices.No);
        assertEq(myContract.hasVoted(votingAddr), true, "it should register the address as having voted");
        vm.expectRevert();
        myContract.createVote(Contract.Choices.No);
    }
}


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import "forge-std/console.sol";

contract Contract {
	enum Choices { Yes, No }
	error Contract_CanVoteOnlyOnce();
	error Contract_NoExistingVote();
	
	struct Vote {
		Choices choice;
		address voter;
	}
	Vote none = Vote(Choices(0), address(0));

	Vote[] public votes;
	
	function createVote(Choices choice) external {
		if(hasVoted(msg.sender)){
			revert Contract_CanVoteOnlyOnce();
		}
		Vote memory vote = Vote(choice, msg.sender);
		votes.push(vote);
	}

	function hasVoted(address voter) public view returns(bool) {
		return findVote(voter).voter == voter;
	}

	function findChoice(address voter) external view returns(Choices) {
		return findVote(voter).choice;
	}

	function findVote(address voter) internal view returns(Vote storage) {
		for(uint i = 0; i < votes.length; i++) {
			if(votes[i].voter == voter) {
				return votes[i];
			}
		}
		return none;
	}


	function changeVote(Choices choice) external {
		Vote storage vote = findVote(msg.sender);
		require(vote.voter != none.voter);
		vote.choice = choice;
	}

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address votingAddr = address(2);

    function setUp() public {
        vm.startPrank(votingAddr);
        myContract = new Contract();
    }

    function testVoteTwiceRevert() public {
        myContract.createVote(Contract.Choices.Yes);
        vm.expectRevert();
        myContract.createVote(Contract.Choices.Yes);
    }

    function testVoteChange() public {
        myContract.createVote(Contract.Choices.No);
        Contract.Choices choice = myContract.findChoice(votingAddr);
        assertEq(uint(choice), uint(Contract.Choices.No));

        myContract.changeVote(Contract.Choices.Yes);
        choice = myContract.findChoice(votingAddr);
        assertEq(uint(choice), uint(Contract.Choices.Yes));
    }
}


