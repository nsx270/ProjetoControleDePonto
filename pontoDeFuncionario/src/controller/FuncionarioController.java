package pontodefuncionario.controller;

import pontodefuncionario.model.Funcionario;
import pontodefuncionario.model.RegistroPonto;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Controlador responsável por gerenciar operações relacionadas aos funcionários e registros de ponto
 */
public class FuncionarioController {
    
    // Simulando um banco de dados com collections
    private static Map<String, Funcionario> funcionariosMap = new HashMap<>();
    private static Map<String, List<RegistroPonto>> registrosPontoMap = new HashMap<>();
    private static Map<String, Double> bancoHorasMap = new HashMap<>();
    private static int contadorId = 1;
    
    // Constantes para limites de horas extras
    private static final double LIMITE_MINIMO_HORAS_EXTRAS = 0.5; // Mínimo de 30 minutos para contabilizar extras
    private static final double LIMITE_MAXIMO_HORAS_EXTRAS = 2.0; // Máximo de 2 horas extras por dia
    
    // Inicialização com dados para teste
    static {
        // Adiciona alguns funcionários de exemplo
        Funcionario func1 = new Funcionario(contadorId++, "João Silva", "12345678900", "Desenvolvedor", 8.0, "F001");
        Funcionario func2 = new Funcionario(contadorId++, "Maria Santos", "98765432100", "Analista", 8.0, "F002");
        
        funcionariosMap.put(func1.getRegistro(), func1);
        funcionariosMap.put(func2.getRegistro(), func2);
        
        // Inicializa listas vazias para registros de ponto
        registrosPontoMap.put(func1.getRegistro(), new ArrayList<>());
        registrosPontoMap.put(func2.getRegistro(), new ArrayList<>());
        
        // Inicializa banco de horas com zero
        bancoHorasMap.put(func1.getRegistro(), 0.0);
        bancoHorasMap.put(func2.getRegistro(), 0.0);
    }
    
    /**
     * Obtém o próximo ID disponível para um novo funcionário
     */
    public static int getProximoId() {
        return contadorId++;
    }

    /**
     * Adiciona um novo funcionário ao sistema
     */
    public static boolean adicionarFuncionario(Funcionario funcionario) {
        // Verifica se já existe funcionário com o mesmo registro
        if (funcionariosMap.containsKey(funcionario.getRegistro())) {
            return false;
        }
        
        // Verifica se o CPF já está em uso
        for (Funcionario f : funcionariosMap.values()) {
            if (f.getCpf().equals(funcionario.getCpf())) {
                return false;
            }
        }
        
        funcionariosMap.put(funcionario.getRegistro(), funcionario);
        registrosPontoMap.put(funcionario.getRegistro(), new ArrayList<>());
        bancoHorasMap.put(funcionario.getRegistro(), 0.0);
        return true;
    }
    
    /**
     * Autentica um funcionário no sistema
     */
    public boolean autenticarFuncionario(String registro, String senha) {
        Funcionario funcionario = funcionariosMap.get(registro);
        return funcionario != null && funcionario.isAtivo() && funcionario.getCpf().equals(senha);
    }
    
    /**
     * Obtém um funcionário pelo registro
     */
    public Funcionario obterFuncionario(String registro) {
        return funcionariosMap.get(registro);
    }
    
