// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaGuyana
 * @dev Registro historico con Likes, Dislikes e Identificador de Cassareep (Base de Mandioca).
 * Nota: Codigo ASCII puro para evitar errores de compilacion y visualizacion.
 */
contract GastronomiaGuyana {

    struct Plato {
        string nombre;
        string descripcion;
        string tipoCassareep; // Ej: Artesanal, Comercial, Concentrado
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con el Pepperpot Guyanes
        registrarPlato(
            "Pepperpot", 
            "Guiso de carne cocinado en una salsa negra de cassareep, canela y ajies.",
            "Artesanal"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _tipoCassareep
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            tipoCassareep: _tipoCassareep,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory tipoCassareep,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.tipoCassareep, p.likes, p.dislikes);
    }
}
