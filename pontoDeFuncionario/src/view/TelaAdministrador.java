package pontodefuncionario.view;

import pontodefuncionario.controller.AdministradorController;
import pontodefuncionario.controller.FuncionarioController;
import pontodefuncionario.controller.RelatorioController;
import pontodefuncionario.model.Funcionario;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Tela para administração do sistema - Gerenciar funcionários e relatórios
 */
public class TelaAdministrador extends JFrame {
    
    private AdministradorController adminController;
    private FuncionarioController funcionarioController;
    private RelatorioController relatorioController;
    
    private JTabbedPane tabbedPane;
    private JPanel painelCadastro;
    private JPanel painelRemover;
    private JPanel painelEditar;
    private JPanel painelRelatorio;
    
    private JButton btnSair;
    
    // Componentes do painel de cadastro
    private JTextField txtNome;
    private JTextField txtCPF;
    private JTextField txtCargo;
    private JTextField txtCargaHoraria;
    private JTextField txtRegistro;
    
    // Componentes do painel de relatório
    private JComboBox<String> cmbFuncionarios;
    private JTextArea txtResultado;
    private JTextField txtDataInicial;
    private JTextField txtDataFinal;
    
    // Variáveis para o painel de funcionários reservados
    private JTable tabelaReservados;
    private JButton btnReativar;
    private JButton btnAtualizar;
    
    public TelaAdministrador() {
        this.adminController = new AdministradorController();
        this.funcionarioController = new FuncionarioController();
        this.relatorioController = new RelatorioController(); 
        
        iniciarComponentes();
        configurarTela();
    }
    
    private void iniciarComponentes() {
        setTitle("Sistema de Ponto - Administrador");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        
        // Painel principal
        JPanel painelPrincipal = new JPanel(new BorderLayout());
        
        // Título
        JLabel lblTitulo = new JLabel("Painel do Administrador", JLabel.CENTER);
        lblTitulo.setFont(new Font("Arial", Font.BOLD, 20));
        lblTitulo.setBorder(BorderFactory.createEmptyBorder(20, 0, 20, 0));
        
        // Abas
        tabbedPane = new JTabbedPane();
        
        // Inicializa os painéis
        painelCadastro = criarPainelCadastro();
        painelRemover = criarPainelRemover();
        painelEditar = criarPainelEditar();
        painelRelatorio = criarPainelRelatorio();
        JPanel painelReserva = criarPainelFuncionariosReservados();
        
        // Adiciona as abas
        tabbedPane.addTab("Cadastrar Funcionário", painelCadastro);
        tabbedPane.addTab("Remover Funcionário", painelRemover);
        tabbedPane.addTab("Editar Funcionário", painelEditar);
        tabbedPane.addTab("Gerar Relatório", painelRelatorio);
        tabbedPane.addTab("Funcionários Reservados", painelReserva);
        
        // Adiciona um listener para atualizar a lista de funcionários quando mudar de aba
        tabbedPane.addChangeListener(e -> {
            int selectedIndex = tabbedPane.getSelectedIndex();
            if (selectedIndex == 3) { // Aba de relatório
                atualizarListaFuncionarios();
            } else if (selectedIndex == 4) { // Aba de funcionários reservados
                atualizarTabelaFuncionariosReservados();
            }
        });
        
        // Painel de botões
        JPanel painelBotoes = new JPanel(new FlowLayout(FlowLayout.RIGHT));
        btnSair = new JButton("Sair");
        painelBotoes.add(btnSair);
        
        // Adiciona componentes ao painel principal
        painelPrincipal.add(lblTitulo, BorderLayout.NORTH);
        painelPrincipal.add(tabbedPane, BorderLayout.CENTER);
        painelPrincipal.add(painelBotoes, BorderLayout.SOUTH);
        
        add(painelPrincipal);
    }
    
