// Colocar em um include
function ContarTexto(elemento, tamanho, legenda)
{
	if ((event.keyCode < '37' || event.keyCode > '40') && (event.keyCode != 46) && (event.keyCode != 08) && (event.keyCode != 09) )
	{
		elemento1 = elemento.value;
		elemento2 = elemento1.length;
		if (elemento2 > tamanho)
		{
			event.returnValue=false;
			elemento.value=elemento.value.substr(0,tamanho);
			alert("Você já digitou o limite máximo de " + tamanho + " caracteres");
			elemento.focus();
			return false;
		}
	}

	if (legenda!="")
	{
		elemento2 = elemento.value.length;
		aux = eval(legenda);

		if (event.keyCode == "8")
		{
			aux.innerHTML = (parseInt(tamanho) - parseInt(elemento2) ) + " caracteres restantes";
		}else{
			aux.innerHTML = (parseInt(tamanho) - parseInt(elemento2) ) + " caracteres restantes";
		}
	}
}

