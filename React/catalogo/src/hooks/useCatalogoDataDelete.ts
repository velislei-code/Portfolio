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

import { useMutation, useQueryClient } from "@tanstack/react-query";
import axios, { AxiosPromise } from "axios";

const API_URL = 'http://localhost:8080/api';

const deleteData = async (id: number): AxiosPromise<void> => {
    return axios.get(`${API_URL}/catalogo/del/${id}`);
}

// Função que vai mandar os dados para o BackEnd(POST)
// Este: queryClient, é o privider, definido em main.tsx, engloba toda a aplicação(onde faz um Post ou GET via ReactQuery),
// ele vai fazer via este queryClient 
export function useCatalogoDataDelete() {
    const queryClient = useQueryClient();
    return useMutation({
        mutationFn: deleteData,
        retry: 2,
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ['api-catalogo'] });   // api-catalogo Chave para acesso a api
        }
    });
}
