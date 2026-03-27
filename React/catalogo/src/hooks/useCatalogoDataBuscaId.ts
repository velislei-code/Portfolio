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

import { useQuery } from "@tanstack/react-query";
import axios, { type AxiosPromise } from "axios";
import { CatalogoData } from '../interface/CatalogoData';

const API_URL = 'http://localhost:8080/api';

const fetchById = async (id: number): AxiosPromise<CatalogoData> => {
    return axios.get(`${API_URL}/catalogo/${id}`);
}

export function useCatalogoDataBuscaId(id: number | null) {
    const query = useQuery({
        queryFn: () => fetchById(id!),
        queryKey: ['api-catalogo', id],
        enabled: id !== null,
        retry: 1
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
