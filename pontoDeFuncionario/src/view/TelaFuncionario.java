package pontodefuncionario.view;

import pontodefuncionario.controller.FuncionarioController;
import pontodefuncionario.controller.RelatorioController;
import pontodefuncionario.model.Funcionario;
import pontodefuncionario.model.RegistroPonto;
import pontodefuncionario.model.Relatorio;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Tela principal para o funcionário registrar ponto e visualizar informações
 */
public class TelaFuncionario extends JFrame {

    private Funcionario funcionario;
    private FuncionarioController controller;
    
    private JLabel lblNome;
    private JLabel lblCpf;
    private JLabel lblCargo;
    private JLabel lblData;
    private JLabel lblHoraAtual;
    private JLabel lblStatusPonto;
    private JLabel lblHorasTrabalhadas;
    private JLabel lblBancoHoras;
    private JLabel lblTempoAlmoco;
    
    private JButton btnBaterPonto;
    private JButton btnSair;
    
    private Timer timer;
    private SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm:ss");
    private SimpleDateFormat formatoData = new SimpleDateFormat("dd/MM/yyyy");
    
    /**
     * Construtor da tela do funcionário
     */
    public TelaFuncionario(Funcionario funcionario) {
        this.funcionario = funcionario;
        this.controller = new FuncionarioController();
        
        iniciarComponentes();
        configurarTela();
        iniciarTimer();
        atualizarStatusPonto();
    }
    
    /**
     * Inicializa os componentes da interface
     */
    private void iniciarComponentes() {
        setTitle("Sistema de Ponto - Funcionário");
        setSize(600, 500);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setResizable(false);
        
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());
        
        // Painel de informações do funcionário
        JPanel infoPainel = new JPanel();
        infoPainel.setLayout(new GridLayout(7, 2, 10, 10));
        infoPainel.setBorder(BorderFactory.createTitledBorder("Informações do Funcionário"));
        
        infoPainel.add(new JLabel("Nome:"));
        lblNome = new JLabel(funcionario.getNome());
        infoPainel.add(lblNome);
        
        infoPainel.add(new JLabel("CPF:"));
        lblCpf = new JLabel(funcionario.getCpf());
        infoPainel.add(lblCpf);
        
        infoPainel.add(new JLabel("Cargo:"));
        lblCargo = new JLabel(funcionario.getCargo());
        infoPainel.add(lblCargo);
        
        infoPainel.add(new JLabel("Carga Horária:"));
        JLabel lblCargaHoraria = new JLabel(Relatorio.formatarHorasMinutos(funcionario.getCargaHoraria()));
        infoPainel.add(lblCargaHoraria);
        
        infoPainel.add(new JLabel("Data Atual:"));
        lblData = new JLabel(formatoData.format(new Date()));
        infoPainel.add(lblData);
        
        infoPainel.add(new JLabel("Hora Atual:"));
        lblHoraAtual = new JLabel(formatoHora.format(new Date()));
        infoPainel.add(lblHoraAtual);
        
        infoPainel.add(new JLabel("Tempo de Almoço:"));
        lblTempoAlmoco = new JLabel("00:00");
        lblTempoAlmoco.setFont(new Font("Arial", Font.BOLD, 12));
        infoPainel.add(lblTempoAlmoco);
        
        // Painel de status de ponto
        JPanel pontoPainel = new JPanel();
        pontoPainel.setLayout(new GridLayout(3, 1));
        pontoPainel.setBorder(BorderFactory.createTitledBorder("Registro de Ponto"));
        
        JPanel statusPainel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        statusPainel.add(new JLabel("Status:"));
        lblStatusPonto = new JLabel("Aguardando registro de ponto");
        lblStatusPonto.setFont(new Font("Arial", Font.BOLD, 14));
        statusPainel.add(lblStatusPonto);
        
        JPanel horasPainel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        horasPainel.add(new JLabel("Horas Trabalhadas Hoje:"));
        lblHorasTrabalhadas = new JLabel("00:00:00");
        lblHorasTrabalhadas.setFont(new Font("Arial", Font.BOLD, 16));
        horasPainel.add(lblHorasTrabalhadas);
        
        JPanel bancoHorasPainel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        bancoHorasPainel.add(new JLabel("Banco de Horas:"));
        lblBancoHoras = new JLabel("00:00");
        lblBancoHoras.setFont(new Font("Arial", Font.BOLD, 16));
        bancoHorasPainel.add(lblBancoHoras);
        
        pontoPainel.add(statusPainel);
        pontoPainel.add(horasPainel);
        pontoPainel.add(bancoHorasPainel);
        
        // Painel de botões
        JPanel botoesPainel = new JPanel();
        botoesPainel.setLayout(new FlowLayout(FlowLayout.CENTER, 20, 20));
        
