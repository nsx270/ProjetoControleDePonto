package pontodefuncionario.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Classe que representa um relatório de ponto para um funcionário em um período específico
 */
public class Relatorio {
    private int idRelatorio;
    private String registroFuncionario;
    private Date dataInicial;
    private Date dataFinal;
    private double totalHorasTrabalhadas;
    private double totalHorasExtras;
    private int totalFaltas;
    private double saldoBancoHoras;
    
    /**
     * Construtor para criação de um novo relatório
     */
    public Relatorio(String registroFuncionario, Date dataInicial, Date dataFinal) {
        this.registroFuncionario = registroFuncionario;
        this.dataInicial = dataInicial;
        this.dataFinal = dataFinal;
        this.totalHorasTrabalhadas = 0;
        this.totalHorasExtras = 0;
        this.totalFaltas = 0;
        this.saldoBancoHoras = 0;
    }
    
    // Getters e Setters
    public int getIdRelatorio() {
        return idRelatorio;
    }
    
    public void setIdRelatorio(int idRelatorio) {
        this.idRelatorio = idRelatorio;
    }
    
    public String getRegistroFuncionario() {
        return registroFuncionario;
    }
    
    public void setRegistroFuncionario(String registroFuncionario) {
        this.registroFuncionario = registroFuncionario;
    }
    
    public Date getDataInicial() {
        return dataInicial;
    }
    
    public void setDataInicial(Date dataInicial) {
        this.dataInicial = dataInicial;
    }
    
    public Date getDataFinal() {
        return dataFinal;
    }
    
    public void setDataFinal(Date dataFinal) {
        this.dataFinal = dataFinal;
    }
    
    public double getTotalHorasTrabalhadas() {
        return totalHorasTrabalhadas;
    }
    
    public void setTotalHorasTrabalhadas(double totalHorasTrabalhadas) {
        this.totalHorasTrabalhadas = totalHorasTrabalhadas;
    }
    
    public double getTotalHorasExtras() {
        return totalHorasExtras;
    }
    
    public void setTotalHorasExtras(double totalHorasExtras) {
        this.totalHorasExtras = totalHorasExtras;
    }
    
    public int getTotalFaltas() {
        return totalFaltas;
    }
    
    public void setTotalFaltas(int totalFaltas) {
        this.totalFaltas = totalFaltas;
    }
    
    public double getSaldoBancoHoras() {
        return saldoBancoHoras;
    }
    
    public void setSaldoBancoHoras(double saldoBancoHoras) {
        this.saldoBancoHoras = saldoBancoHoras;
    }
    
    /**
     * Calcula o relatório com base nos registros de ponto
     */
    public void calcularRelatorio(List<RegistroPonto> registros, int diasUteis) {
        // Inicializa totais
        totalHorasTrabalhadas = 0;
        totalHorasExtras = 0;
        totalFaltas = diasUteis - registros.size(); // dias sem registro são faltas
        
        if (totalFaltas < 0) totalFaltas = 0; // Garante que não haja faltas negativas
        
        // Processa cada registro de ponto
        for (RegistroPonto registro : registros) {
            // Garante que as horas trabalhadas são calculadas corretamente
            registro.calcularHorasTrabalhadas();
            
            // Verifica se o registro está completo para o dia (todos os eventos registrados)
            if (registro.isPontoCompleto()) {
                totalHorasTrabalhadas += registro.getTotalHorasTrabalhadas();
                totalHorasExtras += registro.getHorasExtras();
            } else {
                // Se o registro não está completo, verifica se deve contar como falta
                if (registro.getHoraEntrada() == null) {
                    totalFaltas++;
                }
            }
        }
    }
    
    /**
     * Formata o relatório para exibição
     */
    public String formatarRelatorio(Funcionario funcionario) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        StringBuilder sb = new StringBuilder();
        
        sb.append("=================================================\n");
        sb.append("             RELATÓRIO DE PONTO                  \n");
        sb.append("=================================================\n\n");
        
