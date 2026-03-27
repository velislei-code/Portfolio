/* React + TypeScript + Vite
 * by: Treuk, Velislei A
 * email: velislei@gmail.com
 * whats: +55(42)9 8404-0687
 * github.com/velislei-code/Portfolio/
 * linkedin.com/in/velislei-adilson-treuk-75131323/
 * Copyright(c) Treuk, Velislei A. mar2026
 * catálogo de peças - App Frontend
 * Simples projeto de demonstração de conexão Backend Api javaSpring com Frontend em React, vite, typeScript
 *  All Rights Reserveds       
 */

// npm install @tanstack/react-query
// npm install @tanstack/react-query @tanstack/react-query-devtools
import { useQuery } from "@tanstack/react-query";

//  npm install axios
// Axios é uma biblioteca cliente HTTP para fazer requisições a APIs (backend) a partir do React. É uma alternativa mais poderosa e fácil ao fetch nativo do JavaScript.
import axios, { type AxiosPromise } from "axios";
import { CatalogoData } from '../interface/CatalogoData';

// Lembre de Pegar os dados do backEnd(via API) - instalamos um Library
// Terminal> npm install tanstack-query/react-query

// Para disparar requisições Http, instale:
// Terminal> npm install axios


const API_URL = 'http://localhost:8080/api'; // end-point: /catalogo
// Promise <tipo: axiosResponse< /interface/catalogoData[] >>
// /interface/catalogoData[] -> objetos(array de obj) que são retornados do BackEnd
// Axios vai pegar todos os headers, o que veio no body(obj-data) vai colocar dentro da response
//  fetchData: busca dados de uma API (backend)
const fetchData = async (): AxiosPromise<CatalogoData[]> => {   
    const response = axios.get(API_URL + '/catalogo'); // Aqui só declaramos a URL pq nosso backEnd não recebe nada(post, TX), só Get(RX)
    return response;  // Retorna os dados pegos do backEnd
}

export function useCatalogoData(){
    // Declaração das query ao BackEnd
    const query = useQuery({
        queryFn: fetchData,
        queryKey: ['api-catalogo'],
        retry: 2
    })

    // Como o React.query rotorna os dados E Axion tb retorna, fica repetido data.data
    // Poderiamos fazer(?)
    //      dataRct: query.data   
    //      dataAxi: query.data   
    //      data: dataRct + dataAxi 
    // [?] indica um Undefined, os dados podem Ou não serem retornados pela Api backEnd  
    return {
        ...query,
        data: query.data?.data   
    }
}
