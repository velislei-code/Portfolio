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
import { useEffect, useState } from 'react';
import { useCatalogoDataMutation } from '../../hooks/useCatalogoDataMutation';
import { useCatalogoDataAtualizar } from '../../hooks/useCatalogoDataAtualizar';
import { CatalogoData } from '../../interface/CatalogoData';
import "./modal.css";


 // useState é um Hook do React(Será assistida, monitorada pelo React - pra auto-atualizar em runtime no site HTML)
// * São funções auxiliares que o React fornece para fazer manipulação de estado na Dom
//      Basicamente ele retorna um array onde:
//      1° valor deste array tem o valor que vai ficar salvo
//      2° valor deste array tem a função de atualização
//      Eh um Hook que cria uma variavel, que PRECISA ser atualizada pela função setTitle, setImage, setPrice
//      Pq? Toda vez que estes variáveis setTitle, setImage, setPrice for chamada o React sabe que o valor delas mudou
//      assim o React re-renderiza meu componente, atualiza o HTML, para mostrar na tela


interface InputProps {
    label: string;
    value: string | number;
    updateValue(value: any): void; // Esta função recebe(any) qualquer valor(Str, int, float) e retorna vazio
}

interface ModalProps {
    closeModal(): void;
}

interface EditModalProps {
    item: CatalogoData;
    closeModal(): void;
}


// Esta função será chamada toda vez que o usuario digitar algo
// Note que no onChange={event vem todos os eventos feitos pelo usuario
// então...em updateValue(event.target.value), pegamos somente o valor que mudou
const Input = ({ label, value, updateValue }: InputProps) => {
    return (
        <>
            <label>{label}</label>
            <input value={value} onChange={event => updateValue(event.target.value)} />
        </>
    );
};

export function CreateModal({ closeModal }: ModalProps) {
    // Aqui declaramos os estados que vão salvar os valores
    // useState é um Hook do React(Será assistida, monitorada pelo React - pra auto-atualizar em runtime no site HTML)
    // * São funções auxiliares que o React fornece para fazer manipulação de estado na Dom
    //      Basicamente ele retorna um array onde:
    //      1° valor deste array tem o valor que vai ficar salvo
    //      2° valor deste array tem a função de atualização
    //      Eh um Hook que cria uma variavel, que PRECISA ser atualizada pela função setTitle, setImage, setPrice
    //      Pq? Toda vez que estes variáveis setTitle, setImage, setPrice for chamada o React sabe que o valor delas mudou
    //      assim o React re-renderiza meu componente, atualiza o HTML, para mostrar na tela

    const [ticket, setTicket] = useState("");
    const [empresa, setEmpresa] = useState("");
    const [produto, setProduto] = useState("");
    const [imagem, setImagem] = useState("");
    const [tipo, setTipo] = useState("");
    const [valor, setValor] = useState(0);


    // {mutate, } Função que faz o submit dos dados(chama o POST para enviar os Dados)
    // isSucess - retorno do ReactQuery toda vez que o Post(Inserir novo registro deu OK!) foi concluído com sucesso
    // isLoading - enquanto estiver carregando...
    const { mutate, isSuccess, isPending } = useCatalogoDataMutation();

    // Qdo clickar no BtnEnviar, chama este submit
    /*      <button onClick={submit} className="btn-secondary">
                {isLoading ? 'postando...' : 'postar'}
            </button>
    */
    const submit = () => {
        const catalogoData: CatalogoData = { ticket, empresa, produto, imagem, tipo, valor };
        mutate(catalogoData);
    };

    // Este Hook, monitora valor de isSucess, e fecha o Modal qdo tiver Sucesso
    // useEffect: Funcao utilitaria do React(gera um efeito colateral de acordo com o array de dependências)
    // * efeito colateral: toda vez que o valor da array(passada:isSucess) muda, ele chama a função
    useEffect(() => {
        if (!isSuccess) return;
        closeModal();
    }, [isSuccess]);

    return (
         // modal-overlay: Fundo desfocado - video 2 22m
        <div className="modal-overlay">
            <div className="modal-body">
                <h2>Cadastrar produto</h2>
                <form className="input-container">
                    <Input label="ticket" value={ticket} updateValue={setTicket} />
                    <Input label="empresa" value={empresa} updateValue={setEmpresa} />
                    <Input label="produto" value={produto} updateValue={setProduto} />
                    <Input label="imagem(link)" value={imagem} updateValue={setImagem} />
                    <Input label="tipo" value={tipo} updateValue={setTipo} />
                    <Input label="valor" value={valor} updateValue={setValor} />
                </form>
                <button onClick={submit} className="btn-secondary">
                    {isPending ? 'postando...' : 'postar'}
                </button>
            </div>
        </div>
    );
}

export function EditModal({ item, closeModal }: EditModalProps) {
    const [ticket, setTicket] = useState(item.ticket);
    const [empresa, setEmpresa] = useState(item.empresa);
    const [produto, setProduto] = useState(item.produto);
    const [imagem, setImagem] = useState(item.imagem);
    const [tipo, setTipo] = useState(item.tipo);
    const [valor, setValor] = useState(item.valor);

    const { mutate, isSuccess, isPending } = useCatalogoDataAtualizar();

    const submit = () => {
        const catalogoData: CatalogoData = { ticket, empresa, produto, imagem, tipo, valor };
        mutate({ id: item.id!, data: catalogoData });
    };

    useEffect(() => {
        if (!isSuccess) return;
        closeModal();
    }, [isSuccess]);

    return (
        <div className="modal-overlay">
            <div className="modal-body">
                <h2>Editar produto #{item.id}</h2>
                <form className="input-container">
                    <Input label="ticket" value={ticket} updateValue={setTicket} />
                    <Input label="empresa" value={empresa} updateValue={setEmpresa} />
                    <Input label="produto" value={produto} updateValue={setProduto} />
                    <Input label="imagem(link)" value={imagem} updateValue={setImagem} />
                    <Input label="tipo" value={tipo} updateValue={setTipo} />
                    <Input label="valor" value={valor} updateValue={setValor} />
                </form>
                <button onClick={submit} className="btn-secondary">
                    {isPending ? 'salvando...' : 'salvar'}
                </button>
            </div>
        </div>
    );
}
