package pontodefuncionario.model;

/**
 * Classe que representa um administrador no sistema de ponto
 */
public class Administrador {
    private int idAdmin;
    private String username;
    private String senha;
    private String nome;
    
    /**
     * Construtor para criar um administrador
     */
    public Administrador(int idAdmin, String username, String senha, String nome) {
        this.idAdmin = idAdmin;
        this.username = username;
        this.senha = senha;
        this.nome = nome;
    }
    
    // Getters e Setters
    public int getIdAdmin() {
        return idAdmin;
    }
    
    public void setIdAdmin(int idAdmin) {
        this.idAdmin = idAdmin;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getSenha() {
        return senha;
    }
    
    public void setSenha(String senha) {
        this.senha = senha;
    }
    
    public String getNome() {
        return nome;
    }
    
    public void setNome(String nome) {
        this.nome = nome;
    }
    
    /**
     * Verifica se as credenciais informadas são válidas
     */
    public boolean verificarCredenciais(String username, String senha) {
        return this.username.equals(username) && this.senha.equals(senha);
    }
}