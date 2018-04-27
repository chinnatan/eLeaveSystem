/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author kornc
 */
public class ClassInformation {
    
    private String classId;
    private String className;
    private String classStatus;
    private String classProfessor;
    private Date classDate;
    private String classNote;
    
    public ClassInformation () {
        
    }

    /**
     * @return the classId
     */
    public String getClassId() {
        return classId;
    }

    /**
     * @param classId the classId to set
     */
    public void setClassId(String classId) {
        this.classId = classId;
    }

    /**
     * @return the className
     */
    public String getClassName() {
        return className;
    }

    /**
     * @param className the className to set
     */
    public void setClassName(String className) {
        this.className = className;
    }

    /**
     * @return the classNote
     */
    public String getClassNote() {
        return classNote;
    }

    /**
     * @param classNote the classNote to set
     */
    public void setClassNote(String classNote) {
        this.classNote = classNote;
    }

    /**
     * @return the classDate
     */
    public Date getClassDate() {
        return classDate;
    }

    /**
     * @param classDate the classDate to set
     */
    public void setClassDate(Date classDate) {
        this.classDate = classDate;
    }

    /**
     * @return the classProfessor
     */
    public String getClassProfessor() {
        return classProfessor;
    }

    /**
     * @param classProfessor the classProfessor to set
     */
    public void setClassProfessor(String classProfessor) {
        this.classProfessor = classProfessor;
    }

    /**
     * @return the classStatus
     */
    public String getClassStatus() {
        return classStatus;
    }

    /**
     * @param classStatus the classStatus to set
     */
    public void setClassStatus(String classStatus) {
        this.classStatus = classStatus;
    }
    
    
}
