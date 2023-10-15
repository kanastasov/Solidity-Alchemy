// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    error Contract_NotEnoughtEth();
    error Contract_NotDeployer();
    address public owner;

    constructor() payable{
        if(msg.value < 1){
            revert Contract_NotEnoughtEth();
        }
        owner = msg.sender;
    }

    function withdraw() public payable{
        if(msg.sender != owner){
            revert Contract_NotDeployer();
        }
        // withdraw funds from contract
        // send fund to deployer
		 payable(msg.sender).transfer(address(this).balance);
    }

    	
	

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;

    function testSuccess() public {
        myContract = new Contract{ value: 1 ether }();
        assertFalse(address(myContract) == address(0));
    }

    function testFailure() public {
        myContract = new Contract{ value: 0.5 ether }();
        assertEq(address(myContract), address(0));
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    error Contract_NotEnoughtEth();
    error Contract_NotDeployer();
    address public owner;

    constructor() payable{
        if(msg.value < 1){
            revert Contract_NotEnoughtEth();
        }
        owner = msg.sender;
    }

    function withdraw() public payable{
        if(msg.sender != owner){
            revert Contract_NotDeployer();
        }
        // withdraw funds from contract
        // send fund to deployer
		 payable(msg.sender).transfer(address(this).balance);
    }

    	
	

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address owner = address(2);

    function setUp() public {
        hoax(owner);
        myContract = new Contract{ value: 1 ether }();
    }

    function testAsOwner() public {
        vm.prank(owner);
        uint balanceBefore = address(owner).balance;
        myContract.withdraw();
        uint balanceAfter = address(owner).balance;
        assertEq(balanceAfter - balanceBefore, 1 ether);
    }

    function testAsNotOwner() public {
        vm.prank(address(3));
        vm.expectRevert();
        myContract.withdraw();
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	uint configA;
	uint configB;
	uint configC;
	address owner;
	error Contract_NotOwner();

	constructor() {
		owner = msg.sender;
	}

	function setA(uint _configA) public onlyOwner {
		configA = _configA;
	}

	function setB(uint _configB) public onlyOwner {
		configB = _configB;
	}

	function setC(uint _configC) public onlyOwner {
		configC = _configC;
	}

	modifier onlyOwner {
		if(owner != msg.sender){
			revert Contract_NotOwner();
		}
		_;
		// TODO: require only the owner access

		// TODO: run the rest of the function body

	}
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address owner = address(2);

    function setUp() public {
        vm.prank(owner);
        myContract = new Contract();
    }

    function testAWithOwner() public {
        vm.prank(owner);
        myContract.setA(1);
        assertEq(vm.load(address(myContract), convertToBytes32(0)), convertToBytes32(1));
    }

    function testBWithOwner() public {
        vm.prank(owner);
        myContract.setB(2);
        assertEq(vm.load(address(myContract), convertToBytes32(1)), convertToBytes32(2));
    }

    function testCWithOwner() public {
        vm.prank(owner);
        myContract.setC(3);
        assertEq(vm.load(address(myContract), convertToBytes32(2)), convertToBytes32(3));
    }

    function testANotOwner() public {
        vm.expectRevert();
        myContract.setA(1);
    }

    function testBNotOwner() public {
        vm.expectRevert();
        myContract.setB(2);
    }
    
    function testCNotOwner() public {
        vm.expectRevert();
        myContract.setC(3);
    }

    function convertToBytes32(uint256 value) public pure returns (bytes32 result) {
        assembly {
            result := value
        }
    }
}