        btnBaterPonto = new JButton("Bater Ponto");
        btnBaterPonto.setFont(new Font("Arial", Font.BOLD, 14));
        btnBaterPonto.setPreferredSize(new Dimension(150, 40));
        
        btnSair = new JButton("Sair");
        btnSair.setFont(new Font("Arial", Font.PLAIN, 14));
        btnSair.setPreferredSize(new Dimension(100, 40));
        
        botoesPainel.add(btnBaterPonto);
        botoesPainel.add(btnSair);
        
        // Adicionando os painéis ao painel principal
        panel.add(infoPainel, BorderLayout.NORTH);
        panel.add(pontoPainel, BorderLayout.CENTER);
        panel.add(botoesPainel, BorderLayout.SOUTH);
        
        add(panel);
    }
    
    /**
     * Configura os eventos dos botões
     */
    private void configurarTela() {
        btnBaterPonto.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                registrarPonto();
            }
        });
        
        btnSair.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                encerrarSessao();
            }
        });
    }
    
    /**
     * Inicia o timer para atualizar o relógio e as horas trabalhadas
     */
    private void iniciarTimer() {
        timer = new Timer();
        timer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                SwingUtilities.invokeLater(new Runnable() {
                    @Override
                    public void run() {
                        Date agora = new Date();
                        lblHoraAtual.setText(formatoHora.format(agora));
                        lblData.setText(formatoData.format(agora));
                        atualizarHorasTrabalhadas();
                        atualizarBancoHoras();
                        atualizarTempoAlmoco();
                        atualizarStatusPonto();
                    }
                });
            }
        }, 0, 1000); // Atualiza a cada segundo
    }
    
    /**
     * Registra um evento de ponto
     */
    private void registrarPonto() {
        Date agora = new Date();
        boolean registroSucesso = controller.baterPonto(funcionario.getRegistro());
        
        if (registroSucesso) {
            JOptionPane.showMessageDialog(this, "Ponto registrado com sucesso às " + formatoHora.format(agora), 
                "Registro de Ponto", JOptionPane.INFORMATION_MESSAGE);
            atualizarStatusPonto();
            atualizarTempoAlmoco();
        } else {
            JOptionPane.showMessageDialog(this, "Não foi possível registrar o ponto. Verifique se você já não registrou este evento.", 
                "Erro", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    /**
     * Atualiza o status do ponto na interface
     */
    private void atualizarStatusPonto() {
        RegistroPonto registroAtual = controller.obterRegistroAtual(funcionario.getRegistro());
        
        if (registroAtual == null) {
            lblStatusPonto.setText("Aguardando registro de ponto");
            btnBaterPonto.setEnabled(true);
            btnBaterPonto.setText("Registrar Entrada");
        } else {
            // Verifica qual o próximo evento esperado
            if (registroAtual.getHoraEntrada() != null && registroAtual.getHoraSaidaAlmoco() == null) {
                lblStatusPonto.setText("Trabalhando - Aguardando saída para almoço");
                btnBaterPonto.setText("Registrar Saída Almoço");
            } else if (registroAtual.getHoraSaidaAlmoco() != null && registroAtual.getHoraRetornoAlmoco() == null) {
                lblStatusPonto.setText("Em almoço - Aguardando retorno");
                btnBaterPonto.setText("Registrar Retorno Almoço");
            } else if (registroAtual.getHoraRetornoAlmoco() != null && registroAtual.getHoraSaida() == null) {
                // Verifica se já cumpriu a carga horária para determinar o status
                boolean cargaHorariaCumprida = controller.verificarCargaHoraria(funcionario.getRegistro());
                if (cargaHorariaCumprida) {
                    double horasTrabalhadasAtuais = controller.calcularHorasTrabalhadas(funcionario.getRegistro());
                    double horasExtrasAtuais = horasTrabalhadasAtuais - funcionario.getCargaHoraria();
                    
                    if (horasExtrasAtuais > 0) {
                        lblStatusPonto.setText("Realizando hora extra - " + Relatorio.formatarHorasMinutos(horasExtrasAtuais));
                    } else {
                        lblStatusPonto.setText("Carga horária cumprida - Pode finalizar");
                    }
                } else {
                    lblStatusPonto.setText("Trabalhando - Aguardando saída");
                }
                
                btnBaterPonto.setText("Registrar Saída");
            } else if (registroAtual.getHoraSaida() != null) {
                lblStatusPonto.setText("Expediente finalizado");
                btnBaterPonto.setEnabled(false);
            }
        }
    }
    
    /**
     * Atualiza as horas trabalhadas na interface
     */
    private void atualizarHorasTrabalhadas() {
        double horasTrabalhadas = controller.calcularHorasTrabalhadas(funcionario.getRegistro());
        
        // Formata as horas trabalhadas com horas, minutos e segundos
        lblHorasTrabalhadas.setText(formatarHorasComSegundos(horasTrabalhadas));
    }
    
    /**
     * Atualiza o banco de horas na interface
     */
    private void atualizarBancoHoras() {
        double bancoHoras = controller.obterBancoHoras(funcionario.getRegistro());
        
        // Define a cor: verde para positivo, vermelho para negativo
        if (bancoHoras >= 0) {
            lblBancoHoras.setForeground(new Color(0, 128, 0)); // Verde
        } else {
            lblBancoHoras.setForeground(Color.RED);
        }
        
        // Formata e exibe o banco de horas
        lblBancoHoras.setText(formatarBancoHoras(bancoHoras));
    }
    
    /**
     * Atualiza o tempo de almoço na interface
     */
    private void atualizarTempoAlmoco() {
        RegistroPonto registroAtual = controller.obterRegistroAtual(funcionario.getRegistro());
        
        if (registroAtual != null) {
            if (registroAtual.getHoraSaidaAlmoco() != null) {
                // Se já saiu para almoço
                if (registroAtual.getHoraRetornoAlmoco() != null) {
                    // Se já retornou do almoço, calcula o tempo fixo
                    double tempoAlmoco = RegistroPonto.calcularDiferencaHoras(
                        registroAtual.getHoraSaidaAlmoco(), registroAtual.getHoraRetornoAlmoco());
                    
                    // Formata o tempo de almoço
                    lblTempoAlmoco.setText(Relatorio.formatarHorasMinutosCompacto(tempoAlmoco) + 
                        " (" + formatoHora.format(registroAtual.getHoraSaidaAlmoco()) + " - " + 
                        formatoHora.format(registroAtual.getHoraRetornoAlmoco()) + ")");
                } else {
                    // Se ainda está em almoço, calcula em tempo real
                    Date agora = new Date();
                    double tempoAlmoco = RegistroPonto.calcularDiferencaHoras(
                        registroAtual.getHoraSaidaAlmoco(), agora);
                    
                    // Formata o tempo de almoço atual
                    lblTempoAlmoco.setText(Relatorio.formatarHorasMinutosCompacto(tempoAlmoco) + 
                        " (em andamento)");
                }
            } else {
                // Se ainda não saiu para almoço
                lblTempoAlmoco.setText("Aguardando saída para almoço");
            }
        } else {
            // Se não há registro hoje
            lblTempoAlmoco.setText("Sem registro");
        }
    }
    
    /**
     * Formata uma quantidade de horas para exibição com segundos (HH:MM:SS)
     */
    private String formatarHorasComSegundos(double horas) {
        boolean negativo = horas < 0;
        double horasAbs = Math.abs(horas);
        
        int horasInteiras = (int) horasAbs;
        int minutos = (int) ((horasAbs - horasInteiras) * 60);
        int segundos = (int) Math.round(((horasAbs - horasInteiras) * 60 - minutos) * 60);
        
        // Ajuste para caso os segundos arredondem para 60
        if (segundos == 60) {
            segundos = 0;
            minutos++;
            
            // Ajuste para caso os minutos virem 60
            if (minutos == 60) {
                minutos = 0;
                horasInteiras++;
            }
        }
        
        return (negativo ? "-" : "") + String.format("%02d:%02d:%02d", horasInteiras, minutos, segundos);
    }
    
    /**
     * Formata o banco de horas para exibição
     */
    private String formatarBancoHoras(double horas) {
        String sinal = horas >= 0 ? "+" : "";
        return sinal + Relatorio.formatarHorasMinutosCompacto(horas);
    }
    
    /**
     * Finaliza a sessão e volta para a tela principal
     */
    private void encerrarSessao() {
        // Verifica se o ponto do dia foi finalizado
        RegistroPonto registroAtual = controller.obterRegistroAtual(funcionario.getRegistro());
        
        if (registroAtual != null && registroAtual.getHoraSaida() == null) {
            int opcao = JOptionPane.showConfirmDialog(
                this,
                "Você ainda não finalizou o ponto do dia. Deseja registrar a saída agora?",
                "Finalizar Ponto",
                JOptionPane.YES_NO_CANCEL_OPTION
            );
            
            if (opcao == JOptionPane.YES_OPTION) {
                if (controller.baterPonto(funcionario.getRegistro())) {
                    JOptionPane.showMessageDialog(this, "Ponto finalizado com sucesso!", "Saída", JOptionPane.INFORMATION_MESSAGE);
                }
            } else if (opcao == JOptionPane.CANCEL_OPTION) {
                return; // Cancela o encerramento da sessão
            }
        }
        
        if (timer != null) {
            timer.cancel();
        }
        this.dispose();
        TelaPrincipal telaPrincipal = new TelaPrincipal();
        telaPrincipal.setVisible(true);
    }
}