package com.rd2r3.api.controller;

import com.rd2r3.api.ApiApplication;
import com.rd2r3.api.DTO.CatalogoRequestDTO;
import com.rd2r3.api.DTO.CatalogoResponseDTO;
import com.rd2r3.api.entity.CatalogoEntity;
import com.rd2r3.api.repository.CatalogoRepository;
import com.rd2r3.api.service.CatalogoService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/catalogo")     // http://localhost:8080/api/catalogo
public class CatalogoController {

    @Autowired
    private final ApiApplication objApiApplication;
    
    @Autowired
    private CatalogoRepository objRepository;

    @Autowired
    private final CatalogoService objCatalogoService; // Instancia o objeto
 
   
    CatalogoController(ApiApplication valObjApiApplication) {
        this.objApiApplication = valObjApiApplication;
        this.objCatalogoService = null;   // Inicializa(Constructor)
    }

    // SALVAR 
    //@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")     // Libera os Headers que vem de uma porta específica, correto qdo em produção - + seguro
    @CrossOrigin(origins = "*", allowedHeaders = "*")     // Libera todos os Headers(Como nossa app é local liberamos tudo)  
    @PostMapping    // Mapeia os Post que vem do navegador
                    // Em RequestBody dado que chega do navegador 
    public void saveCatalogo(@RequestBody CatalogoRequestDTO dados){   
        CatalogoEntity CatalogoDados = new CatalogoEntity(dados);   // Aqui fazemos uma converção inversa(Recebe Mux, fazemos um Demux nos Dados)
        objCatalogoService.salvarCatalogo(CatalogoDados);           // Via metodo em Service
        // DIRETO -> objRepository.save(CatalogoDados);
        return;
    }  

    // DELETAR Via Service   
    @CrossOrigin(origins = "*", allowedHeaders = "*")     
    @GetMapping("/del/{numId}")         // @DeleteMapping -> Não funciona
    public ResponseEntity<Void>  deletarPorId(@PathVariable Long numId) {
        // Verificar se existe
        Optional<CatalogoEntity> catalogo = objCatalogoService.buscarPorId(numId);
        
        if (catalogo.isPresent()) {
            // Deletar
            objCatalogoService.deletarCatalogo(numId);            
            // Retornar 204 No Content
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }


    @CrossOrigin(origins = "*", allowedHeaders = "*")
    @GetMapping   
    public List<CatalogoResponseDTO> getAll(){
        // Esse CatalogoResponseDTO será somente uma RecordcardapioApplication
        // Não criamos uma classe pq não vamos usar nenhum metodo 
        // Nova funcionalidade Java só para representar os dados(estáticos)        
        
        // Aqui o Repositorio esta retornando uma entidade do Tipo: Catalogo
        // Então precisamos tranforma-lo para DTO, usando 
        // .stream().map(CatalogoResponseDTO::new).toList()
        // stream pega todos os dados(Demux para Mux) e afunila, multiplexa
        // Depois mapeamos cada dado para o DTO
        
                // Direto por aqui...
                //      List<CatalogoResponseDTO> CatalogoList = objRepository.findAll().stream().map(CatalogoResponseDTO::new).toList();
                //      return CatalogoList;

        // Via Service
        return objCatalogoService.listarCatalogos(); 
    }
    
    @CrossOrigin(origins = "*", allowedHeaders = "*")
    @GetMapping("/{numId}")
    public ResponseEntity<CatalogoResponseDTO> buscarPorId(@PathVariable Long numId) {
        Optional<CatalogoEntity> catalogo = objCatalogoService.buscarPorId(numId);

        if (catalogo.isPresent()) {
            CatalogoResponseDTO dto = new CatalogoResponseDTO(catalogo.get());
            return ResponseEntity.ok(dto);
        }

        return ResponseEntity.notFound().build();
    }

    // ATUALIZAR Via Service
    @CrossOrigin(origins = "*", allowedHeaders = "*")
    @PutMapping("/{numId}")
    public ResponseEntity<CatalogoResponseDTO> atualizarPorId(@PathVariable Long numId, @RequestBody CatalogoRequestDTO dados) {
        Optional<CatalogoEntity> catalogo = objCatalogoService.buscarPorId(numId);

        if (catalogo.isPresent()) {
            CatalogoEntity atualizado = objCatalogoService.atualizarCatalogo(numId, dados);
            return ResponseEntity.ok(new CatalogoResponseDTO(atualizado));
        }

        return ResponseEntity.notFound().build();
    }

}
/*  Testar
    - No PostgreSQL, cria novo BD = Catalogos
    - Aqui, na Extenção Thender Client
    [POST][http://localhost:8080/api/catalogo]
    Body
        {
            "empresa": "user_12",
            "imagem": "https://31b93296e4855c6e.cdn.gocache.net/loja/imagens/full/abafador-escapamento-esportivo-luzian-lp1153.png",
            "produto": "Bloco",
            "ticket": "1234567",
            "tipo": "Aluminio",
            "valor": 455.97
        }
    <SEND>
    consultar tudo: [http://localhost:8080/api/catalogo]
    consultar id: [http://localhost:8080/api/catalogo/3]
    deletar id: [http://localhost:8080/api/catalogo/del/5]
*/
