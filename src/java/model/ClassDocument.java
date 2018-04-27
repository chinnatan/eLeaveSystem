/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kornc
 */
public class ClassDocument {

    private Connection conn;
    private List<ClassInformation> classDoc;

    public ClassDocument() {

    }

    public ClassDocument(Connection conn) {
        this.conn = conn;
        classDoc = new LinkedList<ClassInformation>();
    }

    public void addClass(String leaveId) {
        try {
            Statement stmtClass = conn.createStatement();
            String sqlClassQuery = "select * "
                    + "from webpro_02_test.leavedocument "
                    + "join webpro_02_test.leavedocument_section "
                    + "on (leavedocument.leave_id = leavedocument_section.leavedocument_leave_id) "
                    + "join webpro_02_test.section "
                    + "on (section.section_id = leavedocument_section.section_section_id) "
                    + "join webpro_02_test.class "
                    + "on (class.class_id = section.class_class_id) "
                    + "where leave_id = '" + leaveId + "'";
            ResultSet rsClass = stmtClass.executeQuery(sqlClassQuery);
            while (rsClass.next()) {
                ClassInformation cd = new ClassInformation();
                cd.setClassId(rsClass.getString("class_id"));
                cd.setClassName(rsClass.getString("class_name"));
                cd.setClassDate(rsClass.getDate("date"));
                cd.setClassStatus(rsClass.getString("status"));
                cd.setClassNote(rsClass.getString("note"));
                cd.setClassProfessor(rsClass.getString("professor_name"));
                classDoc.add(cd);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDocument.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * @return the classDoc
     */
    public List<ClassInformation> getClassDoc() {
        return classDoc;
    }

    /**
     * @param classDoc the classDoc to set
     */
    public void setClassDoc(List<ClassInformation> classDoc) {
        this.classDoc = classDoc;
    }

}
