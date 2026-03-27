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
import { CatalogoData } from '../interface/CatalogoData';

const API_URL = 'http://localhost:8080/api';  // Endereço de conexao com minha api(javaSpring)

// Esta função faz uma requisição HTTP PUT para o endpoint /catalogo/{id}
// com os dados fornecidos no corpo da requisição.
const putData = async ({ id, data }: { id: number; data: CatalogoData }): AxiosPromise<CatalogoData> => {
    // Realiza a requisição PUT com axios
    // O método PUT substitui completamente o recurso no endpoint 
    return axios.put(`${API_URL}/catalogo/${id}`, data);
}


 /*Este hook encapsula a lógica de mutação (atualização) de itens do catálogo,
 * utilizando React Query para:
 * - Gerenciamento automático de estados (loading, error, success)
 * - Retentativas automáticas em caso de falha
 * - Invalidação automática do cache após sucesso
 * - Sincronização com dados existentes no cache
 * 
 * const { mutate, isLoading, error } = useCatalogoDataAtualizar();
 * 
 * // Para atualizar um item:
 * mutate({ id: 1, data: { nome: "Novo nome" } })
 */
// Metodo para atualizar registro pelo ID
export function useCatalogoDataAtualizar() {
    const queryClient = useQueryClient();
    return useMutation({
        mutationFn: putData,
        retry: 2,
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ['api-catalogo'] });
        }
    });
}
