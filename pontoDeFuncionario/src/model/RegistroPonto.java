package pontodefuncionario.model;

import java.util.Date;
import java.text.SimpleDateFormat;

/**
 * Classe que representa um registro de ponto diário de um funcionário
 */
public class RegistroPonto {
    private int id;
    private String registroFuncionario;
    private Date data;
    private Date horaEntrada;
    private Date horaSaidaAlmoco;
    private Date horaRetornoAlmoco;
    private Date horaSaida;
    private double totalHorasTrabalhadas;
    private double horasExtras;
    private double tempoAlmoco;
    
    // Constantes para limites de horas extras
    private static final double LIMITE_MINIMO_HORAS_EXTRAS = 0.5; // Mínimo de 30 minutos
    private static final double LIMITE_MAXIMO_HORAS_EXTRAS = 2.0; // Máximo de 2 horas
    
    /**
     * Construtor básico para um novo registro de ponto
     */
    public RegistroPonto(String registroFuncionario) {
        this.registroFuncionario = registroFuncionario;
        this.data = new Date();
        this.tempoAlmoco = 0.0;
        this.totalHorasTrabalhadas = 0.0;
        this.horasExtras = 0.0;
    }
    
    // Getters e Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getRegistroFuncionario() {
        return registroFuncionario;
    }
    
    public void setRegistroFuncionario(String registroFuncionario) {
        this.registroFuncionario = registroFuncionario;
    }
    
    public Date getData() {
        return data;
    }
    
    public void setData(Date data) {
        this.data = data;
    }
    
    public Date getHoraEntrada() {
        return horaEntrada;
    }
    
    public void setHoraEntrada(Date horaEntrada) {
        this.horaEntrada = horaEntrada;
    }
    
    public Date getHoraSaidaAlmoco() {
        return horaSaidaAlmoco;
    }
    
    public void setHoraSaidaAlmoco(Date horaSaidaAlmoco) {
        this.horaSaidaAlmoco = horaSaidaAlmoco;
    }
    
    public Date getHoraRetornoAlmoco() {
        return horaRetornoAlmoco;
    }
    
    public void setHoraRetornoAlmoco(Date horaRetornoAlmoco) {
        this.horaRetornoAlmoco = horaRetornoAlmoco;
        
        // Calcula o tempo de almoço quando retorna
        if (this.horaSaidaAlmoco != null && horaRetornoAlmoco != null) {
            this.tempoAlmoco = calcularDiferencaHoras(this.horaSaidaAlmoco, horaRetornoAlmoco);
        }
    }
    
    public Date getHoraSaida() {
        return horaSaida;
    }
    
    public void setHoraSaida(Date horaSaida) {
        this.horaSaida = horaSaida;
    }
    
    public double getTotalHorasTrabalhadas() {
        return totalHorasTrabalhadas;
    }
    
    public void setTotalHorasTrabalhadas(double totalHorasTrabalhadas) {
        this.totalHorasTrabalhadas = totalHorasTrabalhadas;
    }
    
    public double getHorasExtras() {
        return horasExtras;
    }
    
    public void setHorasExtras(double horasExtras) {
        this.horasExtras = horasExtras;
    }
    
    public double getTempoAlmoco() {
        return tempoAlmoco;
    }
    
    public void setTempoAlmoco(double tempoAlmoco) {
        this.tempoAlmoco = tempoAlmoco;
    }
    
    /**
     * Calcula a diferença em horas entre dois horários
     */
    public static double calcularDiferencaHoras(Date inicio, Date fim) {
        if (inicio == null || fim == null) {
            return 0;
        }
        
        long diferencaMillis = fim.getTime() - inicio.getTime();
        return diferencaMillis / (1000.0 * 60 * 60); // converte para horas
    }

    /**
     * Calcula o total de horas trabalhadas no dia
     */
    public void calcularHorasTrabalhadas() {
        double horasManha = 0;
        double horasTarde = 0;
        
        // Período da manhã (entrada até saída almoço)
        if (horaEntrada != null && horaSaidaAlmoco != null) {
            horasManha = calcularDiferencaHoras(horaEntrada, horaSaidaAlmoco);
        } else if (horaEntrada != null && horaSaida != null && horaSaidaAlmoco == null) {
            // Caso não tenha ido almoçar, apenas entrada e saída
            horasManha = calcularDiferencaHoras(horaEntrada, horaSaida);
        }
        
        // Período da tarde (retorno almoço até saída)
        if (horaRetornoAlmoco != null && horaSaida != null) {
            horasTarde = calcularDiferencaHoras(horaRetornoAlmoco, horaSaida);
        }
        
        totalHorasTrabalhadas = horasManha + horasTarde;
        
        // Calcula o tempo de almoço se tiver saída e retorno
        if (horaSaidaAlmoco != null && horaRetornoAlmoco != null) {
            tempoAlmoco = calcularDiferencaHoras(horaSaidaAlmoco, horaRetornoAlmoco);
        }
    }
    
    /**
     * Calcula as horas extras realizadas
     * Só contabiliza após 30 minutos além da carga horária, com limite de 2 horas
     */
    public void calcularHorasExtras(double cargaHorariaDiaria) {
        calcularHorasTrabalhadas();
        
        // Calcula o excedente da carga horária
        double horasExcedentes = totalHorasTrabalhadas - cargaHorariaDiaria;
        
        // Só considera hora extra se exceder a carga horária em pelo menos 30 minutos
        if (horasExcedentes >= LIMITE_MINIMO_HORAS_EXTRAS) {
            // Calcula horas extras, limitando a 2 horas
            horasExtras = Math.min(horasExcedentes, LIMITE_MAXIMO_HORAS_EXTRAS);
        } else {
            // Menos de 30 minutos não conta como hora extra
            horasExtras = 0;
        }
    }
    
    /**
     * Verifica se todos os eventos de ponto do dia foram registrados
     */
    public boolean isPontoCompleto() {
        return horaEntrada != null && 
               horaSaida != null && 
               // Considera duas possibilidades: com almoço ou sem almoço
               ((horaSaidaAlmoco != null && horaRetornoAlmoco != null) || 
                (horaSaidaAlmoco == null && horaRetornoAlmoco == null));
    }
    
    /**
     * Obtem uma representação em string do registro de ponto
     */
    @Override
    public String toString() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat sdfHora = new SimpleDateFormat("HH:mm:ss");
        StringBuilder sb = new StringBuilder();
        
        sb.append("Registro de Ponto - ").append(sdf.format(data)).append("\n");
        sb.append("Funcionário: ").append(registroFuncionario).append("\n");
        
        if (horaEntrada != null) 
            sb.append("Entrada: ").append(sdfHora.format(horaEntrada)).append("\n");
            
        if (horaSaidaAlmoco != null) 
            sb.append("Saída Almoço: ").append(sdfHora.format(horaSaidaAlmoco)).append("\n");
            
        if (horaRetornoAlmoco != null) 
            sb.append("Retorno Almoço: ").append(sdfHora.format(horaRetornoAlmoco)).append("\n");
            
        if (horaSaida != null) 
            sb.append("Saída: ").append(sdfHora.format(horaSaida)).append("\n");
        
        if (tempoAlmoco > 0)
            sb.append("Tempo de Almoço: ").append(formatarHoras(tempoAlmoco)).append("\n");
            
        sb.append("Horas Trabalhadas: ").append(formatarHoras(totalHorasTrabalhadas)).append("\n");
        
        if (horasExtras > 0)
            sb.append("Horas Extras: ").append(formatarHoras(horasExtras)).append("\n");
        
        return sb.toString();
    }
    
    /**
     * Formata horas em formato decimal para o formato HH:MM
     */
    private String formatarHoras(double horas) {
        int horasInteiras = (int) horas;
        int minutos = (int) Math.round((horas - horasInteiras) * 60);
        
        if (minutos == 60) {
            horasInteiras++;
            minutos = 0;
        }
        
        return String.format("%02d:%02d", horasInteiras, minutos);
    }
}