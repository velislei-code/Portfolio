/*
 * by: Treuk, Velislei A
 *   email: velislei@gmail.com
 *   Copyright(c) 2016-2018
 *   Sistemas de testes de portas ADSL em Massa 
 *   Projeto, excecução p/ Oi S/A
 *   All Rights Reserveds       
 */

import java.awt.Component;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

 public class RenderAlinhaTexto extends DefaultTableCellRenderer {  
  
    public RenderAlinhaTexto() {  
        super();  
    }  
  
    public Component getTableCellRendererComponent(JTable table, Object value,  
            boolean isSelected, boolean hasFocus, int row, int column) {  
        this.setHorizontalAlignment(CENTER);  
  
        return super.getTableCellRendererComponent(table, value, isSelected,  
                hasFocus, row, column);  
    }  
}  