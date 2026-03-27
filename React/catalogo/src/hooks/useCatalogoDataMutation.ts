
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
import { useMutation, useQueryClient } from "@tanstack/react-query";

//  npm install axios
// Axios é uma biblioteca cliente HTTP para fazer requisições a APIs (backend) a partir do React. É uma alternativa mais poderosa e fácil ao fetch nativo do JavaScript.
import axios, { AxiosPromise } from "axios";    

import { CatalogoData } from '../interface/CatalogoData';

const API_URL = 'http://localhost:8080/api';

const postData = async (data: CatalogoData): AxiosPromise<any> => {
    const response = axios.post(API_URL + '/catalogo', data);  // Faz um Post e envia o Dado(endpoint: /catalogo)
    return response;
}

// Função que vai mandar os dados para o BackEnd(POST)
// Este: queryClient, é o privider, definido em main.tsx, engloba toda a aplicação(onde faz um Post ou GET via ReactQuery),
// ele vai fazer via este queryClient
// 
export function useCatalogoDataMutation(){
    const queryClient = useQueryClient();
    const mutation = useMutation({
        mutationFn: postData,
        retry: 2,
        onSuccess: () => {  // Qdo retornar Sucess...exec.queryCliente...
            // queryClient.invalidateQueries(['api-data']) // Versao 4 do React
            queryClient.invalidateQueries({ queryKey: ['api-catalogo'] })  // Versão 5 do React
            // aqui queryClient esta invalidando os GETs feitos com a chave: catalogo-data 
            // Pq? Desta forma estou informando que esta chave esta desatualizada, já foi usada, e deve ser atualizada
            // Sempre que user fizer um POST, deve Invalidar(O antigo ja esta desatualizado, Renove) e atualizar
        }
    })

    return mutation;
}