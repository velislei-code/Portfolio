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

import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './index.css'

// Para evitar o erro: Navegador->// Inspecionar-> ERRO! Uncaght Error: No QueryClient set, use QueryClientProvider to set
//      (Veja Biblioteca React-Query)
// Precisamos fazer a configs abaixo: 
//      const queryClient = new QueryClient();
//      <QueryClientProvider client={queryClient}></QueryClientProvider>
const queryClient = new QueryClient();

// Pega DIV(root) no HTML(Index.html) e injeta dentro do React
ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <App />  
    </QueryClientProvider>
  </React.StrictMode>,
)
