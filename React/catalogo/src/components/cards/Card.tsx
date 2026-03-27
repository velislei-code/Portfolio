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
import "./card.css";
import { CatalogoData } from '../../interface/CatalogoData';

// Props para passar os valores para nossa HTML/Cards
interface CardProps extends CatalogoData {
    onEdit(): void;
    onDelete(): void;
}

export function Card({ id, ticket, empresa, produto, imagem, tipo, valor, onEdit, onDelete }: CardProps) {
    return (
        <div className="card">
            <img src={imagem} alt={produto} />
            <div className="card-body">
                <h3>#{id}</h3>
                <h2>{produto}, {tipo}</h2>
                <p><b>Empresa: </b>{empresa}</p>
                <p><b>PN: </b>{ticket}</p>
                <p><b>Valor: </b>R$ {valor}</p>
                <div className="card-actions">
                    <button className="btn-edit" onClick={onEdit}>Editar</button>
                    <button className="btn-delete" onClick={onDelete}>Deletar</button>
                </div>
            </div>
        </div>
    );
}
