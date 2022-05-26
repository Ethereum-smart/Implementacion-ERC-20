// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Consultar el numero de tokens disponibles a partir de los decimales
// 100000 * ( 10 ** decimals() ) / ( 10 ** decimals() )

contract MyToken is ERC20 {

  constructor( string memory name, string memory symbol ) ERC20(name, symbol) {

    // Emitir Token
    _mint(msg.sender, 100000 * ( 10 ** decimals() ) );

  }

  // Cambiar el numero de decimales del token sobreescribiendo el metodo de ERC20
  function decimals() public pure override returns (uint8) {
    return 6;
  }

}