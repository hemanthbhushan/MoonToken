// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


contract MoonTOken is ERC20 {
    using SafeERC20 for IERC20;
    IERC20 token;
    address burn;
    address public owner;
    uint Tax = 5;
    uint Burn = 5;
    mapping(address => bool) checkEligibility;

    

    constructor(IERC20 _token , address _burn ) ERC20("MoonTOken", "MT") {
         token = _token;
         owner = msg.sender;
         checkEligibility[owner] = true;

        _mint(msg.sender, 1000000*10**18);
        burn = _burn;
        
    }


    function transferAmount(address to ,uint256 amount) public  returns(bool){
        IERC20 _token = IERC20(token);

        if(checkEligibility[msg.sender] == true){
           _transfer(msg.sender, to, amount);

        }else{
           uint tax_amount = (amount*Tax)/100;
           uint burn_amount = (amount*Burn)/100;

           _transfer(msg.sender,address(this) , tax_amount);

           _transfer(msg.sender, burn , burn_amount);

           _transfer(msg.sender, to, amount-tax_amount-burn_amount);

           _token.transfer(to, tax_amount);
        }
         return true;
     
    }
  
    }
