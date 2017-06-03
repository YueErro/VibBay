/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

window.addEventListener("load", iniciar, false);


function iniciar()
{
    puja = document.getElementById("pujaMax");
    puja.addEventListener("input", verificar, false);

    verificar();
}

function verificar()
{
    verificarPuja(puja.value);
}

function verificarPuja(pPuja)
{
    var ex = /^((\d{1,3}\.\d{3})|(\d{1,3})),\d{2}$/;

    if (ex.test(pPuja) || pPuja === '')
    {
        puja.style.background = '#FFFFFF';
        return true;
    } else
    {
        puja.style.background = '#FFDDDD';
        return false;
    }
}

function comprobarPuja()
{
    if (puja.value === '' || verificarPuja(puja.value) === false)
    {
        puja.style.background = '#FFDDDD';
        puja.focus();
        return false;
    } else
        return true;
}