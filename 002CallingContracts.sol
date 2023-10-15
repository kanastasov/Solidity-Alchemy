// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IHero {
    function alert() external;
}

contract Sidekick {
    function sendAlert(address hero) external {
        // TODO: alert the hero using the IHero interface
        IHero(hero).alert();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Hero {
    bool public alerted;

    function alert() external {
        alerted = true;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Hero.sol";
import "../src/Sidekick.sol";

contract ContractTest is Test {
    Sidekick public sidekick;
    Hero public hero;

    function setUp() public {
        hero = new Hero();
        sidekick = new Sidekick();
    }

    function testAlert() public {
        sidekick.sendAlert(address(hero));
        assertEq(hero.alerted(), true, "it should have alerted the hero");
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function sendAlert(address hero) external {
        bytes4 signature = bytes4(keccak256("alert()"));

        (bool success, ) = hero.call(abi.encodePacked(signature));

        require(success);
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Hero {
    bool public alerted;

    function alert() external {
        alerted = true;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Hero.sol";
import "../src/Sidekick.sol";

contract ContractTest is Test {
    Sidekick public sidekick;
    Hero public hero;

    function setUp() public {
        hero = new Hero();
        sidekick = new Sidekick();
    }

    function testAlert() public {
        sidekick.sendAlert(address(hero));
        assertEq(hero.alerted(), true, "it should have alerted the hero");
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function sendAlert(address hero, uint enemies, bool armed) external {

       bytes memory payload  = abi.encodeWithSignature("alert(uint256,bool)", enemies, armed);
        (bool success, ) = hero.call(

            payload
        );

        require(success);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Hero {
    Ambush public ambush;

    struct Ambush {
        bool alerted;
        uint enemies;
        bool armed;
    }

    function alert(uint enemies, bool armed) external {
        ambush = Ambush(true, enemies, armed);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Hero.sol";
import "../src/Sidekick.sol";

contract ContractTest is Test {
    Sidekick public sidekick;
    Hero public hero;

    function setUp() public {
        hero = new Hero();
        sidekick = new Sidekick();
    }

    function testAlert1() public {
        sidekick.sendAlert(address(hero), 5, true);
        (bool alerted, uint enemies, bool armed) = hero.ambush();
        assertEq(alerted, true, "it should have alerted the hero");
        assertEq(enemies, 5, "it should have let the hero know theres 5 enemies");
        assertEq(armed, true, "it should have let the hero know the enemies are armed");
    }

    function testAlert2() public {
        sidekick.sendAlert(address(hero), 2, false);
        (bool alerted, uint enemies, bool armed) = hero.ambush();
        assertEq(alerted, true, "it should have alerted the hero");
        assertEq(enemies, 2, "it should have let the hero know theres 2 enemies");
        assertEq(armed, false, "it should have let the hero know the enemies are not armed");
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function relay(address hero, bytes memory data) external {
        
        // send all of the data as calldata to the hero


        (bool success, ) = hero.call(data);

        require(success);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Hero {
    Ambush public ambush;

    struct Ambush {
        bool alerted;
        uint enemies;
        bool armed;
    }

    uint lastContact;

    function alert(uint enemies, bool armed) external {
        ambush = Ambush(true, enemies, armed);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Hero.sol";
import "../src/Sidekick.sol";

contract ContractTest is Test {
    Sidekick public sidekick;
    Hero public hero;

    function setUp() public {
        hero = new Hero();
        sidekick = new Sidekick();
    }

    function testAlert1() public {
        sidekick.relay(address(hero), abi.encodeWithSignature("alert(uint256,bool)", 5, true));
        (bool alerted, uint enemies, bool armed) = hero.ambush();
        assertEq(alerted, true, "it should have alerted the hero");
        assertEq(enemies, 5, "it should have let the hero know theres 5 enemies");
        assertEq(armed, true, "it should have let the hero know the enemies are armed");
    }

    function testAlert2() public {
        sidekick.relay(address(hero), abi.encodeWithSignature("alert(uint256,bool)", 2, false));
        (bool alerted, uint enemies, bool armed) = hero.ambush();
        assertEq(alerted, true, "it should have alerted the hero");
        assertEq(enemies, 2, "it should have let the hero know theres 2 enemies");
        assertEq(armed, false, "it should have let the hero know the enemies are not armed");
    }
}
