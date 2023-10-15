// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    uint[5] public  numbers = [1,2,3,4,5];
    
    function sum(uint[5] calldata _numbers) external pure returns(uint sum) {
        for(uint i=0;i<_numbers.length; i++){
            sum+= _numbers[i];
        }
    }

    
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;

    function setUp() public {
        myContract = new Contract();
    }

    function testSum1() public {
        uint256[5] memory arr = [uint(1), 1, 1, 1, 1];
        assertEq(myContract.sum(arr), 5);
    }

    function testSum2() public {
        uint256[5] memory arr = [uint(1), 2, 3, 4, 5];
        assertEq(myContract.sum(arr), 15);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {


   function sum(uint[] calldata arr) pure external returns(uint total){
       for(uint i=0;i<arr.length; i++){
           total+=arr[i];
       }
       return total;

   } 
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    uint256[] arr;

    function setUp() public {
        myContract = new Contract();
    }

    function testSum1() public {
        arr.push(5);
        assertEq(myContract.sum(arr), 5);
    }

    function testSum2() public {
        arr.push(1);
        arr.push(1);
        arr.push(1);
        assertEq(myContract.sum(arr), 3);
    }

    function testSum3() public {
        arr.push(5);
        arr.push(5);
        arr.push(5);
        arr.push(5);
        arr.push(5);
        assertEq(myContract.sum(arr), 25);
    }
}


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    uint[] public evenNumbers;

    function filterEven(uint[] calldata arr) external{
        for(uint i=0; i<arr.length; i++){
            if(arr[i] % 2 == 0){
                evenNumbers.push(arr[i]);
            }
        }
    } 
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    uint256[] arr;

    function setUp() public {
        myContract = new Contract();
    }

    function testFilter1() public {
        arr.push(1);
        arr.push(2);
        arr.push(4);
        myContract.filterEven(arr);

        assertEq(myContract.evenNumbers(0), 2);
        assertEq(myContract.evenNumbers(1), 4);

        vm.expectRevert();
        myContract.evenNumbers(2);
    }

    function testFilter2() public {
        arr.push(1);
        arr.push(12);
        arr.push(302);
        arr.push(7);
        arr.push(10);
        myContract.filterEven(arr);

        assertEq(myContract.evenNumbers(0), 12);
        assertEq(myContract.evenNumbers(1), 302);
        assertEq(myContract.evenNumbers(2), 10);

        vm.expectRevert();
        myContract.evenNumbers(3);
    }
}


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	function filterEven(uint[] calldata x) external pure returns(uint[] memory) {
		uint n;
		for(uint i = 0; i < x.length; i++) {
			if(x[i] % 2 == 0) n++;
		}

		uint[] memory filtered = new uint[](n);
		uint filled = 0;
		for(uint i = 0; i < x.length; i++) {
			if(x[i] % 2 == 0) {
				filtered[filled] = x[i];
				filled++;
			}
		}

		return filtered;
	}
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    uint256[] arr;

    function setUp() public {
        myContract = new Contract();
    }

    function testFilter1() public {
        arr.push(1);
        arr.push(2);
        arr.push(4);
        uint[] memory newArr = myContract.filterEven(arr);
        assertEq(newArr.length, 2);
        assertEq(newArr[0], 2);
        assertEq(newArr[1], 4);
    }

    function testFilter2() public {
        arr.push(1);
        arr.push(12);
        arr.push(302);
        arr.push(7);
        arr.push(10);
        uint[] memory newArr = myContract.filterEven(arr);
        assertEq(newArr.length, 3);
        assertEq(newArr[0], 12);
        assertEq(newArr[1], 302);
        assertEq(newArr[2], 10);
    }
}


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import "forge-std/console.sol";

contract StackClub {
    address[] public members;
    error StackClub_NotExistingMember();

    constructor(){
        members.push(msg.sender);
    }
    function addMember (address member) external{
         bool flagIndicate;
        for(uint i=0; i< members.length; i++){
        if(members[i]== msg.sender){
            flagIndicate = true;
           
        }
        }

        if(!flagIndicate){
             revert StackClub_NotExistingMember();
        }
        members.push(member);
    }

    function  isMember(address member) public view returns(bool isMemberFlag){
       isMemberFlag = false;

        for(uint i=0; i< members.length; i++){

            if(members[i] == member){
                isMemberFlag = true;
            }
        }

        return isMemberFlag;
    }

    function removeLastMember() public{
        bool flagIndicate;
        for(uint i=0; i< members.length; i++){
        if(members[i]== msg.sender){
            flagIndicate = true;
           
        }
        }

        if(!flagIndicate){
             revert StackClub_NotExistingMember();
        }
        
        members.pop();
    }

    
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/StackClub.sol";

contract StackClubTest is Test {
    StackClub public stackClub;
    address member1 = address(2);
    address member2 = address(3);
    address nonMember1 = address(4);
    address nonMember2 = address(5);

    function setUp() public {
        stackClub = new StackClub();
        stackClub.addMember(member1);
        stackClub.addMember(member2);
    }

    function testMembers() public {
        assertEq(stackClub.isMember(member1), true);
        assertEq(stackClub.isMember(member2), true);
    }

    function testNonMembers() public {
        assertEq(stackClub.isMember(nonMember1), false);
        assertEq(stackClub.isMember(nonMember2), false);
    }
}


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import "forge-std/console.sol";

contract StackClub {
    address[] public members;
    error StackClub_NotExistingMember();

    constructor(){
        members.push(msg.sender);
    }
    function addMember (address member) external{
         bool flagIndicate;
        for(uint i=0; i< members.length; i++){
        if(members[i]== msg.sender){
            flagIndicate = true;
           
        }
        }

        if(!flagIndicate){
             revert StackClub_NotExistingMember();
        }
        members.push(member);
    }

    function  isMember(address member) public view returns(bool isMemberFlag){
       isMemberFlag = false;

        for(uint i=0; i< members.length; i++){

            if(members[i] == member){
                isMemberFlag = true;
            }
        }

        return isMemberFlag;
    }

    function removeLastMember() public{
        bool flagIndicate;
        for(uint i=0; i< members.length; i++){
        if(members[i]== msg.sender){
            flagIndicate = true;
           
        }
        }

        if(!flagIndicate){
             revert StackClub_NotExistingMember();
        }
        
        members.pop();
    }

    
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/StackClub.sol";

contract StackClubTest is Test {
    StackClub public stackClub;
    address member1 = address(2);
    address member2 = address(3);
    address nonMember1 = address(4);
    address nonMember2 = address(5);

    function setUp() public {
        stackClub = new StackClub();
        stackClub.addMember(member1);
        stackClub.addMember(member2);
    }

    function testMembers() public {
        assertEq(stackClub.isMember(member1), true);
        assertEq(stackClub.isMember(member2), true);
    }

    function testNonMembers() public {
        assertEq(stackClub.isMember(nonMember1), false);
        assertEq(stackClub.isMember(nonMember2), false);
    }

    function testAddAsNonMember() public {
        vm.startPrank(nonMember1);

        vm.expectRevert();
        stackClub.addMember(address(6));

        vm.expectRevert();
        stackClub.removeLastMember();
    }

    function testRemoveLastMember() public {
        stackClub.removeLastMember();
        assertEq(stackClub.isMember(member1), true);
        assertEq(stackClub.isMember(member2), false);
        
        stackClub.removeLastMember();
        assertEq(stackClub.isMember(member1), false);
        assertEq(stackClub.isMember(member2), false);
    }
}

