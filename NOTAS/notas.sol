// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 < 0.8.10;
pragma experimental ABIEncoderV2;

// -------------------------
// ALUMNO |   ID   | NOTA
// -------------------------
// Marcos | 77755N |  5
// Joan   | 12345X |  9
// Marcia | 02468T |  2
// Marta  | 1357U  |  3
// Alba   | 98765Z |  5

contract notas {

    // Direccion del profesor
    address public profesor;

    // Constructor 
    constructor() public {
        profesor = msg.sender;
    }

    // Mapping para relacionar el hash de la identidad del alumno
    mapping(bytes32 => uint) Notas;

    // Array de los alumnos que pidan revisiones de examenes
    string[] revisiones;

    // Eventos
    event alumno_evaluado(bytes32);
    event evento_revision(string);

    // Funcion para evaluar a los alumnos
    function Evaluar(string memory _idAlumno, uint _nota) public UnicamenteProfesor(msg.sender) {
        // Hash de la identificacion del alumno
        bytes32 hash_idAlumno = keccak256(_idAlumno);

        // Relacion entre el hash de la identificacion del alumno y su nota
        Notas[hash_idAlumno] = _nota;

        // Emision del evento
        emit alumno_evaluado(hash_idAlumno);
    }
    
}