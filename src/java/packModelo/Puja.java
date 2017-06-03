/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packModelo;

/**
 *
 * @author YI
 */
public class Puja {

    private String fecha;
    private String email;
    private int codArticulo;
    private double cantidad;

    public Puja(String pFecha, String pEmail, int pCodArt, double pCant) {
        fecha = pFecha;
        email = pEmail;
        codArticulo = pCodArt;
        cantidad = pCant;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getCodArticulo() {
        return codArticulo;
    }

    public void setCodArticulo(int codArticulo) {
        this.codArticulo = codArticulo;
    }

    public double getCantidad() {
        return cantidad;
    }

    public void setCantidad(double cantidad) {
        this.cantidad = cantidad;
    }
}