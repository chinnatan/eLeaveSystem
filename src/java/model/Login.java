/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author kornc
 */
public class Login {
    
    private String username;
    private String password;
    private String person_type;
    
    public Login() {
        
    }
    
    public Login(String username, String password, String person_type) {
        this.username = username;
        this.password = password;
        this.person_type = person_type;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPerson_type() {
        return person_type;
    }

    public void setPerson_type(String person_type) {
        this.person_type = person_type;
    }
    
}
