package pontodefuncionario.view;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * Tela principal do sistema que permite escolher entre modos Funcionário e Administrador
 */
public class TelaPrincipal extends JFrame {
    
    private JButton btnFuncionario;
    private JButton btnAdministrador;
    
    public TelaPrincipal() {
        iniciarComponentes();
        configurarTela();
    }
    
    private void iniciarComponentes() {
        setTitle("Sistema de Controle de Ponto");
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setResizable(false);
        
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());
        
        JLabel titulo = new JLabel("Sistema de Controle de Ponto", JLabel.CENTER);
        titulo.setFont(new Font("Arial", Font.BOLD, 20));
        titulo.setBorder(BorderFactory.createEmptyBorder(20, 0, 30, 0));
        
        JPanel botoesPanel = new JPanel();
        botoesPanel.setLayout(new GridLayout(2, 1, 0, 20));
        botoesPanel.setBorder(BorderFactory.createEmptyBorder(20, 50, 20, 50));
        
        btnFuncionario = new JButton("Funcionário");
        btnFuncionario.setFont(new Font("Arial", Font.PLAIN, 16));
        btnFuncionario.setPreferredSize(new Dimension(150, 60));
        
        btnAdministrador = new JButton("Administrador");
        btnAdministrador.setFont(new Font("Arial", Font.PLAIN, 16));
        btnAdministrador.setPreferredSize(new Dimension(150, 60));
        
        botoesPanel.add(btnFuncionario);
        botoesPanel.add(btnAdministrador);
        
        panel.add(titulo, BorderLayout.NORTH);
        panel.add(botoesPanel, BorderLayout.CENTER);
        
        add(panel);
    }
    
    private void configurarTela() {
        btnFuncionario.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                abrirTelaLoginFuncionario();
            }
        });
        
        btnAdministrador.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                abrirTelaLoginAdministrador();
            }
        });
    }
    
    private void abrirTelaLoginFuncionario() {
        this.dispose();
        TelaLoginFuncionario telaLogin = new TelaLoginFuncionario();
        telaLogin.setVisible(true);
    }
    
    private void abrirTelaLoginAdministrador() {
        this.dispose();
        TelaLoginAdministrador telaLogin = new TelaLoginAdministrador();
        telaLogin.setVisible(true);
    }
}