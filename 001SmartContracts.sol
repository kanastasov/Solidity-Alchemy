// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    bool public a = true;
    bool public b = false;
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

    function testBools() public {
        assertEq(myContract.a(), true);
        assertEq(myContract.b(), false);
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint8 public a = 255;
    uint16 public b = 256;

    uint256 public sum = a + b;
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

    function testA() public {
        assertLt(myContract.a(), 256);
    }

    function testB() public {
        assertGe(myContract.b(), 256);
    }

    function testSum() public {
        assertEq(myContract.a() + myContract.b(), myContract.sum());
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
     int8 public a = 10;
    int8 public b = -15;

    int16 public difference = a - b;
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

    function testSigns() public {
        int8 a = myContract.a();
        int8 b = myContract.b();
        bool onlyAPositive = a > 0 && b < 0;
        bool onlyBPositive = b > 0 && a < 0;
        assert(onlyAPositive || onlyBPositive);
    }

    function testAbsoluteDifference() public {
        int8 a = myContract.a();
        int8 b = myContract.b();
        int16 diff = myContract.difference();
        int16 expectedDiff = (a > b) ? a - b : b - a;
        assertEq(diff, expectedDiff);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	bytes32 public msg1 = "Hello World"; 
	string public msg2 = "Hello World, I am a sentient robot and I have come to take over your planet";
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

    function testMsg1() public {
        assertEq(myContract.msg1(), "Hello World");
    }

    function testMsg2Length() public {
        assertGt(bytes(myContract.msg2()).length, 32);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    enum Foods { Apple, Pizza, Bagel, Banana }

	Foods public food1 = Foods.Apple ;
	Foods public food2 = Foods.Pizza ;
	Foods public food3 = Foods.Bagel;
	Foods public food4 = Foods.Banana;
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

    function testFoods() public {
        Contract.Foods food1 = myContract.food1();
        Contract.Foods food2 = myContract.food2();
        Contract.Foods food3 = myContract.food3();
        Contract.Foods food4 = myContract.food4();

        // enums can be translated to uint8 based on their position
        // the first option is 0, then 1, 2, 3 etc...
        uint enumSum = uint8(food1) + uint8(food2) + uint8(food3) + uint8(food4);
        assertGe(enumSum, 6);
    }
}