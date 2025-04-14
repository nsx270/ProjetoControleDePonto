package pontodefuncionario.controller;

import pontodefuncionario.model.Funcionario;
import pontodefuncionario.model.Relatorio;
import pontodefuncionario.model.RegistroPonto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Controlador responsável pela geração de relatórios de ponto
 * dos funcionários em diversos formatos e períodos.
 */
public class RelatorioController {
    
    private FuncionarioController funcionarioController;
    
    /**
     * Construtor padrão que inicializa o controlador de funcionário
     */
    public RelatorioController() {
        this.funcionarioController = new FuncionarioController();
    }
    
    /**
     * Gera um relatório para um funcionário específico em um período
     * @param registroOuNome Registro ou nome do funcionário
     * @param dataInicialStr Data inicial em formato DD/MM/AAAA
     * @param dataFinalStr Data final em formato DD/MM/AAAA
     * @return Relatório em formato de texto
     */
    public String gerarRelatorioFuncionario(String registroOuNome, String dataInicialStr, String dataFinalStr) {
        try {
            // Valida os parâmetros de entrada
            if (registroOuNome == null || registroOuNome.trim().isEmpty() ||
                dataInicialStr == null || dataInicialStr.trim().isEmpty() ||
                dataFinalStr == null || dataFinalStr.trim().isEmpty()) {
                return "Parâmetros inválidos para geração do relatório.";
            }
            
            // Converte as strings de data para objetos Date
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            Date dataInicial = sdf.parse(dataInicialStr);
            Date dataFinal = sdf.parse(dataFinalStr);
            
            // Verifica se a data final é posterior à data inicial
            if (dataFinal.before(dataInicial)) {
                return "Erro: Data final não pode ser anterior à data inicial.";
            }
            
            // Busca o funcionário
            String registro = extrairRegistro(registroOuNome);
            Funcionario funcionario = funcionarioController.obterFuncionario(registro);
            
            if (funcionario == null) {
                return "Funcionário não encontrado.";
            }
            
            if (!funcionario.isAtivo()) {
                return "Funcionário desativado. Registro: " + registro + ", Nome: " + funcionario.getNome();
            }
            
            // Obtém os registros de ponto do período
            List<RegistroPonto> registrosPeriodo = funcionarioController.obterRegistrosPeriodo(registro, dataInicial, dataFinal);
            
            // Calcula o número de dias úteis no período (simplificação: considerando todos os dias exceto fins de semana)
            int diasUteis = calcularDiasUteis(dataInicial, dataFinal);
            
            // Cria e calcula o relatório
            Relatorio relatorio = new Relatorio(registro, dataInicial, dataFinal);
            relatorio.calcularRelatorio(registrosPeriodo, diasUteis);
            
            // Adiciona informação do banco de horas atual
            double bancoHoras = funcionarioController.obterBancoHoras(registro);
            relatorio.setSaldoBancoHoras(bancoHoras);
            
            // Garante que as horas trabalhadas estão sendo contabilizadas
            validarHorasTrabalhadas(relatorio, registrosPeriodo);
            
            // Formata o relatório
            return relatorio.formatarRelatorio(funcionario);
            
        } catch (ParseException e) {
            return "Erro ao processar as datas. Use o formato DD/MM/AAAA.";
        } catch (Exception e) {
            return "Erro ao gerar relatório: " + e.getMessage();
        }
    }
    
    /**
     * Verifica e ajusta as horas trabalhadas no relatório se necessário
     * @param relatorio Relatório a ser validado
     * @param registros Lista de registros de ponto
     */
    private void validarHorasTrabalhadas(Relatorio relatorio, List<RegistroPonto> registros) {
        // Se as horas trabalhadas no relatório estiverem zeradas, recalcular
        if (relatorio.getTotalHorasTrabalhadas() <= 0 && !registros.isEmpty()) {
            double totalHoras = 0;
            double totalExtras = 0;
            
            // Calcula o total diretamente a partir dos registros
            for (RegistroPonto registro : registros) {
                // Recalcula as horas trabalhadas para garantir
                registro.calcularHorasTrabalhadas();
                
                totalHoras += registro.getTotalHorasTrabalhadas();
                totalExtras += registro.getHorasExtras();
            }
            
            // Atualiza o relatório com os valores calculados
            relatorio.setTotalHorasTrabalhadas(totalHoras);
            relatorio.setTotalHorasExtras(totalExtras);
        }
    }
    
