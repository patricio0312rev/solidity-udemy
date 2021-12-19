// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 < 0.8.10;
pragma experimental ABIEncoderV2;

// -------------------------
// ALUMNO |   ID   | NOTA
// -------------------------
// Marcos | 77755N |  5
// Joan   | 12345X |  9
// Marcia | 02468T |  2
// Marta  | 13579U  |  3
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
    event alumno_evaluado(bytes32, uint);
    event evento_revision(string);

    // Funcion para evaluar a los alumnos
    function Evaluar(string memory _idAlumno, uint _nota) public UnicamenteProfesor(msg.sender) {
        // Hash de la identificacion del alumno
        bytes32 hash_idAlumno = keccak256(abi.encodePacked(_idAlumno));

        // Relacion entre el hash de la identificacion del alumno y su nota
        Notas[hash_idAlumno] = _nota;

        // Emision del evento
        emit alumno_evaluado(hash_idAlumno, _nota);
    }

    modifier UnicamenteProfesor(address _direccion){
        // Requiere de la direccion introducida por parametro sea igual al owner del contrato
        require(_direccion == profesor, "No tienes permiso para ejecutar esta funcion.");
        _;
    }
    
    // Funcion para ver las notas de un alumno
    function VerNotas(string memory _idAlumno) public returns(uint){
        // Hash de la identificacion del alumno
        bytes32 hash_idAlumno = keccak256(abi.encodePacked(_idAlumno));

        // Nota asociada al hash del alumno
        uint nota_alumno = Notas[hash_idAlumno];

        // Visualizar la nota del alumno
        return nota_alumno;
    }

    // Funcion para pedir una revision del examen
    function Revision(string memory _idAlumno) public {
        // Almacenamiento de la identidad del alumno en un array
        revisiones.push(_idAlumno);

        // Emision del evento
        emit evento_revision(_idAlumno);
    }
}