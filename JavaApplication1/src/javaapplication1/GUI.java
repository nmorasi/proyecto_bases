/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication1;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nieves
 */
public class GUI extends javax.swing.JFrame {

    /**
     * Creates new form GUI
     */
    public GUI() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jTabbedPane1 = new javax.swing.JTabbedPane();
        jPanel1 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        dentro_cu = new javax.swing.JCheckBox();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        origen = new javax.swing.JTextField();
        destino = new javax.swing.JTextField();
        solicitar_viaje = new javax.swing.JButton();
        jTextField1 = new javax.swing.JTextField();
        jCheckBox1 = new javax.swing.JCheckBox();
        jPanel2 = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();
        nom_chofer = new javax.swing.JTextField();
        ver_ganancias = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jLabel1.setText("Id de cliente:");

        dentro_cu.setText("Dentro de CU");
        dentro_cu.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                dentro_cuActionPerformed(evt);
            }
        });

        jLabel2.setText("¿Dónde estás?:");

        jLabel3.setText("¿A dónde vas?");

        origen.setText("origen");
        origen.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                origenActionPerformed(evt);
            }
        });

        destino.setText("destino");

        solicitar_viaje.setText("Solicitar viaje");
        solicitar_viaje.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                solicitar_viajeActionPerformed(evt);
            }
        });

        jTextField1.setText("jTextField1");
        jTextField1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextField1ActionPerformed(evt);
            }
        });

        jCheckBox1.setText("Quieres compañia?");
        jCheckBox1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jCheckBox1ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addGroup(jPanel1Layout.createSequentialGroup()
                            .addComponent(dentro_cu)
                            .addGap(51, 51, 51)
                            .addComponent(jCheckBox1))
                        .addGroup(jPanel1Layout.createSequentialGroup()
                            .addComponent(jLabel1)
                            .addGap(18, 18, 18)
                            .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGroup(jPanel1Layout.createSequentialGroup()
                            .addComponent(jLabel2)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                            .addComponent(origen))
                        .addGroup(jPanel1Layout.createSequentialGroup()
                            .addComponent(jLabel3)
                            .addGap(18, 18, 18)
                            .addComponent(destino, javax.swing.GroupLayout.PREFERRED_SIZE, 522, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addComponent(solicitar_viaje))
                .addContainerGap(382, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(dentro_cu)
                    .addComponent(jCheckBox1))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(origen, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(46, 46, 46)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel3)
                    .addComponent(destino, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(38, 38, 38)
                .addComponent(solicitar_viaje)
                .addContainerGap(256, Short.MAX_VALUE))
        );

        jCheckBox1.getAccessibleContext().setAccessibleName("compañia");
        jCheckBox1.getAccessibleContext().setAccessibleDescription("");

        jTabbedPane1.addTab("Cliente", jPanel1);
        jPanel1.getAccessibleContext().setAccessibleName("compañia");

        jLabel4.setText("Nombre de Chofer:");

        nom_chofer.setText("nom_chofer");
        nom_chofer.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                nom_choferActionPerformed(evt);
            }
        });

        ver_ganancias.setText("Ver ganancias");
        ver_ganancias.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ver_gananciasActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jLabel4)
                        .addGap(18, 18, 18)
                        .addComponent(nom_chofer, javax.swing.GroupLayout.PREFERRED_SIZE, 323, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(348, 348, 348)
                        .addComponent(ver_ganancias)))
                .addContainerGap(546, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGap(19, 19, 19)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel4)
                    .addComponent(nom_chofer, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(95, 95, 95)
                .addComponent(ver_ganancias)
                .addContainerGap(336, Short.MAX_VALUE))
        );

        jTabbedPane1.addTab("Chofer", jPanel2);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jTabbedPane1)
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jTabbedPane1)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void dentro_cuActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_dentro_cuActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_dentro_cuActionPerformed

    private void solicitar_viajeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_solicitar_viajeActionPerformed
        // TODO add your handling code here:
        JavaApplication1 ja = new JavaApplication1();
        try{
            //aqui deberia guardar en la base de datos
            boolean comp = false;
            String tipo = "externo";
            if(dentro_cu.isSelected()){
                System.out.println("lo estas seleccionando el de cu");
                tipo = "interno";
            }
            if (jCheckBox1.isSelected()){
                System.out.println("estas seleccionando el de compania");
                comp = true;
            }
            int id_viaje = Integer.parseInt(jTextField1.getText());
            ja.ingresar_info(id_viaje,tipo,comp);
            ResultSet rs = ja.tuplas_viaje(id_viaje);
            java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                try {
                    new InfoViaje(rs).setVisible(true);
                } catch (SQLException ex) {
                    Logger.getLogger(GUI.class.getName()).log(Level.SEVERE, null, ex);
                }
                }
            });
        }catch(SQLException e){
            e.printStackTrace();
            System.out.println("ocurrio un error");
        }
    }//GEN-LAST:event_solicitar_viajeActionPerformed

    private void nom_choferActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_nom_choferActionPerformed
        // TODO add your handling code here:
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Ganancias(Integer.parseInt(nom_chofer.getText())).setVisible(true);
            }
        });
    }//GEN-LAST:event_nom_choferActionPerformed

    private void ver_gananciasActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ver_gananciasActionPerformed
        // TODO add your handling code here:
         java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Ganancias(Integer.parseInt(nom_chofer.getText())).setVisible(true);
            }
        });
         
    }//GEN-LAST:event_ver_gananciasActionPerformed

    private void origenActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_origenActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_origenActionPerformed

    private void jTextField1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextField1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jTextField1ActionPerformed

    private void jCheckBox1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jCheckBox1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jCheckBox1ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(GUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(GUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(GUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(GUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new GUI().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JCheckBox dentro_cu;
    private javax.swing.JTextField destino;
    private javax.swing.JCheckBox jCheckBox1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JTabbedPane jTabbedPane1;
    private javax.swing.JTextField jTextField1;
    private javax.swing.JTextField nom_chofer;
    private javax.swing.JTextField origen;
    private javax.swing.JButton solicitar_viaje;
    private javax.swing.JButton ver_ganancias;
    // End of variables declaration//GEN-END:variables
}