    /**
     * Registra um evento de ponto para o funcionário
     */
    public boolean baterPonto(String registro) {
        Funcionario funcionario = funcionariosMap.get(registro);
        if (funcionario == null || !funcionario.isAtivo()) {
            return false;
        }
        
        // Obtém a lista de registros de ponto do funcionário
        List<RegistroPonto> registros = registrosPontoMap.get(registro);
        
        // Verifica se já existe um registro para hoje
        RegistroPonto registroHoje = obterRegistroAtual(registro);
        Date agora = new Date();
        
        if (registroHoje == null) {
            // Primeiro registro do dia - Entrada
            registroHoje = new RegistroPonto(registro);
            registroHoje.setHoraEntrada(agora);
            registros.add(registroHoje);
            return true;
        } else {
            // Já tem registro para hoje, verifica qual o próximo evento a registrar
            if (registroHoje.getHoraEntrada() != null && registroHoje.getHoraSaidaAlmoco() == null) {
                // Saída para almoço
                registroHoje.setHoraSaidaAlmoco(agora);
                return true;
            } else if (registroHoje.getHoraSaidaAlmoco() != null && registroHoje.getHoraRetornoAlmoco() == null) {
                // Retorno do almoço
                registroHoje.setHoraRetornoAlmoco(agora);
                return true;
            } else if (registroHoje.getHoraRetornoAlmoco() != null && registroHoje.getHoraSaida() == null) {
                // Saída (fim do expediente)
                registroHoje.setHoraSaida(agora);
                
                // Calcula horas trabalhadas 
                registroHoje.calcularHorasTrabalhadas();
                
                // Verifica se a carga horária foi cumprida
                double horasTrabalhadas = registroHoje.getTotalHorasTrabalhadas();
                if (horasTrabalhadas < funcionario.getCargaHoraria()) {
                    // Registra déficit no banco de horas
                    double deficit = funcionario.getCargaHoraria() - horasTrabalhadas;
                    Double bancoHorasAtual = bancoHorasMap.get(registro);
                    if (bancoHorasAtual == null) {
                        bancoHorasAtual = 0.0;
                    }
                    // Subtrai do banco de horas
                    bancoHorasMap.put(registro, bancoHorasAtual - deficit);
                } else if (horasTrabalhadas > funcionario.getCargaHoraria()) {
                    // Calcula as horas extras
                    double horasExtras = horasTrabalhadas - funcionario.getCargaHoraria();
                    
                    // Verifica se atingiu o mínimo de 30 minutos para contabilizar
                    if (horasExtras >= LIMITE_MINIMO_HORAS_EXTRAS) {
                        // Limita a 2 horas extras
                        horasExtras = Math.min(horasExtras, LIMITE_MAXIMO_HORAS_EXTRAS);
                        
                        registroHoje.setHorasExtras(horasExtras);
                        
                        // Adiciona ao banco de horas do funcionário
                        Double bancoHorasAtual = bancoHorasMap.get(registro);
                        if (bancoHorasAtual == null) {
                            bancoHorasAtual = 0.0;
                        }
                        bancoHorasMap.put(registro, bancoHorasAtual + horasExtras);
                    } else {
                        // Se não atingiu 30 minutos, não contabiliza como hora extra
                        registroHoje.setHorasExtras(0.0);
                    }
                }
                
                return true;
            } else {
                // Todos os eventos já foram registrados
                return false;
            }
        }
    }
    
    /**
     * Obtém o registro de ponto do dia atual para um funcionário
     */
    public RegistroPonto obterRegistroAtual(String registro) {
        List<RegistroPonto> registros = registrosPontoMap.get(registro);
        if (registros == null || registros.isEmpty()) {
            return null;
        }
        
        // Compara a data do último registro com a data atual
        RegistroPonto ultimoRegistro = registros.get(registros.size() - 1);
        Date hoje = new Date();
        
        // Simplificando a comparação (assumindo que só compara o dia, ignorando a hora)
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        if (sdf.format(ultimoRegistro.getData()).equals(sdf.format(hoje))) {
            return ultimoRegistro;
        }
        
        return null;
    }
    
    /**
     * Calcula as horas trabalhadas no dia atual
     */
    public double calcularHorasTrabalhadas(String registro) {
        RegistroPonto registroHoje = obterRegistroAtual(registro);
        if (registroHoje == null) {
            return 0;
        }
        
        double horasManha = 0;
        double horasTarde = 0;
        Date agora = new Date();
        
        // Período da manhã (entrada até saída almoço ou agora)
        if (registroHoje.getHoraEntrada() != null) {
            if (registroHoje.getHoraSaidaAlmoco() != null) {
                horasManha = RegistroPonto.calcularDiferencaHoras(registroHoje.getHoraEntrada(), registroHoje.getHoraSaidaAlmoco());
            } else if (registroHoje.getHoraSaida() != null) {
                // Se não saiu para o almoço mas já encerrou o expediente
                horasManha = RegistroPonto.calcularDiferencaHoras(registroHoje.getHoraEntrada(), registroHoje.getHoraSaida());
            } else {
                horasManha = RegistroPonto.calcularDiferencaHoras(registroHoje.getHoraEntrada(), agora);
            }
        }
        
        // Período da tarde (retorno almoço até saída ou agora)
        if (registroHoje.getHoraRetornoAlmoco() != null) {
            if (registroHoje.getHoraSaida() != null) {
                horasTarde = RegistroPonto.calcularDiferencaHoras(registroHoje.getHoraRetornoAlmoco(), registroHoje.getHoraSaida());
            } else {
                horasTarde = RegistroPonto.calcularDiferencaHoras(registroHoje.getHoraRetornoAlmoco(), agora);
            }
        }
        
        return horasManha + horasTarde;
    }
    
