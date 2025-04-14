package pontodefuncionario.model;

/**
 * Classe que representa um funcionário no sistema de ponto
 */
public class Funcionario {
    private int id;
    private String nome;
    private String cpf;
    private String cargo;
    private double cargaHoraria;
    private String registro;
    private boolean ativo;
    
    /**
     * Construtor básico para criar um funcionário
     */
    public Funcionario(int id, String nome, String cpf, String cargo, double cargaHoraria, String registro) {
        this.id = id;
        this.nome = nome;
        this.cpf = cpf;
        this.cargo = cargo;
        this.cargaHoraria = cargaHoraria;
        this.registro = registro;
        this.ativo = true;
    }
    
    // Getters e Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getNome() {
        return nome;
    }
    
    public void setNome(String nome) {
        this.nome = nome;
    }
    
    public String getCpf() {
        return cpf;
    }
    
    public void setCpf(String cpf) {
        this.cpf = cpf;
    }
    
    public String getCargo() {
        return cargo;
    }
    
    public void setCargo(String cargo) {
        this.cargo = cargo;
    }
    
    public double getCargaHoraria() {
        return cargaHoraria;
    }
    
    public void setCargaHoraria(double cargaHoraria) {
        this.cargaHoraria = cargaHoraria;
    }
    
    public String getRegistro() {
        return registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }
    
    public boolean isAtivo() {
        return ativo;
    }
    
    public void setAtivo(boolean ativo) {
        this.ativo = ativo;
    }
    
    @Override
    public String toString() {
        return nome + " (" + registro + ")";
    }
}