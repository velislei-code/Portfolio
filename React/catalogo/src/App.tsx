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

import { useState } from 'react';
import './App.css';
import { Card } from './components/cards/Card';
import { CatalogoData } from './interface/CatalogoData';
import { useCatalogoData } from './hooks/useCatalogoData';
import { useCatalogoDataBuscaId } from './hooks/useCatalogoDataBuscaId';
import { useCatalogoDataDelete } from './hooks/useCatalogoDataDelete';
import { CreateModal, EditModal } from './components/modal/Modal';


// React Hooks são funções especiais introduzidas no React 16.8 que permitem usar o estado e outras funcionalidades, 
// como ciclo de vida, em componentes funcionais, sem precisar escrever componentes de classe

// Normalmente este App.tsx é usado para colocar o Router da App
// Onde vai ter todas as rotas de nossa aplicação
// Aqui não é o caso, vamos cria-las td aqui dentro
function App() {  
  // aqui é a representação dos dados que vem da nossa apiSpring
  // Isto esta atrelado, tem os dados convertido em: interface/foodData{vars}
  const { data } = useCatalogoData();

  // Ctrl EStado do Modal(Open, Oculto), aberto e escondido
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false);
  const [editItem, setEditItem] = useState<CatalogoData | null>(null);
  const [searchInput, setSearchInput] = useState('');
  const [searchedId, setSearchedId] = useState<number | null>(null);

  const { data: searchResult, isError: searchError } = useCatalogoDataBuscaId(searchedId);
  const { mutate: deleteItem } = useCatalogoDataDelete();

  const handleSearch = () => {
    const id = parseInt(searchInput);
    if (!isNaN(id) && id > 0) setSearchedId(id);
  };

  const handleClearSearch = () => {
    setSearchInput('');
    setSearchedId(null);
  };

  const handleEdit = (item: CatalogoData) => {
    setEditItem(item);
  };

  const handleDelete = (id: number) => {
    if (window.confirm(`Deletar item #${id}?`)) {
      deleteItem(id);
      if (searchedId === id) handleClearSearch();
    }
  };

  const displayData = searchedId !== null
    ? (searchResult ? [searchResult] : [])
    : (data ?? []);

  return (
    // De: App, P/: Container(é o que fica + por fora, contem td dentro 
    // data?.map para pegar cada 1 dos objetos que estão dentro deste data
    //           => retornar Card p/ cada 1 desses data que estiver dentro da nossa array
    // Este Card é o que vai mostrado na Tela, então precisamos passar os dados a serem mostrados    
    // [?] indica um Undefined, os dados podem Ou não serem retornados pela Api backEnd

    <div className="container">
      <h1>Catálogo</h1>

      <div className="search-bar">
        <input
          type="number"
          min="1"
          placeholder="Buscar por ID..."
          value={searchInput}
          onChange={e => setSearchInput(e.target.value)}
          onKeyDown={e => e.key === 'Enter' && handleSearch()}
        />
        <button className="btn-search" onClick={handleSearch}>Buscar</button>
        {searchedId !== null && (
          <button className="btn-clear" onClick={handleClearSearch}>Limpar</button>
        )}
      </div>

      {searchedId !== null && searchError && (
        <p className="not-found">ID {searchedId} não encontrado.</p>
      )}

      <div className="card-grid">
        {displayData.map(item =>
          <Card
            key={item.id}
            {...item}
            onEdit={() => handleEdit(item)}
            onDelete={() => handleDelete(item.id!)}
          />
        )}
      </div>

      {isCreateModalOpen && (
        <CreateModal closeModal={() => setIsCreateModalOpen(false)} />
      )}

      {editItem && (
        <EditModal item={editItem} closeModal={() => setEditItem(null)} />
      )}

      <button onClick={() => setIsCreateModalOpen(true)}>novo</button>
    </div>
  );
}

export default App;
