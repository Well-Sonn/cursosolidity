// SPDX-License-Identifier: CC-BY-4.0
// (c) Desenvolvido por Matheus Ricardo Tomas
// This work is licensed under a Creative Commons Attribution 4.0 International License.

pragma solidity 0.8.19;

import "https://github.com/jeffprestes/cursosolidity/blob/master/bradesco_token_aberto.sol";

contract liability {
    ExercicioToken private exercicioToken;

    struct Cliente {
        string primeiroNome;
        string sobreNome;
        address payable endereco;
        bytes32 hashConta;
        bool existe;
    }

    Cliente private cliente;
     mapping(address => uint256) private tokenBalances;


    constructor(
        string memory _primeiroNome,
        string memory _sobreNome,
        string memory _agencia,
        string memory _conta
    ) {
        exercicioToken = ExercicioToken(0x89A2E711b2246B586E51f579676BE2381441A0d0);

        string memory strTemp = string(abi.encodePacked(_agencia, _conta));
        bytes32 hashTemp = keccak256(abi.encodePacked(strTemp));

        cliente = Cliente(_primeiroNome, _sobreNome, payable(msg.sender), hashTemp, true);

        gerarTokenParaEuCliente(10000); 
    }

    function meuSaldo() public view returns (uint256) {
        return exercicioToken.balanceOf(address(this));
    }

    function gerarTokenParaEuCliente(uint256 _amount) public returns (bool) {
        return exercicioToken.mint(address(this), _amount);
    }

    function transfereToken(address _enderecoDestino, uint256 _amount) public returns (bool){
        return exercicioToken.transfer(_enderecoDestino, _amount);
    }


}
