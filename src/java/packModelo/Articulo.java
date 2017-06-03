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
public class Articulo {

    private Integer codigo;
    private String email;
    private String imagen;
    private String nombre;
    private String categoria;
    private String descripcion;
    private double precio;
    private String estado;
    private String fecha;

    public Articulo(Integer pCod, String pEmail, String pImagen,
            String pNom, String pCat, String pDesc,
            double pPrecio, String pEstado, String pFecha) {
        codigo = pCod;
        email = pEmail;
        imagen = pImagen;
        nombre = pNom;
        categoria = pCat;
        descripcion = pDesc;
        precio = pPrecio;
        estado = pEstado;
        fecha = pFecha;
    }

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
}