    private JPanel criarPainelCadastro() {
        JPanel painel = new JPanel();
        painel.setLayout(new BorderLayout());
        painel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        
        // Formulário de cadastro
        JPanel formPanel = new JPanel(new GridLayout(6, 2, 10, 15));
        
        JLabel lblNome = new JLabel("Nome:");
        txtNome = new JTextField();
        
        JLabel lblCPF = new JLabel("CPF:");
        txtCPF = new JTextField();
        
        JLabel lblCargo = new JLabel("Cargo:");
        txtCargo = new JTextField();
        
        JLabel lblCargaHoraria = new JLabel("Carga Horária Diária (horas):");
        txtCargaHoraria = new JTextField();
        
        JLabel lblRegistro = new JLabel("Registro:");
        txtRegistro = new JTextField();
        
        formPanel.add(lblNome);
        formPanel.add(txtNome);
        formPanel.add(lblCPF);
        formPanel.add(txtCPF);
        formPanel.add(lblCargo);
        formPanel.add(txtCargo);
        formPanel.add(lblCargaHoraria);
        formPanel.add(txtCargaHoraria);
        formPanel.add(lblRegistro);
        formPanel.add(txtRegistro);
        
        // Botão de cadastro
        JPanel btnPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        JButton btnCadastrar = new JButton("Cadastrar Funcionário");
        btnCadastrar.setPreferredSize(new Dimension(200, 40));
        btnPanel.add(btnCadastrar);
        
        // Adiciona os componentes ao painel
        painel.add(formPanel, BorderLayout.CENTER);
        painel.add(btnPanel, BorderLayout.SOUTH);
        
        // Configura o botão de cadastro
        btnCadastrar.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                cadastrarFuncionario();
            }
        });
        
        return painel;
    }
    
    /**
     * Método para cadastrar um novo funcionário
     */
    private void cadastrarFuncionario() {
        try {
            String nome = txtNome.getText();
            String cpf = txtCPF.getText();
            String cargo = txtCargo.getText();
            String registro = txtRegistro.getText();
            
            if (nome.isEmpty() || cpf.isEmpty() || cargo.isEmpty() || registro.isEmpty() || txtCargaHoraria.getText().isEmpty()) {
                JOptionPane.showMessageDialog(this, "Todos os campos são obrigatórios", "Erro", JOptionPane.ERROR_MESSAGE);
                return;
            }
            
            double cargaHoraria = Double.parseDouble(txtCargaHoraria.getText());
            
            boolean cadastroSucesso = adminController.cadastrarFuncionario(nome, cpf, cargo, cargaHoraria, registro);
            
            if (cadastroSucesso) {
                JOptionPane.showMessageDialog(this, "Funcionário cadastrado com sucesso!", "Cadastro", JOptionPane.INFORMATION_MESSAGE);
                // Limpa os campos
                txtNome.setText("");
                txtCPF.setText("");
                txtCargo.setText("");
                txtCargaHoraria.setText("");
                txtRegistro.setText("");
                
                // Atualiza a lista de funcionários no relatório
                atualizarListaFuncionarios();
            } else {
                JOptionPane.showMessageDialog(this, "Erro ao cadastrar funcionário. CPF ou Registro já existente.", "Erro", JOptionPane.ERROR_MESSAGE);
            }
        } catch (NumberFormatException ex) {
            JOptionPane.showMessageDialog(this, "A carga horária deve ser um número válido", "Erro", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private JPanel criarPainelRemover() {
        JPanel painel = new JPanel();
        painel.setLayout(new BorderLayout());
        painel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        
        // Painel de pesquisa
        JPanel pesquisaPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        
        JLabel lblBusca = new JLabel("Digite o Registro ou CPF do funcionário:");
        JTextField txtBusca = new JTextField(20);
        JButton btnBuscar = new JButton("Buscar");
        
        pesquisaPanel.add(lblBusca);
        pesquisaPanel.add(txtBusca);
        pesquisaPanel.add(btnBuscar);
        
        // Painel de resultados
        JPanel resultadoPanel = new JPanel(new BorderLayout());
        resultadoPanel.setBorder(BorderFactory.createTitledBorder("Informações do Funcionário"));
        
        // Campos de informação
        JPanel infoPanel = new JPanel(new GridLayout(5, 2, 10, 10));
        
        JLabel lblNome = new JLabel("Nome:");
        JLabel lblNomeValor = new JLabel("");
        
        JLabel lblCPF = new JLabel("CPF:");
        JLabel lblCPFValor = new JLabel("");
        
        JLabel lblCargo = new JLabel("Cargo:");
        JLabel lblCargoValor = new JLabel("");
        
        JLabel lblCargaHoraria = new JLabel("Carga Horária:");
        JLabel lblCargaHorariaValor = new JLabel("");
        
        JLabel lblRegistro = new JLabel("Registro:");
        JLabel lblRegistroValor = new JLabel("");
        
        infoPanel.add(lblNome);
        infoPanel.add(lblNomeValor);
        infoPanel.add(lblCPF);
        infoPanel.add(lblCPFValor);
        infoPanel.add(lblCargo);
        infoPanel.add(lblCargoValor);
        infoPanel.add(lblCargaHoraria);
        infoPanel.add(lblCargaHorariaValor);
        infoPanel.add(lblRegistro);
        infoPanel.add(lblRegistroValor);
        
        // Botão de remoção
        JPanel btnPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        JButton btnRemover = new JButton("Remover Funcionário");
        btnRemover.setPreferredSize(new Dimension(200, 40));
        btnRemover.setEnabled(false); // Desabilitado inicialmente
        btnPanel.add(btnRemover);
        
        resultadoPanel.add(infoPanel, BorderLayout.CENTER);
        resultadoPanel.add(btnPanel, BorderLayout.SOUTH);
        
        // Adiciona os componentes ao painel principal
        painel.add(pesquisaPanel, BorderLayout.NORTH);
        painel.add(resultadoPanel, BorderLayout.CENTER);
        
        // Configura o botão de busca
        btnBuscar.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String busca = txtBusca.getText();
                
                if (busca.isEmpty()) {
                    JOptionPane.showMessageDialog(painel, "Digite um registro ou CPF para buscar", "Erro", JOptionPane.ERROR_MESSAGE);
                    return;
                }
                
                // Busca o funcionário
                Object[] funcionarioInfo = funcionarioController.buscarFuncionarioPorRegistroOuCPF(busca);
                
                if (funcionarioInfo != null) {
                    // Preenche os campos com as informações do funcionário
                    lblNomeValor.setText((String) funcionarioInfo[0]);
                    lblCPFValor.setText((String) funcionarioInfo[1]);
                    lblCargoValor.setText((String) funcionarioInfo[2]);
                    lblCargaHorariaValor.setText(funcionarioInfo[3] + " horas");
                    lblRegistroValor.setText((String) funcionarioInfo[4]);
                    
                    // Habilita o botão de remoção
                    btnRemover.setEnabled(true);
                } else {
                    // Limpa os campos
                    lblNomeValor.setText("");
                    lblCPFValor.setText("");
                    lblCargoValor.setText("");
                    lblCargaHorariaValor.setText("");
                    lblRegistroValor.setText("");
                    
                    // Desabilita o botão de remoção
                    btnRemover.setEnabled(false);
                    
                    JOptionPane.showMessageDialog(painel, "Funcionário não encontrado", "Aviso", JOptionPane.WARNING_MESSAGE);
                }
            }
        });
        
        // Configura o botão de remoção
        btnRemover.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String registro = lblRegistroValor.getText();
                
                // Confirma a remoção
                int opcao = JOptionPane.showConfirmDialog(painel, 
                                                        "Tem certeza que deseja remover o funcionário " + lblNomeValor.getText() + "?",
                                                        "Confirmar Remoção",
                                                        JOptionPane.YES_NO_OPTION);
                
                if (opcao == JOptionPane.YES_OPTION) {
                    boolean removidoSucesso = adminController.removerFuncionario(registro);
                    
                    if (removidoSucesso) {
                        JOptionPane.showMessageDialog(painel, "Funcionário removido com sucesso!", "Remoção", JOptionPane.INFORMATION_MESSAGE);
                        
                        // Limpa os campos
                        lblNomeValor.setText("");
                        lblCPFValor.setText("");
                        lblCargoValor.setText("");
                        lblCargaHorariaValor.setText("");
                        lblRegistroValor.setText("");
                        txtBusca.setText("");
                        
                        // Desabilita o botão de remoção
                        btnRemover.setEnabled(false);
                        
                        // Atualiza a lista de funcionários no relatório
                        atualizarListaFuncionarios();
                        // Atualiza a tabela de funcionários reservados
                        atualizarTabelaFuncionariosReservados();
                    } else {
                        JOptionPane.showMessageDialog(painel, "Erro ao remover funcionário", "Erro", JOptionPane.ERROR_MESSAGE);
                    }
                }
            }
        });
        
        return painel;
    }
    
    private JPanel criarPainelEditar() {
        JPanel painel = new JPanel();
        painel.setLayout(new BorderLayout());
        painel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        
        // Painel de pesquisa
        JPanel pesquisaPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        
        JLabel lblBusca = new JLabel("Digite o Registro ou CPF do funcionário:");
        JTextField txtBusca = new JTextField(20);
        JButton btnBuscar = new JButton("Buscar");
        
        pesquisaPanel.add(lblBusca);
        pesquisaPanel.add(txtBusca);
        pesquisaPanel.add(btnBuscar);
        
        // Painel de edição
        JPanel edicaoPanel = new JPanel(new BorderLayout());
        edicaoPanel.setBorder(BorderFactory.createTitledBorder("Editar Informações"));
        
        // Campos de edição
        JPanel formPanel = new JPanel(new GridLayout(4, 2, 10, 15));
        
        JLabel lblNome = new JLabel("Nome:");
        JTextField txtNomeEdit = new JTextField();
        
        JLabel lblCargo = new JLabel("Cargo:");
        JTextField txtCargoEdit = new JTextField();
        
        JLabel lblCargaHoraria = new JLabel("Carga Horária (horas):");
        JTextField txtCargaHorariaEdit = new JTextField();
        
        JLabel lblRegistro = new JLabel("Registro (não editável):");
        JTextField txtRegistroEdit = new JTextField();
        txtRegistroEdit.setEditable(false);
        
        formPanel.add(lblNome);
        formPanel.add(txtNomeEdit);
        formPanel.add(lblCargo);
        formPanel.add(txtCargoEdit);
        formPanel.add(lblCargaHoraria);
        formPanel.add(txtCargaHorariaEdit);
        formPanel.add(lblRegistro);
        formPanel.add(txtRegistroEdit);
        
        // Botão de edição
        JPanel btnPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        JButton btnSalvar = new JButton("Salvar Alterações");
        btnSalvar.setPreferredSize(new Dimension(200, 40));
        btnSalvar.setEnabled(false); // Desabilitado inicialmente
        btnPanel.add(btnSalvar);
        
        edicaoPanel.add(formPanel, BorderLayout.CENTER);
        edicaoPanel.add(btnPanel, BorderLayout.SOUTH);
        
        // Adiciona os componentes ao painel principal
        painel.add(pesquisaPanel, BorderLayout.NORTH);
        painel.add(edicaoPanel, BorderLayout.CENTER);
        
        // Configura o botão de busca
        btnBuscar.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String busca = txtBusca.getText();
                
                if (busca.isEmpty()) {
                    JOptionPane.showMessageDialog(painel, "Digite um registro ou CPF para buscar", "Erro", JOptionPane.ERROR_MESSAGE);
                    return;
                }
                
                // Busca o funcionário
                Object[] funcionarioInfo = funcionarioController.buscarFuncionarioPorRegistroOuCPF(busca);
                
                if (funcionarioInfo != null) {
                    // Preenche os campos com as informações do funcionário
                    txtNomeEdit.setText((String) funcionarioInfo[0]);
                    txtCargoEdit.setText((String) funcionarioInfo[2]);
                    txtCargaHorariaEdit.setText(funcionarioInfo[3].toString());
                    txtRegistroEdit.setText((String) funcionarioInfo[4]);
                    
                    // Habilita o botão de salvar
                    btnSalvar.setEnabled(true);
                } else {
                    // Limpa os campos
                    txtNomeEdit.setText("");
                    txtCargoEdit.setText("");
                    txtCargaHorariaEdit.setText("");
                    txtRegistroEdit.setText("");
                    
                    // Desabilita o botão de salvar
                    btnSalvar.setEnabled(false);
                    
                    JOptionPane.showMessageDialog(painel, "Funcionário não encontrado", "Aviso", JOptionPane.WARNING_MESSAGE);
                }
            }
        });
        
        // Configura o botão de salvar
        btnSalvar.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    String nome = txtNomeEdit.getText();
                    String cargo = txtCargoEdit.getText();
                    double cargaHoraria = Double.parseDouble(txtCargaHorariaEdit.getText());
                    String registro = txtRegistroEdit.getText();
                    
                    if (nome.isEmpty() || cargo.isEmpty()) {
                        JOptionPane.showMessageDialog(painel, "Nome e cargo são obrigatórios", "Erro", JOptionPane.ERROR_MESSAGE);
                        return;
                    }
                    
                    boolean editadoSucesso = adminController.editarFuncionario(registro, nome, cargo, cargaHoraria);
                    
                    if (editadoSucesso) {
                        JOptionPane.showMessageDialog(painel, "Informações atualizadas com sucesso!", "Edição", JOptionPane.INFORMATION_MESSAGE);
                        
                        // Limpa os campos após salvar com sucesso
                        txtNomeEdit.setText("");
                        txtCargoEdit.setText("");
                        txtCargaHorariaEdit.setText("");
                        txtRegistroEdit.setText("");
                        txtBusca.setText("");
                        
                        // Desabilita o botão de salvar
                        btnSalvar.setEnabled(false);
                        
                        // Atualiza a lista de funcionários no relatório
                        atualizarListaFuncionarios();
                    } else {
                        JOptionPane.showMessageDialog(painel, "Erro ao atualizar informações", "Erro", JOptionPane.ERROR_MESSAGE);
                    }
                } catch (NumberFormatException ex) {
                    JOptionPane.showMessageDialog(painel, "A carga horária deve ser um número válido", "Erro", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
        
        return painel;
    }
    
    private JPanel criarPainelRelatorio() {
        JPanel painel = new JPanel();
        painel.setLayout(new BorderLayout());
        painel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        
        // Painel de filtros
        JPanel filtrosPanel = new JPanel(new GridLayout(3, 2, 10, 15));
        filtrosPanel.setBorder(BorderFactory.createTitledBorder("Filtros do Relatório"));
        
        // Seleção de funcionário
        JLabel lblFuncionario = new JLabel("Funcionário:");
        cmbFuncionarios = new JComboBox<>();
        cmbFuncionarios.addItem("Todos os Funcionários");
        
        // Preenche o combo com os funcionários cadastrados
        atualizarListaFuncionarios();
        
        // Seleção de data inicial
        JLabel lblDataInicial = new JLabel("Data Inicial:");
        txtDataInicial = new JTextField(new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
        
        // Seleção de data final
        JLabel lblDataFinal = new JLabel("Data Final:");
        txtDataFinal = new JTextField(new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
        
        filtrosPanel.add(lblFuncionario);
        filtrosPanel.add(cmbFuncionarios);
        filtrosPanel.add(lblDataInicial);
        filtrosPanel.add(txtDataInicial);
        filtrosPanel.add(lblDataFinal);
        filtrosPanel.add(txtDataFinal);
        
        // Painel de botões
        JPanel botoesPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        JButton btnGerar = new JButton("Gerar Relatório");
        btnGerar.setPreferredSize(new Dimension(150, 40));
        
        // Adiciona botão para gerar relatório de banco de horas
        JButton btnBancoHoras = new JButton("Relatório de Banco de Horas");
        btnBancoHoras.setPreferredSize(new Dimension(200, 40));
        
        botoesPanel.add(btnGerar);
        botoesPanel.add(btnBancoHoras);
        
        // Área de resultado do relatório
        txtResultado = new JTextArea();
        txtResultado.setEditable(false);
        txtResultado.setFont(new Font(Font.MONOSPACED, Font.PLAIN, 12));
        JScrollPane scrollPane = new JScrollPane(txtResultado);
        scrollPane.setBorder(BorderFactory.createTitledBorder("Resultado do Relatório"));
        scrollPane.setPreferredSize(new Dimension(700, 300));
        
        // Adiciona os componentes ao painel principal
        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.add(filtrosPanel, BorderLayout.CENTER);
        topPanel.add(botoesPanel, BorderLayout.SOUTH);
        
        painel.add(topPanel, BorderLayout.NORTH);
        painel.add(scrollPane, BorderLayout.CENTER);
        
        // Configura o botão de gerar relatório
        btnGerar.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                gerarRelatorio();
            }
        });
        
        // Configura o botão de relatório de banco de horas
        btnBancoHoras.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                gerarRelatorioBancoHoras();
            }
        });
        
        return painel;
    }
    
    /**
     * Gera um relatório de funcionários com base nos filtros selecionados
     */
    private void gerarRelatorio() {
        try {
            String funcionarioSelecionado = cmbFuncionarios.getSelectedItem().toString();
            String dataInicial = txtDataInicial.getText();
            String dataFinal = txtDataFinal.getText();
            
            // Valida as datas
            if (!validarFormatoData(dataInicial) || !validarFormatoData(dataFinal)) {
                JOptionPane.showMessageDialog(this, "Formato de data inválido. Use DD/MM/AAAA", "Erro", JOptionPane.ERROR_MESSAGE);
                return;
            }
            
            // Gera o relatório
            String relatorio = null;
            
            if (funcionarioSelecionado.equals("Todos os Funcionários")) {
                relatorio = relatorioController.gerarRelatorioTodosFuncionarios(dataInicial, dataFinal);
            } else {
                relatorio = relatorioController.gerarRelatorioFuncionario(funcionarioSelecionado, dataInicial, dataFinal);
            }
            
            // Exibe o relatório
            txtResultado.setText(relatorio);
            
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Erro ao gerar relatório: " + ex.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
            ex.printStackTrace();
        }
    }
    
    /**
     * Gera relatório de banco de horas de todos os funcionários
     */
    private void gerarRelatorioBancoHoras() {
        try {
            // Gera o relatório usando o controlador
            String relatorio = relatorioController.gerarRelatorioBancoHoras();
            
            // Exibe o relatório na área de texto
            txtResultado.setText(relatorio);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, 
                "Erro ao gerar relatório de banco de horas: " + ex.getMessage(), 
                "Erro", 
                JOptionPane.ERROR_MESSAGE);
            ex.printStackTrace();
        }
    }
    
    /**
     * Cria o painel para gerenciar funcionários reservados
     */
    private JPanel criarPainelFuncionariosReservados() {
        JPanel painel = new JPanel(new BorderLayout());
        painel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        
        JLabel lblTitulo = new JLabel("Funcionários Reservados (Inativos)", JLabel.CENTER);
        lblTitulo.setFont(new Font("Arial", Font.BOLD, 14));
        lblTitulo.setBorder(BorderFactory.createEmptyBorder(0, 0, 10, 0));
        
        // Cria tabela para exibir funcionários reservados
        String[] colunas = {"Registro", "Nome", "CPF", "Cargo", "Carga Horária"};
        Object[][] dados = new Object[0][5]; // Inicialmente vazia
        
        tabelaReservados = new JTable(dados, colunas);
        tabelaReservados.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        tabelaReservados.getTableHeader().setReorderingAllowed(false);
        
        // Permite selecionar uma linha para reativar funcionário
        tabelaReservados.getSelectionModel().addListSelectionListener(e -> {
            if (!e.getValueIsAdjusting()) {
                btnReativar.setEnabled(tabelaReservados.getSelectedRow() != -1);
            }
        });
        
        JScrollPane scrollPane = new JScrollPane(tabelaReservados);
        scrollPane.setPreferredSize(new Dimension(700, 300));
        
        // Painel de botões
        JPanel painelBotoes = new JPanel(new FlowLayout(FlowLayout.CENTER));
        btnReativar = new JButton("Reativar Funcionário");
        btnReativar.setEnabled(false); // Inicialmente desabilitado
        btnReativar.setPreferredSize(new Dimension(200, 40));
        
        btnAtualizar = new JButton("Atualizar Lista");
        btnAtualizar.setPreferredSize(new Dimension(150, 40));
        
        painelBotoes.add(btnReativar);
        painelBotoes.add(btnAtualizar);
        
        // Configurar botões
        btnReativar.addActionListener(e -> reativarFuncionarioSelecionado());
        btnAtualizar.addActionListener(e -> atualizarTabelaFuncionariosReservados());
        
        // Adiciona os componentes ao painel
        painel.add(lblTitulo, BorderLayout.NORTH);
        painel.add(scrollPane, BorderLayout.CENTER);
        painel.add(painelBotoes, BorderLayout.SOUTH);
        
        // Inicializa a tabela com dados
        atualizarTabelaFuncionariosReservados();
        
        return painel;
    }
    
    /**
     * Atualiza a tabela de funcionários reservados
     */
    private void atualizarTabelaFuncionariosReservados() {
        List<Funcionario> funcionariosReservados = adminController.listarFuncionariosReservados();
        
        // Cria modelo para a tabela
        DefaultTableModel modelo = new DefaultTableModel() {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false; // Impede a edição das células
            }
        };
        
        // Define as colunas
        modelo.addColumn("Registro");
        modelo.addColumn("Nome");
        modelo.addColumn("CPF");
        modelo.addColumn("Cargo");
        modelo.addColumn("Carga Horária");
        
        // Adiciona os dados dos funcionários
        for (Funcionario funcionario : funcionariosReservados) {
            Object[] linha = {
                funcionario.getRegistro(),
                funcionario.getNome(),
                funcionario.getCpf(),
                funcionario.getCargo(),
                funcionario.getCargaHoraria() + " horas"
            };
            modelo.addRow(linha);
        }
        
        // Aplica o modelo à tabela
        tabelaReservados.setModel(modelo);
        
        // Desabilita o botão de reativar
        btnReativar.setEnabled(false);
    }
    
    /**
     * Reativa o funcionário selecionado na tabela
     */
    private void reativarFuncionarioSelecionado() {
        int linhaSelecionada = tabelaReservados.getSelectedRow();
        
        if (linhaSelecionada >= 0) {
            String registro = tabelaReservados.getValueAt(linhaSelecionada, 0).toString();
            String nome = tabelaReservados.getValueAt(linhaSelecionada, 1).toString();
            
            // Confirma a reativação
            int opcao = JOptionPane.showConfirmDialog(
                this,
                "Tem certeza que deseja reativar o funcionário " + nome + "?",
                "Reativar Funcionário",
                JOptionPane.YES_NO_OPTION
            );
            
            if (opcao == JOptionPane.YES_OPTION) {
                boolean reativado = adminController.reativarFuncionario(registro);
                
                if (reativado) {
                    JOptionPane.showMessageDialog(
                        this,
                        "Funcionário reativado com sucesso!",
                        "Reativação",
                        JOptionPane.INFORMATION_MESSAGE
                    );
                    
                    // Atualiza a tabela
                    atualizarTabelaFuncionariosReservados();
                    
                    // Atualiza a lista de funcionários no relatório
                    atualizarListaFuncionarios();
                } else {
                    JOptionPane.showMessageDialog(
                        this,
                        "Erro ao reativar funcionário. Tente novamente.",
                        "Erro",
                        JOptionPane.ERROR_MESSAGE
                    );
                }
            }
        }
    }
    
    /**
     * Atualiza a lista de funcionários no combo box
     */
    private void atualizarListaFuncionarios() {
        if (cmbFuncionarios != null) {
            // Guarda o item selecionado anteriormente
            Object itemSelecionado = cmbFuncionarios.getSelectedItem();
            
            // Limpa o combo
            cmbFuncionarios.removeAllItems();
            
            // Adiciona a opção "Todos os Funcionários"
            cmbFuncionarios.addItem("Todos os Funcionários");
            
            // Obtém a lista atualizada de funcionários
            String[] funcionarios = funcionarioController.listarFuncionarios();
            for (String funcionario : funcionarios) {
                cmbFuncionarios.addItem(funcionario);
            }
            
            // Tenta restaurar a seleção anterior
            if (itemSelecionado != null) {
                for (int i = 0; i < cmbFuncionarios.getItemCount(); i++) {
                    if (cmbFuncionarios.getItemAt(i).equals(itemSelecionado)) {
                        cmbFuncionarios.setSelectedIndex(i);
                        break;
                    }
                }
            }
        }
    }
    
    /**
     * Valida o formato da data
     */
    private boolean validarFormatoData(String data) {
        return data.matches("\\d{2}/\\d{2}/\\d{4}");
    }
    
    /**
     * Configura os eventos dos botões
     */
    private void configurarTela() {
        btnSair.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                encerrarSessao();
            }
        });
    }
    
    /**
     * Encerra a sessão e retorna à tela principal
     */
    private void encerrarSessao() {
        this.dispose();
        TelaPrincipal telaPrincipal = new TelaPrincipal();
        telaPrincipal.setVisible(true);
    }
}