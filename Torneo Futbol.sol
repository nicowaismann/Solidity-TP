// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract TorneoFutbol {

        string _equipo;
        uint private _puntos;
        string[] equipos;
        mapping (string => uint256) puntajes_por_equipo;
        mapping (string => string[]) jugadores_del_equipo;


    function AniadirEquipo(string memory nombreEquipos_)public{
        equipos.push(nombreEquipos_);

    }

    function AniadirJugadores (string memory nombreJugador_, string memory equipo_) public{
        jugadores_del_equipo[equipo_].push(nombreJugador_);
    }

    function borrarJugadores(string memory nombreJugador_, string memory equipo_) public{
        for(uint i = 0;i<=jugadores_del_equipo[equipo_].length;i++){
            if (keccak256(bytes(nombreJugador_)) == keccak256(bytes(jugadores_del_equipo[equipo_][i]))){
                 delete jugadores_del_equipo[equipo_][i];
            }
        }
    }


    function RegistrarPartido (string memory primer_equipo, string memory segundo_equipo, uint goles_primer_equipo, uint goles_segundo_equipo) public
    {

        if(goles_primer_equipo>goles_segundo_equipo){
            puntajes_por_equipo[primer_equipo] +=3;
        }

        if(goles_segundo_equipo>goles_primer_equipo){
            puntajes_por_equipo[segundo_equipo] +=3;
        }

        if(goles_segundo_equipo==goles_primer_equipo){
            puntajes_por_equipo[primer_equipo] +=1;
            puntajes_por_equipo[segundo_equipo] +=1;
        }

    }

     function getPuntos_Equipo(string memory equipo_ingresado_) public view returns (uint) {
       return puntajes_por_equipo[equipo_ingresado_];
    }


    function getLista_Jugadores(string memory equipo_) public view returns (string[] memory) {
        
        string[] memory jugadores_equipo = new string[](jugadores_del_equipo[equipo_].length);
            
        for(uint i=0; i < jugadores_del_equipo[equipo_].length; i++) 
        {
            jugadores_equipo[i] = jugadores_del_equipo[equipo_][i];
        }
        return jugadores_equipo;
    }



     function Puntero()public view returns(string memory){

        uint max = puntajes_por_equipo[equipos[0]]; 
        string memory max_equipo = equipos[0];

        for(uint i=0; i<=equipos.length; i++){
            if(puntajes_por_equipo[equipos[i]] > max){
                max=puntajes_por_equipo[equipos[i]];
                max_equipo=equipos[i];
            }
         }
         return max_equipo;
     }
}