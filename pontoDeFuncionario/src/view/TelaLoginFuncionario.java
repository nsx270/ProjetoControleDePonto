package pontodefuncionario.view;

import pontodefuncionario.controller.FuncionarioController;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * Tela de login para funcionários
 */
public class TelaLoginFuncionario extends JFrame {
    
    private JTextField txtRegistro;
    private JPasswordField txtSenha;
    private JButton btnEntrar;
    private JButton btnVoltar;
    private FuncionarioController controller;
    
    public TelaLoginFuncionario() {
        controller = new FuncionarioController();
        iniciarComponentes();
        configurarTela();
    }
    
    private void iniciarComponentes() {
        setTitle("Login de Funcionário");
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setResizable(false);
        
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());
        
        JLabel titulo = new JLabel("Login de Funcionário", JLabel.CENTER);
        titulo.setFont(new Font("Arial", Font.BOLD, 20));
        titulo.setBorder(BorderFactory.createEmptyBorder(20, 0, 20, 0));
        
        JPanel formPanel = new JPanel();
        formPanel.setLayout(new GridLayout(3, 2, 10, 15));
        formPanel.setBorder(BorderFactory.createEmptyBorder(10, 40, 10, 40));
        
        JLabel lblRegistro = new JLabel("Registro:");
        lblRegistro.setFont(new Font("Arial", Font.PLAIN, 14));
        
        txtRegistro = new JTextField();
        txtRegistro.setFont(new Font("Arial", Font.PLAIN, 14));
        
        JLabel lblSenha = new JLabel("Senha (CPF):");
        lblSenha.setFont(new Font("Arial", Font.PLAIN, 14));
        
        txtSenha = new JPasswordField();
        txtSenha.setFont(new Font("Arial", Font.PLAIN, 14));
        
        formPanel.add(lblRegistro);
        formPanel.add(txtRegistro);
        formPanel.add(lblSenha);
        formPanel.add(txtSenha);
        
        JPanel botoesPainel = new JPanel();
        botoesPainel.setLayout(new FlowLayout(FlowLayout.CENTER, 20, 20));
        
        btnEntrar = new JButton("Entrar");
        btnEntrar.setFont(new Font("Arial", Font.PLAIN, 14));
        btnEntrar.setPreferredSize(new Dimension(100, 35));
        
        btnVoltar = new JButton("Voltar");
        btnVoltar.setFont(new Font("Arial", Font.PLAIN, 14));
        btnVoltar.setPreferredSize(new Dimension(100, 35));
        
        botoesPainel.add(btnEntrar);
        botoesPainel.add(btnVoltar);
        
        panel.add(titulo, BorderLayout.NORTH);
        panel.add(formPanel, BorderLayout.CENTER);
        panel.add(botoesPainel, BorderLayout.SOUTH);
        
        add(panel);
    }
    
    private void configurarTela() {
        btnEntrar.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                realizarLogin();
            }
        });
        
        btnVoltar.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                voltarTelaPrincipal();
            }
        });
    }
    
    private void realizarLogin() {
        try {
            String registro = txtRegistro.getText();
            String senha = new String(txtSenha.getPassword());
            
            if (registro.isEmpty() || senha.isEmpty()) {
                JOptionPane.showMessageDialog(this, "Por favor, preencha todos os campos", "Erro de Login", JOptionPane.ERROR_MESSAGE);
                return;
            }
            
            boolean loginValido = controller.autenticarFuncionario(registro, senha);
            
            if (loginValido) {
                // Funcionário autenticado com sucesso
                this.dispose();
                TelaFuncionario telaFuncionario = new TelaFuncionario(controller.obterFuncionario(registro));
                telaFuncionario.setVisible(true);
            } else {
                JOptionPane.showMessageDialog(this, "Registro ou senha inválidos", "Erro de Login", JOptionPane.ERROR_MESSAGE);
            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Erro ao realizar login: " + ex.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
            ex.printStackTrace();
        }
    }
    
    private void voltarTelaPrincipal() {
        this.dispose();
        TelaPrincipal telaPrincipal = new TelaPrincipal();
        telaPrincipal.setVisible(true);
    }
}