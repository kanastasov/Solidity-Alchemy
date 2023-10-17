// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";

contract Mage is Hero(50){
    function attack(Enemy enemy) public override{
        enemy.takeAttack(Hero.AttackTypes.Spell);
                        super.attack(enemy);


        // spell
    }
}

contract Warrior is Hero(200){
      function attack(Enemy enemy) public override{
                enemy.takeAttack(Hero.AttackTypes.Brawl);
                  super.attack(enemy);
        // brawl
    }
}


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Enemy.sol";

contract Hero {
	uint public health;
	uint public energy = 10;
	constructor(uint _health) {
		health = _health;
	}

	enum AttackTypes { Brawl, Spell }
	function attack(Enemy) public virtual {
		energy--;
	}
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";

contract Enemy {
    uint public health = 100;

	function takeAttack(Hero.AttackTypes attackType) external {
        if(attackType == Hero.AttackTypes.Brawl) {
            health -= 50;
        }
        else if(attackType == Hero.AttackTypes.Spell) {
            health -= 80;
        }
	}
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Hero.sol";
import "../src/SuperHeroes.sol";
import "../src/Enemy.sol";

contract EscrowTest is Test {
    Warrior public warrior;
    Mage public mage;
    Enemy public enemy;
    
    function setUp() public {
        warrior = new Warrior();
        mage = new Mage();
        enemy = new Enemy();
    }

    function testWarriorAttack() public {
        warrior.attack(enemy);
        assertEq(enemy.health(), 50);
        assertEq(warrior.energy(), 9);
    }

    function testMageAttack() public {
        mage.attack(enemy);
        assertEq(enemy.health(), 20);
        assertEq(mage.energy(), 9);
    }
}


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Ownable {
    constructor() { owner = msg.sender; }
    address owner;
	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}
}

contract Transferable is Ownable {
	function transfer(address newOwner) external onlyOwner {
		owner = newOwner;
	}
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./BaseContracts.sol";

contract Collectible is Ownable {
	uint public price;

	function markPrice(uint _price) external onlyOwner {
		price = _price;
	}
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/BaseContracts.sol";
import "../src/Collectible.sol";

contract OwnableTest is Test {
    Collectible public collectible;

    function setUp() public {
        collectible = new Collectible();
    }

    function testAsOwner() public {
        collectible.markPrice(5);
    }

    function testAsNonOwner() public {
        vm.prank(address(2));
        vm.expectRevert();
        collectible.markPrice(5);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Ownable {
    constructor() { owner = msg.sender; }
    address owner;
	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}
}

contract Transferable is Ownable {
	function transfer(address newOwner) external onlyOwner {
		owner = newOwner;
	}
}


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./BaseContracts.sol";

contract Collectible is Ownable, Transferable {
	uint public price;

	function markPrice(uint _price) external onlyOwner {
		price = _price;
	}
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/BaseContracts.sol";
import "../src/Collectible.sol";

contract OwnableTest is Test {
    Collectible public collectible;

    function setUp() public {
        collectible = new Collectible();
    }

    function testAsOwner() public {
        collectible.markPrice(5);
        collectible.transfer(address(4));

        vm.startPrank(address(4));
        collectible.markPrice(10);
        assertEq(collectible.price(), 10);
    }

    function testAsNonOwner() public {
        vm.startPrank(address(2));

        vm.expectRevert();
        collectible.markPrice(5);

        vm.expectRevert();
        collectible.transfer(address(4));
    }
}

