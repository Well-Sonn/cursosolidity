//0xc57E3F58cA5355b388FeDB591ffDEE9AdA002123 - contract

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "contracts/exercicio_dev_token.sol";

contract TokenLiabity {

    struct Client {

        address clientAddress; 
        uint256 tokenBalance;  
    }

    mapping(address => Client) public clients; 

    ExercicioToken public tokenContract; 

    constructor() {
        tokenContract = ExercicioToken(0x89A2E711b2246B586E51f579676BE2381441A0d0);
    }

    
    function MeuSaldo() public view returns (uint256) {
        address clientAddress = msg.sender;
        return tokenContract.balanceOf(clientAddress);
    }

    
    function TokenParaEuCliente(uint256 amount) public returns (bool) {
        address clientAddress = msg.sender;
        require(clientAddress != address(0), "Endereco de cliente invalido");
        require(amount > 0, "O valor de transferencia deve ser maior que 0");
        
        
        require(tokenContract.mint(clientAddress, amount), "Erro: Nao e possivel criar novos saldos");
        
        clients[clientAddress].tokenBalance += amount;
    }

    function MeuEndereco() public view returns (address) {
        return address(this);
    }
}
