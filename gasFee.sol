// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract gasFee is ERC20 {
    address public admin;
    uint public FeesReceived=0;
 
    constructor(address _admin) ERC20("Helix Token", "HLX") {
        _mint(admin, 1000000000000*10**18);
        admin=_admin;
       
    }

    receive() external payable { 
      
    }

    modifier onlyAdmin() {
        require(admin==msg.sender, "only admin has access");
        _;
    }

   

    function PayFee(uint amount) public payable onlyAdmin{
        require(amount>0, "amount has to be valid");
        _transfer(msg.sender, address(this), amount);
        if (msg.value>0) {
            FeesReceived+=amount;
        }

    }

    fallback() external payable {
        revert("contract does not accept ethers directly");
     }
}
