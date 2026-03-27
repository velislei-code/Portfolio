package com.rd2r3.api.entity;
 
import com.rd2r3.api.DTO.CatalogoRequestDTO;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Table(name = "rdtickets")      // Nome da Tabela PostgreSQL, MySQL
@Entity(name = "tickets")       // path /tickets
@Getter             // Lombok: gera getters para todas as variáveis
@Setter             // Lombok: gera setters para todas as variáveis (necessário para atualização)
@NoArgsConstructor  // Lombok: declara um Constructor que NÃO recebe nenhum argumento
@AllArgsConstructor // Lombok: declara um Constructor que recebe todos OS argumentoS
@EqualsAndHashCode(of = "id")  // Indica que esse ID é uma chave unica da Food
public class CatalogoEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)  // id auto-increment
    private Long id;
    private String ticket;
    private String empresa;
    private String produto;
    private String imagem;
    private String tipo;
    private Double valor;

    // Neste Constructor, recebemos os dados(Navegador) via RequestDTO
    // e atribuimos as nossas variaveis
    public CatalogoEntity(CatalogoRequestDTO objCatalogoRequestDTO){ // objCatalogoRequestDTO = recordsDTO
        this.ticket = objCatalogoRequestDTO.ticket();
        this.empresa = objCatalogoRequestDTO.empresa();
        this.produto = objCatalogoRequestDTO.produto();
        this.imagem = objCatalogoRequestDTO.imagem();
        this.tipo = objCatalogoRequestDTO.tipo();
        this.valor = objCatalogoRequestDTO.valor();
    }
}
