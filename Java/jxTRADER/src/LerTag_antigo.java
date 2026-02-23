/*
 * by: Treuk, Velislei A
 *   email: velislei@gmail.com
 *   Copyright(c) 2016-2018
 *   Sistemas de testes de portas ADSL em Massa 
 *   Projeto, excecução p/ Oi S/A
 *   All Rights Reserveds       
 */
 
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
//package testelertag;

/**
 *
 * @Sever Soiuz
 */

import java.io.*;
import java.net.URL;


public class LerTag_antigo {
	
    public void LerTag(String sURL, String sNomeArq) throws IOException {  
        
        
      /*
       * Lê codigo fonte da pagina e salva em arquivo 
       */
        
        File fCodFte = new File(sNomeArq);
        URL url = new URL(sURL);
        

        BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
        BufferedWriter out = new BufferedWriter(new FileWriter(fCodFte));
        String inputLine;
        while ((inputLine = in.readLine()) != null)
        {
            // Imprime página no console
           // System.out.println(inputLine);
            // Grava pagina no arquivo
            out.write(inputLine);
            out.newLine();
        }
        in.close();
        out.flush();
        out.close();
        
        /* Separador */
      //  System.out.println("=========================================================================");  
        
        /* NÃO DÁ TEMPO DE LER, OU OUTRO PROBLEMA */
        
        File fLerTag = new File(sNomeArq);  
  
        FileReader reader = new FileReader(fLerTag);  
  
        BufferedReader leitor = new BufferedReader(reader);  
  
        String linha = "";  
  
        while ((linha = leitor.readLine()) != null) {  
            if (linha.contains("<div") && linha.contains("</div>")) {  
                linha = linha.replaceAll("<div", "");  
                linha = linha.replaceAll("</div>", "");  
             //   System.out.println(linha);  
  
            }  
        }
    }  
}  