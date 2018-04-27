/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.List;

/**
 *
 * @author kornc
 */
public class AccountInformation {
    
    private String firstname;
    private String lastname;
    private String student_id;
    private String email;
    private String professor_name;
    private List<String> class_id;
    private String student_degree;
    private String student_branch;
    private int student_year;
    private int student_term;
    private int generation_id;
    private int section_no;
    
    public AccountInformation () {
        
    }
    
    public AccountInformation (String firstname, String lastname, 
            String student_id, String email,
            String professor_name, String student_degree, 
            String student_branch, int student_year, 
            int student_term, int generation_id, int section_no) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.student_id = student_id;
        this.email = email;
        this.professor_name = professor_name;
        this.student_year = student_year;
        this.student_term = student_term;
        this.generation_id = generation_id;
        this.section_no = section_no;
        this.student_degree = student_degree;
        this.student_branch = student_branch;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getStudent_id() {
        return student_id;
    }

    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public int getStudent_year() {
        return student_year;
    }

    public void setStudent_year(int student_year) {
        this.student_year = student_year;
    }

    public int getStudent_term() {
        return student_term;
    }

    public void setStudent_term(int student_term) {
        this.student_term = student_term;
    }

    public int getGeneration_id() {
        return generation_id;
    }

    public void setGeneration_id(int generation_id) {
        this.generation_id = generation_id;
    }

    public int getSection_no() {
        return section_no;
    }

    public void setSection_no(int section_no) {
        this.section_no = section_no;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getProfessor_name() {
        return professor_name;
    }

    public void setProfessor_name(String professor_name) {
        this.professor_name = professor_name;
    }

    public String getStudent_degree() {
        return student_degree;
    }

    public void setStudent_degree(String student_degree) {
        this.student_degree = student_degree;
    }

    public String getStudent_branch() {
        return student_branch;
    }

    public void setStudent_branch(String student_branch) {
        this.student_branch = student_branch;
    }

    public List<String> getClass_id() {
        return class_id;
    }

    public void setClass_id(List<String> class_id) {
        this.class_id = class_id;
    }
    
    
}
