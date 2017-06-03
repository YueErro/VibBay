/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

window.addEventListener("load", iniciar, false);

function iniciar()
{
    nombre = document.getElementById("nombre");
    nombre.addEventListener("input", verificacion, false);

    desc = document.getElementById("descripcion");
    desc.addEventListener("input", verificacion, false);

    precio = document.getElementById("preciomin");
    precio.addEventListener("input", verificacion, false);

    verificacion();
}

function verificacion()
{
    verificarNombre(nombre.value);
    verificarDescripcion(desc.value);
    verificarPrecio(precio.value);
}

function verificarNombre(pNombre)
{
    var ex = /^[a-zA-ZñÑ0-9-_ .*/'()%¡!¿?#$+]{1,500}$/;

    if (ex.test(pNombre) || pNombre === '')
    {
        nombre.style.background = '#FFFFFF';
        return true;
    } else
    {
        nombre.style.background = '#FFDDDD';
        return false;
    }
}

function verificarDescripcion(pDesc)
{
    var ex = /^[a-zA-ZñÑ0-9-_., */'\n()%¡!¿?#$+]{1,485}$/;

    if (ex.test(pDesc) || pDesc === '')
    {
        desc.style.background = '#FFFFFF';
        return true;
    } else
    {
        desc.style.background = '#FFDDDD';
        return false;
    }
}

function verificarPrecio(pPrecio)
{
    var ex = /^((\d{1,3}\.\d{3})|(\d{1,3})),\d{2}$/;

    if (ex.test(pPrecio) || pPrecio === '')
    {
        precio.style.background = '#FFFFFF';
        return true;
    } else
    {
        precio.style.background = '#FFDDDD';
        return false;
    }
}

function comprobarAnuncio()
{
    if (nombre.value === '' || verificarNombre(nombre.value) === false)
    {
        nombre.style.background = '#FFDDDD';
        nombre.focus();
        return false;
    } else if (desc.value === '' || verificarDescripcion(desc.value) === false)
    {
        desc.style.background = '#FFDDDD';
        desc.focus();
        return false;
    } else if (precio.value === '' || verificarPrecio(precio.value) === false)
    {
        precio.style.background = '#FFDDDD';
        precio.focus();
        return false;
    } else
        return true;
}