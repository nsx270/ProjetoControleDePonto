package pontodefuncionario;

import pontodefuncionario.view.TelaPrincipal;
import javax.swing.*;

/**
 * Classe principal para iniciar o sistema de controle de ponto
 */
public class SistemaPonto {
    
    public static void main(String[] args) {
        // Configura o look and feel do sistema
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Inicia a aplicação na thread de eventos do Swing
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                // Cria e exibe a tela principal
                TelaPrincipal telaPrincipal = new TelaPrincipal();
                telaPrincipal.setVisible(true);
            }
        });
    }
}