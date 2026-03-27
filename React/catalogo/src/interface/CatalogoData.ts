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

// objetos que são retornados do BackEnd
export interface CatalogoData {
    id?: number,  // (?): torna envio de dados ID(do BackEnd), opcional, pode ser vazio tb
    ticket: string,
    empresa: string,
    produto: string,
    imagem: string,
    tipo: string,
    valor: number   
}