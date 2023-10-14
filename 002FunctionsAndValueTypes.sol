// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint public x;
    constructor(uint _x){
        x = _x;
    }

  function increment() public{
        x+=1;
    }

    function add(uint y) external view returns(uint){
        return y + x;

    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;

    function setUp() public {
        myContract = new Contract(5);
    }

    function testConstructor() public {
        assertEq(myContract.x(), 5);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint public x;
    constructor(uint _x){
        x = _x;
    }

  function increment() public{
        x+=1;
    }

    function add(uint y) external view returns(uint){
        return y + x;

    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;

    function setUp() public {
        myContract = new Contract(5);
    }

    function testConstructor() public {
        assertEq(myContract.x(), 5);
    }

    function testIncrement() public {
        myContract.increment();
        assertEq(myContract.x(), 6);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint public x;
    constructor(uint _x){
        x = _x;
    }

  function increment() public{
        x+=1;
    }

    function add(uint y) external view returns(uint){
        return y + x;

    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;

    function setUp() public {
        myContract = new Contract(5);
    }

    function testConstructor() public {
        assertEq(myContract.x(), 5);
    }

    function testIncrement() public {
        myContract.increment();
        assertEq(myContract.x(), 6);
    }

    function testAdd() public {
        uint y = myContract.add(5);
        assertEq(y, 10, "it should return the sum");
        assertEq(myContract.x(), 5, "it should not affect x");
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract Contract {
    function winningNumber(string calldata secretMessage) external returns(uint) {
        console.log(secretMessage);
        return 794;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";
import "./Secret.sol";

contract ContractTest is Test {
    Contract public myContract;

    function setUp() public {
        myContract = new Contract();
    }

    function testWin() public {
        assertEq(myContract.winningNumber(Secret.message), Secret.win);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    function double(uint x) external pure returns(uint sum){
        sum = x * 2;
    }

    function double(uint x, uint y) external pure returns(uint, uint){
        return(x*2, y*2);

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

    function testDouble() public {
        assertEq(myContract.double(2), 4);
        assertEq(myContract.double(4), 8);
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    function double(uint x) external pure returns(uint sum){
        sum = x * 2;
    }

    function double(uint x, uint y) external pure returns(uint, uint){
        return(x*2, y*2);

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

    function testDouble() public {
        assertEq(myContract.double(2), 4);
        assertEq(myContract.double(4), 8);
    }

    function testDoubleWithTwoParams() public {
        (uint x, uint y) = myContract.double(2, 2);
        assertEq(x, 4);
        assertEq(y, 4);

        (uint x2, uint y2) = myContract.double(5, 10);
        assertEq(x2, 10);
        assertEq(y2, 20);
    }
}




