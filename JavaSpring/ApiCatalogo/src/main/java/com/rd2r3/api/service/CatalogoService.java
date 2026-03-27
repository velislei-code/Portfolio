package com.rd2r3.api.service;

import java.util.List;
import java.util.Optional;

import com.rd2r3.api.DTO.CatalogoRequestDTO;

// import org.springframework.data.repository.ListCrudRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;

import com.rd2r3.api.DTO.CatalogoResponseDTO;
// Rever, tem erros -> import com.rd2r3.api.exceptions.RecursoNaoEncontradoException;
import com.rd2r3.api.entity.CatalogoEntity;
import com.rd2r3.api.repository.CatalogoRepository;

@Service     // Por ser um serviço, precisa informar aqui
public class CatalogoService {

    private final CatalogoRepository objCatalogoRepository;
    
    public CatalogoService(CatalogoRepository valCatalogoRepository){
        this.objCatalogoRepository = valCatalogoRepository;
    }

    /* 
     * Aqui Criamos metodos para manipular registros da tabela Catalogos, que:
     * Note que esses metodos(List, Optional, Save, Delete(não existe em model.Class.Catalogo, 
     * mas herdou de Spring Jpa em repository.CatalogoRepository)
     */
    
     /* --------------------------------------------------------------------------------------------------------------------- 
     * Esse metodo funciona mas não é uma boa pratica...  
        public List<CatalogoEntity> listarCatalogos_old(){
            return objCatalogoRepository.findAll();
        }
                 public List<Catalogo> getAll(){
                    List<Catalogo> CatalogoList = objRepository.findAll();
                    return CatalogoList;
                }
     * Usamos(abaixo) via DTO - Data Trafers Object para usar nas respostas e nos Request da App
     */
    @CrossOrigin(origins = "*", allowedHeaders = "*")
    @GetMapping  
    public List<CatalogoResponseDTO> listarCatalogos(){
        // Esse CatalogoResponseDTO será somente uma RecordcardapioApplication
        // Não criamos uma classe pq não vamos usar nenhum metodo 
        // Nova funcionalidade Java só para representar os dados(estáticos)        
        
        // Aqui o Repositorio esta retornando uma entidade do Tipo: Catalogo
        // Então precisamos tranforma-lo para DTO, usando 
        // .stream().map(CatalogoResponseDTO::new).toList()
        // stream pega todos os dados(Demux para Mux) e afunila, multiplexa
        // Depois mapeamos cada dado para o DTO
        List<CatalogoResponseDTO> lstCatalogo = objCatalogoRepository.findAll().stream().map(CatalogoResponseDTO::new).toList();
        return lstCatalogo;
    }
    /* --------------------------------------------------------------------------------------------------------------------- */


    // Criamos um Optional, pq pode ser que em List nao retorne nenhum registro
    //sem tratar com exception -> Usamos Optional 
    public Optional<CatalogoEntity> buscarPorId(Long valId){
        return objCatalogoRepository.findById(valId);
    } 

    // Salvar
    public CatalogoEntity salvarCatalogo(CatalogoEntity valCatalogoEntity){
        return objCatalogoRepository.save(valCatalogoEntity);
    }

    // Deletar um registro pelo Id
    public void deletarCatalogo(Long valId){
        objCatalogoRepository.deleteById(valId);
    }

    // Atualizar um registro pelo Id
    public CatalogoEntity atualizarCatalogo(Long valId, CatalogoRequestDTO valDTO) {
        CatalogoEntity entity = objCatalogoRepository.findById(valId)
            .orElseThrow(() -> new RuntimeException("ID " + valId + " não encontrado."));
        entity.setTicket(valDTO.ticket());
        entity.setEmpresa(valDTO.empresa());
        entity.setProduto(valDTO.produto());
        entity.setImagem(valDTO.imagem());
        entity.setTipo(valDTO.tipo());
        entity.setValor(valDTO.valor());
        return objCatalogoRepository.save(entity);
    }

    /*  
    // Com Exceptions, não podemos usar um Optional -> pois trataremos de exceções
    public Catalogo buscarPorId(Long valId){
        // Com Exceptions
        return objCatalogoRepository.findById(valId).orElseThrow(
                    ()->new RecursoNaoEncontradoException("Catalogo: "+valId+" não localizado.")
                );
    }  

    // Rever, esta com falha
    // Deletar um registro pelo Id - Com tratamento de exceçao
    public void deletarCatalogo(Long valId){
        if(!objCatalogoRepository.existsById(valId)){            
            throw new RecursoNaoEncontradoException("ID: "+valId+" nao localizado.");
        }else{  objCatalogoRepository.deleteById(valId); }        
    } */

    
}

