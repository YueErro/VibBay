/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.addEventListener('load', inicio, false);

function inicio()
{
    document.getElementById('foto').addEventListener('change', cargar, false);
}

function cargar(ev)
{
    var arch = new FileReader();
    arch.addEventListener('load', leer, false);
    arch.readAsDataURL(ev.target.files[0]);
}

function leer(ev)
{
    document.getElementById('imagen').style.backgroundImage = "url('" + ev.target.result + "')";
}