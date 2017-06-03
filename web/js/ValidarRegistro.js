/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.addEventListener("load", iniciar, false);

function iniciar()
{
    nick = document.getElementById("nick");
    nick.addEventListener("input", validacion, false);

    dni = document.getElementById("dni");
    dni.addEventListener("input", validacion, false);

    correo = document.getElementById("correo");
    correo.addEventListener("input", validacion, false);

    clave = document.getElementById("clave");
    clave.addEventListener("input", validacion, false);

    fnac = document.getElementById("fnac");
    fnac.addEventListener("input", validacion, false);

    tlf = document.getElementById("tlf");
    tlf.addEventListener("input", validacion, false);

    validacion();
}

function validacion()
{
    validarNick(nick.value);
    validarDni(dni.value);
    validarCorreo(correo.value);
    validarClave(clave.value);
    validarFechaNacimiento(fnac.value);
    validarTelefono(tlf.value);
}

function validarNick(pNick)
{
    var ex = /^[a-zA-Z0-9-_.]{4,16}$/;

    if (ex.test(pNick) || pNick === '')
    {
        nick.style.background = '#FFFFFF';
        return true;
    } else
    {
        nick.style.background = '#FFDDDD';
        return false;
    }
}

function validarDni(pDni)
{
    var numero;
    var letra;
    var cadena;
    var er = /^\d{8}[a-zA-Z]$/;

    if (pDni === '')
    {
        dni.style.background = '#FFFFFF';
        return true;
    } else if (er.test(pDni) === true)
    {
        numero = pDni.substr(0, pDni.length - 1);
        letra = pDni.substr(pDni.length - 1, 1);
        numero = numero % 23;
        cadena = 'TRWAGMYFPDXBNJZSQVHLCKET';
        cadena = cadena.substring(numero, numero + 1);

        if (cadena !== letra.toUpperCase())
        {
            dni.style.background = '#FFDDDD';
            return false;
        } else
        {
            dni.style.background = '#FFFFFF';
            return true;
        }
    } else
    {
        dni.style.background = '#FFDDDD';
        return false;
    }
}

function validarCorreo(pCorreo)
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

function validarClave(pClave)
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

function validarFechaNacimiento(pFnac)
{
    var hoy = new Date();

    if (fnac !== '')
        pFnac = new Date(fnac.value);

    if (pFnac <= hoy || fnac.value === '')
    {
        fnac.style.background = '#FFFFFF';
        return true;
    } else
    {
        fnac.style.background = '#FFDDDD';
        return false;
    }
}

function validarTelefono(pTlf)
{
    var ex = /^\d{9}$/;

    if (ex.test(pTlf) || pTlf === '')
    {
        tlf.style.background = '#FFFFFF';
        return true;
    } else
    {
        tlf.style.background = '#FFDDDD';
        return false;
    }
}

function comprobarRegistro()
{
    nick = document.getElementById("nick");
    correo = document.getElementById("correo");
    clave = document.getElementById("clave");
    tlf = document.getElementById("tlf");

    if (nick.value === '' || validarNick(nick.value) === false)
    {
        nick.style.background = '#FFDDDD';
        nick.focus();
        return false;
    } else if (correo.value === '' || validarCorreo(correo.value) === false)
    {
        correo.style.background = '#FFDDDD';
        correo.focus();
        return false;
    } else if (clave.value === '' || validarClave(clave.value) === false)
    {
        clave.style.background = '#FFDDDD';
        clave.focus();
        return false;
    } else if (tlf.value === '' || validarTelefono(tlf.value) === false)
    {
        tlf.style.background = '#FFDDDD';
        tlf.focus();
        return false;
    } else if (validarDni(dni.value) === false)
    {
        dni.style.background = '#FFDDDD';
        dni.focus();
        return false;
    } else if (validarFechaNacimiento(fnac.value) === false)
    {
        fnac.style.background = '#FFDDDD';
        fnac.focus();
        return false;
    } else
    {
        return true;
    }
}