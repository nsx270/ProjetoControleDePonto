package pontodefuncionario.controller;

import pontodefuncionario.model.Administrador;
import pontodefuncionario.model.Funcionario;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Controlador responsável por gerenciar operações administrativas do sistema
 */
public class AdministradorController {
    
    // Simulando um banco de dados com collections
    private static Map<String, Administrador> administradoresMap = new HashMap<>();
    private static List<Funcionario> funcionariosReservados = new ArrayList<>();
    private static int contadorId = 1;
    
    // Inicialização com dados para teste
    static {
        // Adiciona um administrador padrão
        Administrador admin = new Administrador(contadorId++, "admin", "admin123", "Administrador do Sistema");
        administradoresMap.put(admin.getUsername(), admin);
    }
    
    /**
     * Autentica um administrador no sistema
     */
    public boolean autenticarAdmin(String usuario, String senha) {
        Administrador admin = administradoresMap.get(usuario);
        return admin != null && admin.verificarCredenciais(usuario, senha);
    }
    
    /**
     * Cadastra um novo funcionário no sistema
     */
    public boolean cadastrarFuncionario(String nome, String cpf, String cargo, double cargaHoraria, String registro) {
        // Validação de entrada
        if (nome == null || nome.trim().isEmpty() || 
            cpf == null || cpf.trim().isEmpty() || 
            cargo == null || cargo.trim().isEmpty() || 
            registro == null || registro.trim().isEmpty() || 
            cargaHoraria <= 0) {
            return false;
        }
        
        // Validação de formato de CPF (formato básico)
        if (!validarFormatoCPF(cpf)) {
            return false;
        }
        
        // Verifica se já existe funcionário com o mesmo CPF ou registro
        FuncionarioController funcionarioController = new FuncionarioController();
        Object[] funcionarioExistente = funcionarioController.buscarFuncionarioPorRegistroOuCPF(registro);
        
        if (funcionarioExistente != null) {
            return false; // Já existe funcionário com este registro
        }
        
        funcionarioExistente = funcionarioController.buscarFuncionarioPorRegistroOuCPF(cpf);
        if (funcionarioExistente != null) {
            return false; // Já existe funcionário com este CPF
        }
        
        // Verifica se existe um funcionário reservado com o mesmo CPF
        for (Funcionario f : funcionariosReservados) {
            if (f.getCpf().equals(cpf)) {
                return false; // Já existe funcionário reservado com este CPF
            }
        }
        
        // Cria um novo funcionário
        Funcionario novoFuncionario = new Funcionario(
            FuncionarioController.getProximoId(),
            nome,
            cpf,
            cargo,
            cargaHoraria,
            registro
        );
        
        // Adiciona o funcionário no "banco de dados"
        return FuncionarioController.adicionarFuncionario(novoFuncionario);
    }

    /**
     * Remove (desativa) um funcionário do sistema
     */
    public boolean removerFuncionario(String registro) {
        FuncionarioController funcionarioController = new FuncionarioController();
        Funcionario funcionario = funcionarioController.obterFuncionario(registro);
        
        if (funcionario == null || !funcionario.isAtivo()) {
            return false;
        }
        
        // Adiciona o funcionário à lista de reservados
        funcionariosReservados.add(funcionario);
        
        // Apenas desativa o funcionário, mantendo os registros
        funcionario.setAtivo(false);
        return true;
    }
    
    /**
     * Lista todos os funcionários desativados (reservados)
     */
    public List<Funcionario> listarFuncionariosReservados() {
        return new ArrayList<>(funcionariosReservados);
    }

    /**
     * Reativa um funcionário previamente desativado
     */
    public boolean reativarFuncionario(String registro) {
        FuncionarioController funcionarioController = new FuncionarioController();
        Funcionario funcionario = funcionarioController.obterFuncionario(registro);
        
        if (funcionario == null) {
            return false;
        }
        
        // Verifica se o funcionário está na lista de reservados
        boolean encontrado = false;
        for (Funcionario f : funcionariosReservados) {
            if (f.getRegistro().equals(registro)) {
                encontrado = true;
                funcionariosReservados.remove(f);
                break;
            }
        }
        
        if (!encontrado) {
            return false;
        }
        
        // Reativa o funcionário
        funcionario.setAtivo(true);
        return true;
    }
    
    /**
     * Edita as informações de um funcionário
     */
    public boolean editarFuncionario(String registro, String nome, String cargo, double cargaHoraria) {
        // Validação de entrada
        if (nome == null || nome.trim().isEmpty() || 
            cargo == null || cargo.trim().isEmpty() || 
            cargaHoraria <= 0) {
            return false;
        }
        
        FuncionarioController funcionarioController = new FuncionarioController();
        Funcionario funcionario = funcionarioController.obterFuncionario(registro);
        
        if (funcionario == null || !funcionario.isAtivo()) {
            return false;
        }
        
        // Atualiza as informações
        funcionario.setNome(nome);
        funcionario.setCargo(cargo);
        funcionario.setCargaHoraria(cargaHoraria);
        
        return true;
    }
    
    /**
     * Gera um relatório geral de todos os funcionários
     */
    public String gerarRelatorioGeral() {
        RelatorioController relatorioController = new RelatorioController();
        return relatorioController.gerarRelatorioTodosFuncionarios(null, null);
    }
    
    /**
     * Valida o formato básico de um CPF (XXX.XXX.XXX-XX ou XXXXXXXXXXX)
     */
    private boolean validarFormatoCPF(String cpf) {
        return cpf.matches("\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}") || cpf.matches("\\d{11}");
    }
}