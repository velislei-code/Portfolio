package com.rd2r3.api.DTO;

import com.rd2r3.api.entity.CatalogoEntity;

// Esse CatalogoResponseDTO será somente uma Record  
// Não criamos uma classe pq não vamos usar nenhum metodo 
// Nova funcionalidade Java só para representar os dados(estáticos)        
public record CatalogoResponseDTO(Long id, String ticket, String empresa, String produto, String imagem, String tipo, Double valor) {
    // Constructor vai receber a Entidade Food e vai declarar os atributos dentro de nosso Record
    // e, para pegar esses atributos precisamos do Lombok  
    // Apesar de não criarmos os metodos set/get o Lombok cria em RunTime
    // Então, podemos chama-las: (food.getId(), getTitle, etc)
    public CatalogoResponseDTO(CatalogoEntity objCatalogo){
        this(objCatalogo.getId(), objCatalogo.getTicket(), objCatalogo.getEmpresa(), objCatalogo.getProduto(),  objCatalogo.getImagem(), objCatalogo.getTipo(), objCatalogo.getValor());
    }
}
