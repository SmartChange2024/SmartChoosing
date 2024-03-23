// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // versão do compilador

contract Voting { // cria o contrato Votação
    struct Candidate { // cria um struct de candidato -> cada candidato tem um nome e um número de votos acumulados
        string name;
        uint256 voteCount;
    }

    Candidate[] public candidates; // cria uma matriz pública em que cada elemento vai ser uma instância do struct candidatos
    address owner; // define o endereço do proprietário do contrato
    mapping(address => bool) public voters; // cria um mapping relacionando address e um valor booleano para definir quem vota

    uint256 public votingStart; // início da votação
    uint256 public votingEnd; // fim da votação

// constructor é chamado uma vez assim que o contrato roda e define o estado inicial
constructor(string[] memory _candidateNames, uint256 _durationInMinutes) { // cria variáveis locais -> 1 matriz chamada candidateNames em que todos os dados são strings e ficam guardados na memória temporária do constructor / -> número definido como duração em minutos da votação
    for (uint256 i = 0; i < _candidateNames.length; i++) {
        candidates.push(Candidate({ // cria um objeto Candidates e inicializa todos os candidatos com seus nomes e total de votos = 0
            name: _candidateNames[i],
            voteCount: 0
        }));
    }
    owner = msg.sender; // quem criou o contrato (pega e guarda o endereço da carteira) é o proprietário do contrato
    votingStart = block.timestamp; // tempo de início da votação
    votingEnd = block.timestamp + (_durationInMinutes * 1 minutes); // tempo de término da votação
}

    modifier onlyOwner { // apenas o proprietário do contrato poderá utilizar e chamar certas funções
        require(msg.sender == owner); // é necessário que a pessoa que chamar a função seja o owner
        _;
    }

    function addCandidate(string memory _name) public onlyOwner { // apenas o owner consegue adicionar candidatos, mas todos podem ver
        candidates.push(Candidate({ // adiciona candidato com nome e quantidade de votos na matriz
                name: _name,
                voteCount: 0
        }));
    }

    function vote(uint256 _candidateIndex) public { // todos podem votar
        require(!voters[msg.sender], "You have already voted."); // verifica se já votou ou não
        require(_candidateIndex < candidates.length, "Invalid candidate index."); // verifica se o n° do candidato existe ou não

        candidates[_candidateIndex].voteCount++; // aumenta em 1 o n° de votos do candidato
        voters[msg.sender] = true; // afirma que o votante já votou
    }

    function getAllVotesOfCandiates() public view returns (Candidate[] memory){ // retorna os dados de nome e quantidade de votos de cada candidato registrado
        return candidates;
    }

    function getVotingStatus() public view returns (bool) { // retorna se a votação acabou ou não
        return (block.timestamp >= votingStart && block.timestamp < votingEnd);
    }

    function getRemainingTime() public view returns (uint256) { 
        require(block.timestamp >= votingStart, "Voting has not started yet."); // é necessário que o timer esteja maior ou igual ao tempo de início -> caso contrário, roda a mensagem de erro
        if (block.timestamp >= votingEnd) { // se o timer estiver maior que o tempo de término, retorna 0 e a votação acabou
            return 0;
    }
        return votingEnd - block.timestamp; // retorna o tempo restante de votação
    }
}