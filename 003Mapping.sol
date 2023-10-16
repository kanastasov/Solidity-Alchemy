// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
  mapping(address=> bool) public members;

  function addMember(address adr) external{

      members[adr] = true;
  }

  function isMember(address adr) external returns(bool){
    return members[adr];
  }

  function removeMember(address adr) external{
    members[adr] = false;
  }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address member1 = address(2);
    address member2 = address(3);
    address nonMember1 = address(4);
    address nonMember2 = address(5);

    function setUp() public {
        myContract = new Contract();
        myContract.addMember(member1);
        myContract.addMember(member2);
    }

    function testMembers() public {
        assertEq(myContract.members(member1), true);
        assertEq(myContract.members(member2), true);
    }

    function testNonMembers() public {
        assertEq(myContract.members(nonMember1), false);
        assertEq(myContract.members(nonMember2), false);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
  mapping(address=> bool) public members;

  function addMember(address adr) external{

      members[adr] = true;
  }

  function isMember(address adr) external returns(bool){
    return members[adr];
  }

  function removeMember(address adr) external{
    members[adr] = false;
  }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address member1 = address(2);
    address member2 = address(3);
    address nonMember1 = address(4);
    address nonMember2 = address(5);

    function setUp() public {
        myContract = new Contract();
        myContract.addMember(member1);
        myContract.addMember(member2);
    }

    function testMembers() public {
        assertEq(myContract.isMember(member1), true);
        assertEq(myContract.isMember(member2), true);
    }

    function testNonMembers() public {
        assertEq(myContract.isMember(nonMember1), false);
        assertEq(myContract.isMember(nonMember2), false);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
  mapping(address=> bool) public members;

  function addMember(address adr) external{

      members[adr] = true;
  }

  function isMember(address adr) external returns(bool){
    return members[adr];
  }

  function removeMember(address adr) external{
    members[adr] = false;
  }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address member1 = address(2);
    address member2 = address(3);

    function setUp() public {
        myContract = new Contract();
        myContract.addMember(member1);
        myContract.addMember(member2);
    }

    function testMembers() public {
        assertEq(myContract.isMember(member1), true);
        assertEq(myContract.isMember(member2), true);
    }

    function testRemoval() public {
        myContract.removeMember(member1);
        assertEq(myContract.isMember(member1), false);
        assertEq(myContract.isMember(member2), true);

        myContract.removeMember(member2);
        assertEq(myContract.isMember(member1), false);
        assertEq(myContract.isMember(member2), false);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	struct User {
		uint balance;
		bool isActive;
	}

mapping(address => User) public  users;

function createUser() external {
		require(!users[msg.sender].isActive);
		users[msg.sender] = User(100, true);
	}

	function transfer(address adr, uint amount) external payable{
		require(users[msg.sender].isActive);
		require(users[adr].isActive);
	
		require(users[msg.sender].balance >= amount);
		users[msg.sender].balance -= amount;
		users[adr].balance += amount;

	}

	

}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address addr1 = address(2);

    function setUp() public {
        myContract = new Contract();
    }

    function testCreateUser() public {
        vm.startPrank(addr1);

        myContract.createUser();
        (uint balance, bool isActive) = myContract.users(addr1);
        assertEq(balance, 100, "expect initial user balance to be 100");
        assertEq(isActive, true, "expect user to be set to active initially");

        vm.expectRevert();
        myContract.createUser();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	struct User {
		uint balance;
		bool isActive;
	}

mapping(address => User) public  users;

function createUser() external {
		require(!users[msg.sender].isActive);
		users[msg.sender] = User(100, true);
	}

	function transfer(address adr, uint amount) external payable{
		require(users[msg.sender].isActive);
		require(users[adr].isActive);
		require(users[msg.sender].balance >= amount);
		users[msg.sender].balance -= amount;
		users[adr].balance += amount;

	}

	

}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address addr1 = address(2);
    address addr2 = address(3);

    function setUp() public {
        myContract = new Contract();

        vm.prank(addr1);
        myContract.createUser();

        vm.prank(addr2);
        myContract.createUser();
    }

    function testInitialUsers() public {
        (uint balance, bool isActive) = myContract.users(addr1);
        assertEq(balance, 100, "expect initial user balance to be 100");
        assertEq(isActive, true, "expect user to be set to active initially");
    }

    function testTransfer() public {
        vm.prank(addr2);
        myContract.transfer(addr1, 50);

        (uint balance,) = myContract.users(addr1);
        assertEq(balance, 150, "expect a transfer to increase recipients balance");

        (uint balance2,) = myContract.users(addr2);
        assertEq(balance2, 50, "expect a transfer to increase recipients balance");
    }

    function testTransferTooMuch() public {
        vm.prank(addr2);
        vm.expectRevert();
        myContract.transfer(addr1, 150);
    }

    function testTransferToInactive() public {
        vm.prank(addr2);
        vm.expectRevert();
        myContract.transfer(address(4), 50);
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	enum ConnectionTypes { 
		Unacquainted,
		Friend,
		Family
	}
	
	mapping (address => mapping(address => ConnectionTypes)) public connections ;

	function connectWith(address other, ConnectionTypes connectionType) external {
		connections[msg.sender][other]= connectionType;
	}
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address a1 = address(2);
    address a2 = address(3);

    function setUp() public {
        myContract = new Contract();
    }

    function testUnacquainted() public {
        assertEq(uint(myContract.connections(a1, a2)), uint(Contract.ConnectionTypes.Unacquainted));
        assertEq(uint(myContract.connections(a2, a1)), uint(Contract.ConnectionTypes.Unacquainted));
    }

    function testConnectingBoth() public {
        vm.prank(a1);
        myContract.connectWith(a2, Contract.ConnectionTypes.Friend);
        vm.prank(a2);
        myContract.connectWith(a1, Contract.ConnectionTypes.Friend);

        assertEq(uint(myContract.connections(a1, a2)), uint(Contract.ConnectionTypes.Friend));
        assertEq(uint(myContract.connections(a2, a1)), uint(Contract.ConnectionTypes.Friend));
    }

    function testConnectingOne() public {
        vm.prank(a1);
        myContract.connectWith(a2, Contract.ConnectionTypes.Family);

        assertEq(uint(myContract.connections(a1, a2)), uint(Contract.ConnectionTypes.Family));
        assertEq(uint(myContract.connections(a2, a1)), uint(Contract.ConnectionTypes.Unacquainted));
    }
}
