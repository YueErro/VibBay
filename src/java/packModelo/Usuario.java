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
public class Usuario {

    private String nick;
    private String dni;
    private String correo;
    private String pass;
    private String fnac;
    private String genero;
    private int tlf;
    private String foto;

    public Usuario(String pNick, String pDni, String pCorreo,
            String pPass, String pFnac, String pGenero,
            int pTlf, String pFoto) {
        nick = pNick;
        dni = pDni;
        correo = pCorreo;
        pass = pPass;
        fnac = pFnac;
        genero = pGenero;
        tlf = pTlf;
        foto = pFoto;
    }

    public String getNick() {
        return nick;
    }

    public void setNick(String nick) {
        this.nick = nick;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getFnac() {
        return fnac;
    }

    public void setFnac(String fnac) {
        this.fnac = fnac;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public int getTlf() {
        return tlf;
    }

    public void setTlf(int tlf) {
        this.tlf = tlf;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }
}