    /**
     * Gera um relatório para todos os funcionários em um período
     * @param dataInicialStr Data inicial em formato DD/MM/AAAA (opcional)
     * @param dataFinalStr Data final em formato DD/MM/AAAA (opcional)
     * @return Relatório consolidado em formato de texto
     */
    public String gerarRelatorioTodosFuncionarios(String dataInicialStr, String dataFinalStr) {
        StringBuilder relatorioCompleto = new StringBuilder();
        
        // Se as datas não foram fornecidas, usa o mês atual
        if (dataInicialStr == null || dataFinalStr == null || dataInicialStr.isEmpty() || dataFinalStr.isEmpty()) {
            Calendar cal = Calendar.getInstance();
            
            // Define início do mês
            cal.set(Calendar.DAY_OF_MONTH, 1);
            Date inicioMes = cal.getTime();
            
            // Define fim do mês
            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
            Date fimMes = cal.getTime();
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            dataInicialStr = sdf.format(inicioMes);
            dataFinalStr = sdf.format(fimMes);
        }
        
        // Cabeçalho do relatório
        relatorioCompleto.append("=================================================\n");
        relatorioCompleto.append("         RELATÓRIO GERAL DE FUNCIONÁRIOS         \n");
        relatorioCompleto.append("=================================================\n\n");
        relatorioCompleto.append("Período: ").append(dataInicialStr).append(" a ").append(dataFinalStr).append("\n\n");
        
        // Obtém a lista de funcionários
        String[] funcionarios = funcionarioController.listarFuncionarios();
        
        if (funcionarios.length == 0) {
            relatorioCompleto.append("Nenhum funcionário cadastrado.\n");
        } else {
            // Gera relatório para cada funcionário
            for (String funcionarioStr : funcionarios) {
                relatorioCompleto.append("\n\n");
                relatorioCompleto.append(gerarRelatorioFuncionario(funcionarioStr, dataInicialStr, dataFinalStr));
                relatorioCompleto.append("\n\n-------------------------------------------------\n");
            }
        }
        
        relatorioCompleto.append("\nRelatório gerado em: ").append(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date()));
        relatorioCompleto.append("\n=================================================\n");
        
        return relatorioCompleto.toString();
    }
    
    /**
     * Extrai o registro de um string no formato "Nome (Registro)"
     * @param nomeComRegistro String no formato "Nome (Registro)"
     * @return Registro extraído ou a string original se não for possível extrair
     */
    private String extrairRegistro(String nomeComRegistro) {
        // Tenta extrair o registro no formato "Nome (Registro)"
        int inicio = nomeComRegistro.lastIndexOf("(");
        int fim = nomeComRegistro.lastIndexOf(")");
        
        if (inicio > 0 && fim > inicio) {
            return nomeComRegistro.substring(inicio + 1, fim);
        }
        
        // Se não conseguir extrair, assume que a string já é o registro
        return nomeComRegistro;
    }
    
    /**
     * Calcula o número de dias úteis entre duas datas (excluindo fins de semana)
     * @param dataInicial Data inicial
     * @param dataFinal Data final
     * @return Número de dias úteis
     */
    private int calcularDiasUteis(Date dataInicial, Date dataFinal) {
        Calendar calInicio = Calendar.getInstance();
        calInicio.setTime(dataInicial);
        
        Calendar calFim = Calendar.getInstance();
        calFim.setTime(dataFinal);
        
        int diasUteis = 0;
        
        while (!calInicio.after(calFim)) {
            int diaDaSemana = calInicio.get(Calendar.DAY_OF_WEEK);
            
            // Verifica se não é fim de semana (1 = domingo, 7 = sábado)
            if (diaDaSemana != Calendar.SATURDAY && diaDaSemana != Calendar.SUNDAY) {
                diasUteis++;
            }
            
            calInicio.add(Calendar.DATE, 1);
        }
        
        return diasUteis;
    }
    
    /**
     * Gera um relatório resumido do banco de horas de todos os funcionários
     * @return String com o resumo do banco de horas
     */
    public String gerarRelatorioBancoHoras() {
        StringBuilder relatorio = new StringBuilder();
        
        relatorio.append("=================================================\n");
        relatorio.append("         RELATÓRIO DE BANCO DE HORAS             \n");
        relatorio.append("=================================================\n\n");
        
        // Obtém a lista de funcionários
        String[] funcionarios = funcionarioController.listarFuncionarios();
        
        if (funcionarios.length == 0) {
            relatorio.append("Nenhum funcionário cadastrado.\n");
        } else {
            relatorio.append(String.format("%-20s %-15s %-15s\n", "Nome", "Registro", "Banco de Horas"));
            relatorio.append("-------------------------------------------------\n");
            
            for (String funcionarioStr : funcionarios) {
                String registro = extrairRegistro(funcionarioStr);
                Funcionario funcionario = funcionarioController.obterFuncionario(registro);
                
                if (funcionario != null && funcionario.isAtivo()) {
                    double bancoHoras = funcionarioController.obterBancoHoras(registro);
                    
                    // Formata horas no formato HH:MM (positivo ou negativo)
                    String horasFormatadas;
                    if (bancoHoras >= 0) {
                        int horas = (int) bancoHoras;
                        int minutos = (int) Math.round((bancoHoras - horas) * 60);
                        // Ajuste para caso os minutos arredondem para 60
                        if (minutos == 60) {
                            horas++;
                            minutos = 0;
                        }
                        horasFormatadas = String.format("+%02d:%02d", horas, minutos);
                    } else {
                        double absHoras = Math.abs(bancoHoras);
                        int horas = (int) absHoras;
                        int minutos = (int) Math.round((absHoras - horas) * 60);
                        // Ajuste para caso os minutos arredondem para 60
                        if (minutos == 60) {
                            horas++;
                            minutos = 0;
                        }
                        horasFormatadas = String.format("-%02d:%02d", horas, minutos);
                    }

                    relatorio.append(String.format("%-20s %-15s %-15s\n", 
                        funcionario.getNome(), 
                        funcionario.getRegistro(), 
                        horasFormatadas
                    ));
                }
            }
        }

        relatorio.append("\nRelatório gerado em: ").append(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date()));
        relatorio.append("\n=================================================\n");

        return relatorio.toString();
    }
}