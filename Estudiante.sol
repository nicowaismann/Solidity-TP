// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract notasEstudiante {

    
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping (string => uint) private notas_materia;
    string[] private _materias;

   
    constructor(string memory nombre_, string memory apellido_, string memory curso_) {
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }

  
    function getApellido() public view returns (string memory) {
        return _apellido;
    }

    function getNombre() public view returns(string memory) {
        return _nombre;
    }


   function nombre_completo() public view returns (string memory) {
        string memory nomFinal = getNombre();
        string memory apellidoFinal = getApellido();
        string memory nombreCompleto = string.concat(nomFinal, " ", apellidoFinal);
        return nombreCompleto;
    }


    
    function curso() public view returns (string memory) {
        return _curso;
    }

    
    function set_notamateria(string memory materia, uint nota_) public {
       require(msg.sender == _docente, "Solo el docente registrado puede asignar notas");

        if(notas_materia[materia] == 0)
        {
           _materias.push(materia); 
        }

        notas_materia[materia] = nota_;
    }

    function nota_materia (string memory _materia) public view returns (uint) {
        return notas_materia[_materia];
    }
    
      function aprobo(string memory materia) public view returns (bool) {
        uint nota = notas_materia[materia];
        if(nota < 60) {
            return false;
        } else if (nota > 60 && nota < 100) {
            return true;
        }
        return false;
    }

    function promedio() public view returns(uint)
    {
        uint promedio_ = 0;
        uint i;
        for(i = 0; i < _materias.length; i++)
        {
            promedio_ += notas_materia[_materias[i]];
        }

        promedio_ /= _materias.length;
        return promedio_;
    }
}