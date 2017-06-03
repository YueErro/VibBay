/* 
 * To change this license header, choose License Headers in Project Properties
 * To change this template file, choose Tools | Templates
 * and open the template in the editor
 */
window.addEventListener("load", iniciar, false);

function iniciar()
{
    correo = document.getElementById("correo");
    correo.addEventListener("input", comprobacion, false);

    clave = document.getElementById("clave");
    clave.addEventListener("input", comprobacion, false);

    comprobacion();
}

function comprobacion()
{
    comprobarCorreo(correo.value);
    comprobarClave(clave.value);
}

function comprobarCorreo(pCorreo)
{

    var ex = /^([a-zA-Z]+[a-zA-Z0-9._-]*)@{1}([a-zA-Z0-9\.]{2,})\.([a-zA-Z]{2,3})$/;

    if (ex.test(pCorreo) || pCorreo === '')
    {
        correo.style.background = '#FFFFFF';
        return true;
    } else
    {
        correo.style.background = '#FFDDDD';
        return false;
    }
}

function comprobarClave(pClave)
{
    var er = /^[a-zA-Z0-9]{4,16}$/;

    if (er.test(pClave) || pClave === '')
    {
        clave.style.background = '#FFFFFF';
        return true;
    } else
    {
        clave.style.background = '#FFDDDD';
        return false;
    }
}

function comprobarLogin()
{
    if (correo.value === '' || comprobarCorreo(correo.value) === false)
    {
        correo.style.background = '#FFDDDD';
        correo.focus();
        return false;
    } else if (clave.value === '' || comprobarClave(clave.value) === false)
    {
        clave.style.background = '#FFDDDD';
        clave.focus();
        return false;
    } else
    {
        return true;
    }
}