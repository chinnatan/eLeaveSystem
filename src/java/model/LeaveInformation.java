/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Blob;
import java.util.Date;

/**
 *
 * @author kornc
 */
public class LeaveInformation {

    private String category;
    private Date dateDocument;
    private String firstname;
    private String lastname;
    private String studentId;
    private String studentTerm;
    private String studentYear;
    private String studentGeneration;
    private String studentBranch;
    private String studentDegree;
    private String studentDescription;
    private String studentAttachment1;
    private String studentAttachment2;
    private String studentAttachment3;
    private Date studentDateFrom;
    private Date studentDateTo;
    private String studentDateTotal;
    private String leaveType;
    private String leaveYear;
    private String leaveId;
    private String advisorName;

    public LeaveInformation() {
        
    }

    /**
     * @return the category
     */
    public String getCategory() {
        return category;
    }

    /**
     * @param category the category to set
     */
    public void setCategory(String category) {
        this.category = category;
    }

    /**
     * @return the dateDocument
     */
    public Date getDateDocument() {
        return dateDocument;
    }

    /**
     * @param dateDocument the dateDocument to set
     */
    public void setDateDocument(Date dateDocument) {
        this.dateDocument = dateDocument;
    }

    /**
     * @return the firstname
     */
    public String getFirstname() {
        return firstname;
    }

    /**
     * @param firstname the firstname to set
     */
    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    /**
     * @return the lastname
     */
    public String getLastname() {
        return lastname;
    }

    /**
     * @param lastname the lastname to set
     */
    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    /**
     * @return the studentId
     */
    public String getStudentId() {
        return studentId;
    }

    /**
     * @param studentId the studentId to set
     */
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    /**
     * @return the studentTerm
     */
    public String getStudentTerm() {
        return studentTerm;
    }

    /**
     * @param studentTerm the studentTerm to set
     */
    public void setStudentTerm(String studentTerm) {
        this.studentTerm = studentTerm;
    }

    /**
     * @return the studentYear
     */
    public String getStudentYear() {
        return studentYear;
    }

    /**
     * @param studentYear the studentYear to set
     */
    public void setStudentYear(String studentYear) {
        this.studentYear = studentYear;
    }

    /**
     * @return the studentGeneration
     */
    public String getStudentGeneration() {
        return studentGeneration;
    }

    /**
     * @param studentGeneration the studentGeneration to set
     */
    public void setStudentGeneration(String studentGeneration) {
        this.studentGeneration = studentGeneration;
    }

    /**
     * @return the studentBranch
     */
    public String getStudentBranch() {
        return studentBranch;
    }

    /**
     * @param studentBranch the studentBranch to set
     */
    public void setStudentBranch(String studentBranch) {
        this.studentBranch = studentBranch;
    }

    /**
     * @return the studentDegree
     */
    public String getStudentDegree() {
        return studentDegree;
    }

    /**
     * @param studentDegree the studentDegree to set
     */
    public void setStudentDegree(String studentDegree) {
        this.studentDegree = studentDegree;
    }

    /**
     * @return the studentDescription
     */
    public String getStudentDescription() {
        return studentDescription;
    }

    /**
     * @param studentDescription the studentDescription to set
     */
    public void setStudentDescription(String studentDescription) {
        this.studentDescription = studentDescription;
    }

    /**
     * @return the studentDateFrom
     */
    public Date getStudentDateFrom() {
        return studentDateFrom;
    }

    /**
     * @param studentDateFrom the studentDateFrom to set
     */
    public void setStudentDateFrom(Date studentDateFrom) {
        this.studentDateFrom = studentDateFrom;
    }

    /**
     * @return the studentDateTo
     */
    public Date getStudentDateTo() {
        return studentDateTo;
    }

    /**
     * @param studentDateTo the studentDateTo to set
     */
    public void setStudentDateTo(Date studentDateTo) {
        this.studentDateTo = studentDateTo;
    }

    /**
     * @return the studentDateTotal
     */
    public String getStudentDateTotal() {
        return studentDateTotal;
    }

    /**
     * @param studentDateTotal the studentDateTotal to set
     */
    public void setStudentDateTotal(String studentDateTotal) {
        this.studentDateTotal = studentDateTotal;
    }

    /**
     * @return the leaveType
     */
    public String getLeaveType() {
        return leaveType;
    }

    /**
     * @param leaveType the leaveType to set
     */
    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    

    /**
     * @return the leaveYear
     */
    public String getLeaveYear() {
        return leaveYear;
    }

    /**
     * @param leaveYear the leaveYear to set
     */
    public void setLeaveYear(String leaveYear) {
        this.leaveYear = leaveYear;
    }

    /**
     * @return the leaveId
     */
    public String getLeaveId() {
        return leaveId;
    }

    /**
     * @param leaveId the leaveId to set
     */
    public void setLeaveId(String leaveId) {
        this.leaveId = leaveId;
    }

    /**
     * @return the studentAttachment1
     */
    public String getStudentAttachment1() {
        return studentAttachment1;
    }

    /**
     * @param studentAttachment1 the studentAttachment1 to set
     */
    public void setStudentAttachment1(String studentAttachment1) {
        this.studentAttachment1 = studentAttachment1;
    }

    /**
     * @return the studentAttachment2
     */
    public String getStudentAttachment2() {
        return studentAttachment2;
    }

    /**
     * @param studentAttachment2 the studentAttachment2 to set
     */
    public void setStudentAttachment2(String studentAttachment2) {
        this.studentAttachment2 = studentAttachment2;
    }

    /**
     * @return the studentAttachment3
     */
    public String getStudentAttachment3() {
        return studentAttachment3;
    }

    /**
     * @param studentAttachment3 the studentAttachment3 to set
     */
    public void setStudentAttachment3(String studentAttachment3) {
        this.studentAttachment3 = studentAttachment3;
    }

    /**
     * @return the advisorName
     */
    public String getAdvisorName() {
        return advisorName;
    }

    /**
     * @param advisorName the advisorName to set
     */
    public void setAdvisorName(String advisorName) {
        this.advisorName = advisorName;
    }
    
    
}