    /**
     * Verifica se a carga horária diária foi cumprida
     */
    public boolean verificarCargaHoraria(String registro) {
        Funcionario funcionario = funcionariosMap.get(registro);
        if (funcionario == null) {
            return false;
        }
        
        double horasTrabalhadas = calcularHorasTrabalhadas(registro);
        return horasTrabalhadas >= funcionario.getCargaHoraria();
    }
    
    /**
     * Obtém o saldo do banco de horas do funcionário
     */
    public double obterBancoHoras(String registro) {
        Double bancoHoras = bancoHorasMap.get(registro);
        return bancoHoras != null ? bancoHoras : 0.0;
    }
    
    /**
     * Finaliza o registro de ponto do dia
     */
    public boolean finalizarPonto(String registro) {
        RegistroPonto registroHoje = obterRegistroAtual(registro);
        if (registroHoje == null) {
            return false;
        }
        
        // Se ainda não bateu o ponto de saída, registra agora
        if (registroHoje.getHoraSaida() == null) {
            return baterPonto(registro);
        }
        
        return true;
    }
    
    /**
     * Lista todos os funcionários ativos
     */
    public String[] listarFuncionarios() {
        List<String> nomes = new ArrayList<>();
        
        for (Funcionario funcionario : funcionariosMap.values()) {
            if (funcionario.isAtivo()) {
                nomes.add(funcionario.getNome() + " (" + funcionario.getRegistro() + ")");
            }
        }
        
        return nomes.toArray(new String[0]);
    }
    
    /**
     * Busca um funcionário pelo registro ou CPF
     */
    public Object[] buscarFuncionarioPorRegistroOuCPF(String registroOuCPF) {
        Funcionario funcionario = null;
        
        // Verifica se é um registro
        if (funcionariosMap.containsKey(registroOuCPF)) {
            funcionario = funcionariosMap.get(registroOuCPF);
        } else {
            // Busca por CPF
            for (Funcionario f : funcionariosMap.values()) {
                if (f.getCpf().equals(registroOuCPF)) {
                    funcionario = f;
                    break;
                }
            }
        }
        
        if (funcionario != null && funcionario.isAtivo()) {
            Object[] info = new Object[5];
            info[0] = funcionario.getNome();
            info[1] = funcionario.getCpf();
            info[2] = funcionario.getCargo();
            info[3] = funcionario.getCargaHoraria();
            info[4] = funcionario.getRegistro();
            return info;
        }
        
        return null;
    }
    
    /**
     * Obtém os registros de ponto de um funcionário em um período
     */
    public List<RegistroPonto> obterRegistrosPeriodo(String registro, Date dataInicial, Date dataFinal) {
        List<RegistroPonto> registros = registrosPontoMap.get(registro);
        List<RegistroPonto> registrosPeriodo = new ArrayList<>();
        
        if (registros != null) {
            for (RegistroPonto r : registros) {
                if (!r.getData().before(dataInicial) && !r.getData().after(dataFinal)) {
                    // Garante que as horas trabalhadas e extras estão calculadas corretamente
                    r.calcularHorasTrabalhadas();
                    Funcionario funcionario = obterFuncionario(registro);
                    if (funcionario != null) {
                        r.calcularHorasExtras(funcionario.getCargaHoraria());
                    }
                    registrosPeriodo.add(r);
                }
            }
        }
        
        return registrosPeriodo;
    }
}