        sb.append("Funcionário: ").append(funcionario.getNome()).append("\n");
        sb.append("Registro: ").append(funcionario.getRegistro()).append("\n");
        sb.append("CPF: ").append(funcionario.getCpf()).append("\n");
        sb.append("Cargo: ").append(funcionario.getCargo()).append("\n");
        sb.append("Carga Horária Diária: ").append(formatarHorasMinutos(funcionario.getCargaHoraria())).append("\n\n");
        
        sb.append("Período: ").append(sdf.format(dataInicial)).append(" a ");
        sb.append(sdf.format(dataFinal)).append("\n\n");
        
        sb.append("Total de Horas Trabalhadas: ").append(formatarHorasMinutos(totalHorasTrabalhadas)).append("\n");
        sb.append("Total de Horas Extras: ").append(formatarHorasMinutos(totalHorasExtras)).append("\n");
        sb.append("Faltas: ").append(totalFaltas).append(" dia(s)\n");
        
        // Formata o saldo do banco de horas (pode ser positivo ou negativo)
        String sinalBanco = saldoBancoHoras >= 0 ? "+" : "";
        sb.append("Saldo Banco de Horas: ").append(sinalBanco).append(formatarHorasMinutos(saldoBancoHoras)).append("\n\n");
        
        // Adicional para o relatório
        if (totalFaltas > 0) {
            sb.append("* Este funcionário teve ").append(totalFaltas).append(" falta(s) no período.\n");
        }
        
        if (totalHorasExtras > 0) {
            sb.append("* Este funcionário realizou ").append(formatarHorasMinutos(totalHorasExtras)).append(" extras no período.\n");
        }
        
        if (saldoBancoHoras < 0) {
            sb.append("* ATENÇÃO: Saldo negativo no banco de horas de ").append(formatarHorasMinutos(Math.abs(saldoBancoHoras))).append(".\n");
        }
        
        sb.append("=================================================\n");
        sb.append("           Relatório gerado em: ").append(sdf.format(new Date())).append("\n");
        sb.append("=================================================\n");
        
        return sb.toString();
    }
    
    /**
     * Formata horas em formato decimal para o formato de horas e minutos mais legível
     */
    public static String formatarHorasMinutos(double horas) {
        boolean negativo = horas < 0;
        double horasAbs = Math.abs(horas);
        
        int horasInteiras = (int) horasAbs;
        int minutos = (int) Math.round((horasAbs - horasInteiras) * 60);
        
        // Ajuste para caso os minutos arredondem para 60
        if (minutos == 60) {
            horasInteiras++;
            minutos = 0;
        }
        
        if (horasInteiras == 0) {
            // Se for menos de uma hora, mostrar apenas os minutos
            return (negativo ? "-" : "") + minutos + " minutos";
        } else if (minutos == 0) {
            // Se for um número exato de horas sem minutos
            String plural = horasInteiras == 1 ? "hora" : "horas";
            return (negativo ? "-" : "") + horasInteiras + " " + plural;
        } else {
            // Formato completo com horas e minutos
            String plural = horasInteiras == 1 ? "hora" : "horas";
            return (negativo ? "-" : "") + horasInteiras + " " + plural + " e " + minutos + " minutos";
        }
    }
    
    /**
     * Método alternativo para formatação de horas e minutos no formato HH:MM
     */
    public static String formatarHorasMinutosCompacto(double horas) {
        boolean negativo = horas < 0;
        double horasAbs = Math.abs(horas);
        
        int horasInteiras = (int) horasAbs;
        int minutos = (int) Math.round((horasAbs - horasInteiras) * 60);
        
        // Ajuste para caso os minutos arredondem para 60
        if (minutos == 60) {
            horasInteiras++;
            minutos = 0;
        }
        
        return (negativo ? "-" : "") + String.format("%02d:%02d", horasInteiras, minutos);
    }
}