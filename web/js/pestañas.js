/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function activarTab(unTab)
{
    try
    {
        var id = unTab.id;

        if (id)
        {
            var tr = unTab.parentNode || unTab.parentElement;
            var tbody = tr.parentNode || tr.parentElement;
            var table = tbody.parentNode || tbody.parentElement;

            if (table.getAttribute("data-filas") !== null) {
                var filas = tbody.getElementsByTagName("tr");
                var filaDiv = filas[filas.length - 1];
                tbody.insertBefore(tr, filaDiv);
            }

            var desde = table.getAttribute("data-min");
            if (desde === null)
                desde = 0;
            var hasta = table.getAttribute("data-max");
            if (hasta === null)
                hasta = MAXTABS;
            var idTab = id.split("tabck-");
            var numTab = parseInt(idTab[1]);
            var esteTabDiv = document.getElementById("tabdiv-" + numTab);

            for (var i = desde; i <= hasta; i++)
            {
                var tabdiv = document.getElementById("tabdiv-" + i);

                if (tabdiv)
                {
                    var tabck = document.getElementById("tabck-" + i);

                    if (tabdiv.id === esteTabDiv.id)
                    {
                        tabdiv.style.display = "block";
                        tabck.style.color = "white";
                        tabck.style.backgroundColor = "#75A3B0";
                        tabck.style.borderBottomColor = "#0A7492";
                    } else
                    {
                        tabdiv.style.display = "none";
                        tabck.style.color = "white";
                        tabck.style.backgroundColor = "#0A7492";
                        tabck.style.borderBottomColor = "#0A7492";
                    }
                }
            }
        }
    } catch (e)
    {
        alert("Error al activar una pestaña. " + e.message);
    }
}