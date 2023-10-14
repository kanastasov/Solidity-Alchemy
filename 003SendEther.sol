// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/console.sol";

contract Contract {
    address public owner;
    address public charity;
    constructor(address _charity){
        owner = msg.sender;
        charity = _charity;
    }

    receive() external payable{
        console.log(msg.value);
    }

    function tip() public payable{
        owner.call{ value: msg.value}("");
    }

    function donate() public payable{
        console.log( address(this).balance ); 
        charity.call{value: address(this).balance }("");

        selfdestruct(payable(msg.sender));
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public myContract;
    address msgSender = address(3);
    address charity = address(4);

    function setUp() public {
        vm.prank(msgSender);
        myContract = new Contract(charity);
        address(myContract).call{ value: 4 ether }("");
        myContract.donate();
    }

    function testDonate() public {
        assertEq(charity.balance, 4 ether);
    }

    function testDestruction() public {
        assert(!isContract(address(myContract)));
    }

    function isContract(address _addr) public view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(_addr)
        }
        return (size > 0);
    }
}
