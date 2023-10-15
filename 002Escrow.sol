// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;
    event Approved(uint);
    error Escrow_NotArbiter();

    constructor(address _arbiter, address _beneficiary) payable{
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    function  approve() external payable {  

        if(arbiter != msg.sender){
            revert Escrow_NotArbiter();
        }

        emit Approved(address(this).balance);


        (bool success,  ) = beneficiary.call{value: address(this).balance}("");
        require (success);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Escrow.sol";

contract EscrowTest is Test {
    Escrow public escrow;

    function setUp() public {
        escrow = new Escrow();
    }

    function testMethods() public {
        assertEq(escrow.arbiter(), address(0));
        assertEq(escrow.depositor(), address(0));
        assertEq(escrow.beneficiary(), address(0));
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;
    event Approved(uint);
    error Escrow_NotArbiter();

    constructor(address _arbiter, address _beneficiary) payable{
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    function  approve() external payable {  

        if(arbiter != msg.sender){
            revert Escrow_NotArbiter();
        }

        emit Approved(address(this).balance);


        (bool success,  ) = beneficiary.call{value: address(this).balance}("");
        require (success);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Escrow.sol";

contract EscrowTest is Test {
    Escrow public escrow;
    address arbiter = address(2);
    address depositor = address(3);
    address beneficiary = address(4);

    function setUp() public {
        vm.prank(depositor);
        escrow = new Escrow(arbiter, beneficiary);
    }

    function testAddresses() public {
        assertEq(escrow.arbiter(), arbiter);
        assertEq(escrow.depositor(), depositor);
        assertEq(escrow.beneficiary(), beneficiary);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;
    event Approved(uint);
    error Escrow_NotArbiter();

    constructor(address _arbiter, address _beneficiary) payable{
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    function  approve() external payable {  

        if(arbiter != msg.sender){
            revert Escrow_NotArbiter();
        }

        emit Approved(address(this).balance);


        (bool success,  ) = beneficiary.call{value: address(this).balance}("");
        require (success);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Escrow.sol";

contract EscrowTest is Test {
    Escrow public escrow;
    address arbiter = address(2);
    address depositor = address(3);
    address beneficiary = address(4);

    function setUp() public {
        hoax(depositor);
        escrow = new Escrow{ value: 1 ether }(arbiter, beneficiary);
    }

    function testAddresses() public {
        assertEq(escrow.arbiter(), arbiter);
        assertEq(escrow.depositor(), depositor);
        assertEq(escrow.beneficiary(), beneficiary);
    }

    function testBalance() public {
        assertEq(address(escrow).balance, 1 ether);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;
    event Approved(uint);
    error Escrow_NotArbiter();

    constructor(address _arbiter, address _beneficiary) payable{
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    function  approve() external payable {  

        if(arbiter != msg.sender){
            revert Escrow_NotArbiter();
        }

        emit Approved(address(this).balance);


        (bool success,  ) = beneficiary.call{value: address(this).balance}("");
        require (success);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Escrow.sol";

contract EscrowTest is Test {
    Escrow public escrow;
    address arbiter = address(2);
    address depositor = address(3);
    address payable beneficiary = payable(address(4));

    function setUp() public {
        hoax(depositor);
        escrow = new Escrow{ value: 1 ether }(arbiter, beneficiary);
        
        vm.prank(arbiter);
        escrow.approve();
    }

    function testBalance() public {
        assertEq(beneficiary.balance, 1 ether);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;
    event Approved(uint);
    error Escrow_NotArbiter();

    constructor(address _arbiter, address _beneficiary) payable{
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    function  approve() external payable {  

        if(arbiter != msg.sender){
            revert Escrow_NotArbiter();
        }

        emit Approved(address(this).balance);


        (bool success,  ) = beneficiary.call{value: address(this).balance}("");
        require (success);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Escrow.sol";

contract EscrowTest is Test {
    Escrow public escrow;
    address arbiter = address(2);
    address depositor = address(3);
    address payable beneficiary = payable(address(4));

    function setUp() public {
        hoax(depositor);
        escrow = new Escrow{ value: 1 ether }(arbiter, beneficiary);
    }

    function testAsOther() public {
        vm.prank(depositor);
        vm.expectRevert();
        escrow.approve();

        vm.prank(beneficiary);
        vm.expectRevert();
        escrow.approve();
    }

    function testAsArbiter() public {
        vm.prank(arbiter);
        escrow.approve();

        assertEq(beneficiary.balance, 1 ether);
    }
}


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;
    event Approved(uint);
    error Escrow_NotArbiter();

    constructor(address _arbiter, address _beneficiary) payable{
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    function  approve() external payable {  

        if(arbiter != msg.sender){
            revert Escrow_NotArbiter();
        }

        emit Approved(address(this).balance);


        (bool success,  ) = beneficiary.call{value: address(this).balance}("");
        require (success);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Escrow.sol";

contract EscrowTest is Test {
    Escrow public escrow;
    address arbiter = address(2);
    address depositor = address(3);
    address payable beneficiary = payable(address(4));

    function setUp() public {
        hoax(depositor);
        escrow = new Escrow{ value: 1 ether }(arbiter, beneficiary);
    }

    function testApprovalEvent() public {
        vm.prank(arbiter);
        vm.recordLogs();

        escrow.approve();

        Vm.Log[] memory entries = vm.getRecordedLogs();
        assertEq(entries.length, 1);
        assertEq(entries[0].topics[0], keccak256("Approved(uint256)"));
        assertEq(abi.decode(entries[0].data, (uint)), 1 ether);
    }
}



