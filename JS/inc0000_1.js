var boolPressionouALT = false;
function DesabilitaHelp() {
    return false;
}
document.onhelp = DesabilitaHelp;
function CapturaTecla(evt) {
    var tecla = evt.keyCode;
    var retorno;
    if ((tecla == 112) || (tecla == 114) || (tecla == 116) || (tecla == 122)) {
        event.keyCode = 0;
        event.returnValue = false;
    }
    if (tecla == 18)
        boolPressionouALT = true;

    switch (tecla) {
        case 18:
            retorno = 'ALT';
            break;
        case 27:
            retorno = 'ESC';
            break;
        case 112:
            retorno = 'F1';
            break;
        case 113:
            retorno = 'F2';
            break;
        case 114:
            retorno = 'F3';
            break;
        case 115:
            retorno = 'F4';
            break;
        case 116:
            retorno = 'F5';
            break;
        case 117:
            retorno = 'F6';
            break;
        case 118:
            retorno = 'F7';
            break;
        case 119:
            retorno = 'F8';
            break;
        case 120:
            retorno = 'F9';
            break;
        case 121:
            retorno = 'F10';
            break;
        case 122:
            retorno = 'F11';
            break;
        case 123:
            retorno = 'F12';
            break;
        default:
            retorno = tecla;
    }
    return retorno;
}
function LiberaTeclaALT(evt) {
    var tecla = evt.keyCode;
    if (tecla == 18)
        boolPressionouALT = false;
}
function OrdenaCombo(Lista, Ordem, Selecionado) {
    var valor = new Array();
    var valor_ordenado = new Array();
    var tam = Lista.length;
    for (var j = 0; j < tam; j++) {
        if (Ordem == 'C')
            valor[j] = Lista[j].value + "$" + Lista[j].text;

        if (Ordem == 'D')
            valor[j] = Lista[j].text + "$" + Lista[j].value;
    }
    valor_ordenado = valor.sort();
    for (var j = 0; j < tam; j++) {
        i = valor_ordenado[j].indexOf("$");
        {
            Lista[j].value = valor_ordenado[j].substr(0, i);
            Lista[j].text = valor_ordenado[j].substr(i + 1, 100);
        }
        if (Ordem == 'D') {
            Lista[j].text = valor_ordenado[j].substr(0, i);
            Lista[j].value = valor_ordenado[j].substr(i + 1, 100);
        }
        if (Lista[j].value == Selecionado)
            Lista[j].selected = true;
    }
}
function ReloadIFramesSubMenu(pFuncao) {
    var objIFrame;
    var boolVisivel;
    var ind = 0;
    for (i = 1; i <= QtdIframes(); i++) {
        objIFrame = eval('parent.frames[\'I' + i + '\']');

        if (objIFrame.location != 'about:blank') {
            if (pFuncao == '')
                objIFrame.reexecute();
            else
                eval('objIFrame.' + pFuncao);

            eval('boolVisivel = (parent.document[\'all\'].I' + i + '.style.display == \'\')');

            if (boolVisivel)
                ind = i;
        }
    }
    if (ind != 0) {
        objIFrame = eval('parent.frames[\'I' + ind + '\']');
        objIFrame.focus();
    }
}
function CarregarSubMenu(strCodFuncao) {
}
function LimpaFrameSubMenu() {
    for (var i = 1; i <= QtdIframes(); i++)
        eval('parent.document[\'all\'].I' + i + '.src = \'\'');
    EscondeIndAlteracao();
}
function ExibeIndAlteracao() {
    document.forms['form01'].ind_alterado.value = 'S';
    window.top.frames['control'].IndAlteracao.style.display = '';
    return true;
}
function EscondeIndAlteracao() {
    parent.frames['control'].IndAlteracao.style.display = 'none';
}
function MontaXMLGrid(pNomeGrd, pNomeXML, pLimaText) {
    var txt_hidden = '';
    var oGrid;
    var txt_cod_funcao = '';
    var iFrm;
    if (pLimaText == null || pLimaText == "")
        pLimaText = '';
    if (pNomeXML == null || pNomeXML == "") {
        pNomeXML = '';
        pLimaText = 'S';
    }
    iFrm = RecuperarIFGrid(pNomeGrd);
    if (iFrm != "0") {
        try {
            var ind_alterado = parent.frames['I' + iFrm].document.form01.ind_alterado.value;
        } catch (e) {
            ind_alterado = "";
        }
        if (ind_alterado == "")
            return false;
        oGrid = eval("parent.frames['I'+iFrm]." + pNomeGrd + ".object");
        txt_cod_funcao = parent.frames["I" + iFrm].document.form01.pcf.value;
        txt_hidden = eval("document.form01.txt_XML_" + txt_cod_funcao);
        if (pLimaText == "S")
            txt_hidden.value = "";
        if (pNomeXML != "")
            txt_hidden.value = txt_hidden.value + oGrid.oLog.xml + "<" + pNomeXML + ">";
        else
            txt_hidden.value = txt_hidden.value + oGrid.oLog.xml;
    }
}
function RecuperarIFGrid(pNomeGrd) {
    var oGrid;
    for (var i = 1; i <= QtdIframes(); i++) {
        try {
            oGrid = eval("parent.frames['I'+i]." + pNomeGrd + ".object");
            return i;
        }
        catch (e) {
            oGrid = "";
        }
    }
    return 0;
}
function XMLFormulario2(pobjForm) {
    var v_posicao;
    var sXML = '';
    try {
        v_posicao = 100;
        if (pobjForm != null) {
            v_posicao = 200;
            sXML = montaXMLElements(pobjForm.elements);
        }

        return sXML;
    }
    catch (e) {
        alert('Erro ao executar a função "XMLFormulario2".\rJavaScript Erro: ' + e.description + '\rPosição: ' + v_posicao);
        return false;
    }
}
function montaXMLElements(pelementos) {
    var tot = pelementos.length;
    var sXML = '';
    var sNome;
    var i = 0;
    var v_posicao;
    try {
        v_posicao = 600;
        while (i < tot) {
            v_posicao = 700;
            if (pelementos[i].type == 'text' || pelementos[i].type == 'hidden' || pelementos[i].type == 'textarea') {
                v_posicao = 800;
                sXML += '<' + pelementos[i].name.toUpperCase() + '><![CDATA[';
                sXML += pelementos[i].value;
                sXML += ']]></' + pelementos[i].name.toUpperCase() + '>';
            }
            v_posicao = 900;
            if (pelementos[i].type == 'select-one') {
                sXML += '<' + pelementos[i].name.toUpperCase() + '>';
                sXML += pelementos[i].value;
                sXML += '</' + pelementos[i].name.toUpperCase() + '>';
            }
            v_posicao = 1000;
            if (pelementos[i].type == 'select-multiple') {
                v_posicao = 1100;
                var sSelected = '';
                sXML += '<' + pelementos[i].name.toUpperCase() + '>';
                for (var j = 0; j < pelementos[i].options.length; j++) {
                    if (pelementos[i].options[j].selected) {
                        if (sSelected != '')
                            sSelected += ',';
                        sSelected += pelementos[i].options[j].value;
                    }
                }
                sXML += sSelected;
                sXML += '</' + pelementos[i].name.toUpperCase() + '>';
            }
            v_posicao = 1200;
            if (pelementos[i].type == 'radio') {
                sNome = pelementos[i].name;
                while (sNome == pelementos[i].name) {
                    if (pelementos[i].checked) {
                        sXML += '<' + pelementos[i].name.toUpperCase() + '>';
                        sXML += pelementos[i].value;
                        sXML += '</' + pelementos[i].name.toUpperCase() + '>';
                    }
                    i++;
                }
                i--;
            }
            v_posicao = 1300;
            if (pelementos[i].type == 'checkbox') {
                if (pelementos[i].checked) {
                    sXML += '<' + pelementos[i].name.toUpperCase() + '>';
                    sXML += pelementos[i].value;
                    sXML += '</' + pelementos[i].name.toUpperCase() + '>';
                }
            }
            i++;
        }
        return sXML;
    }
    catch (e) {
        alert('Erro ao executar a função "montaXMLElements".\rJavaScript Erro: ' + e.description + '\rPosição: ' + v_posicao);
        return false;
    }
}
function MontaXMLForm() {
    for (i = 1; i <= QtdIframes(); i++) {
        XMLFormulario('I' + i);
    }
}
function XMLFormulario(pNomeIframe) {
    var v_posicao;
    var sXML = '';
    try {
        v_posicao = 100;
        if (pNomeIframe != null && pNomeIframe != "") {
            try {
                v_posicao = 200;
                var ind_alterado = parent.frames[pNomeIframe].document.form01.ind_alterado.value;
            }
            catch (e) {
                ind_alterado = "";
            }
            if (ind_alterado == "")
                return false;

            v_posicao = 300;
            var cod_funcao = parent.frames[pNomeIframe].document.form01.pcf.value;
            v_posicao = 400;
            var elementos = parent.frames[pNomeIframe].document.form01.elements;

        } else {
            v_posicao = 500;
            var elementos = document.form01.elements;
        }

        sXML = montaXMLElements(elementos);

        v_posicao = 1400;
        if (pNomeIframe != null && pNomeIframe != "") {
            v_posicao = 1500;
            var txt_XML = eval("parent.pesquisa.document.all['txt_XML_' + cod_funcao]");
            txt_XML.value = sXML;
            return true;
        } else {
            v_posicao = 1600;
            return sXML;
        }
    }
    catch (e) {
        alert('Erro ao executar a função "XMLFormulario".\rJavaScript Erro: ' + e.description + '\rPosição: ' + v_posicao);
        return false;
    }
}
function QtdIframes() {
    return parent.document['all'].qtd_iframes.value;
}
function SuportaTab() {
    if (typeof hasSupport.support != "undefined")
        return hasSupport.support;
    var ie55 = /msie 5\.[56789]/i.test(navigator.userAgent);
    hasSupport.support = (typeof document.implementation != "undefined" &&
document.implementation.hasFeature("html", "1.0") || ie55)
    if (ie55) {
        document._getElementsByTagName = document.getElementsByTagName;
        document.getElementsByTagName = function(sTagName) {
            if (sTagName == "*")
                return document.all;
            else
                return document._getElementsByTagName(sTagName);
        };
    }
    return hasSupport.support;
}
function validacao_hora(hora) {
    campo = eval("document.form01." + hora);
    var tamanho = campo.value.length;
    var hora = "", minuto = "", sep = "";
    var i;
    if (tamanho != 5) {
        return false;
    }
    for (i = 0; i < tamanho; i++) {
        if (i != 2) {
            if (!parseFloat(campo.value.charAt(i))) {
                if (campo.value.charAt(i) != '0') {
                    return false;
                }
            }
        }
        if (i < 2) {
            hora = (hora + campo.value.charAt(i));
        }
        if (i == 2) {
            sep = (sep + campo.value.charAt(i));
        }
        if (i > 2) {
            minuto = (minuto + campo.value.charAt(i));
        }
    }
    if (parseFloat(hora) < 0 || parseFloat(hora) > 23) {
        return false;
    }
    if (parseFloat(minuto) < 0 || parseFloat(hora) > 59) {
        return false;
    }
    if (sep != ':') {
        return false;
    }
    return true;
}

function comp_hora(hora_ini, hora_fim) {
    var hora1 = "", hora2 = "";
    var i, tamanho, campo;

    campo = eval("document.form01." + hora_ini);
    tamanho = campo.value.length;
    for (i = 0; i < tamanho; i++) {
        if (i != 2) {
            hora1 = (hora1 + campo.value.charAt(i));
        }
    }
    campo = eval("document.form01." + hora_fim);
    tamanho = campo.value.length;
    for (i = 0; i < tamanho; i++) {
        if (i != 2) {
            hora2 = (hora2 + campo.value.charAt(i));
        }
    }
    if (parseFloat(hora1) > parseFloat(hora2)) {
        return false;
    }
    return true;
}
function formata_hora(campo) {
    var valor, ini;
    elemento = eval("document.form01." + campo);
    valor = elemento.value;
    ini = parseInt(elemento.value.charAt(0) + elemento.value.charAt(1));
    if (ini == 24) {
        valor = "23:";
    }
    else {
        if (elemento.value.length == 1) {
            if (elemento.value > 2) {
                valor = "0" + elemento.value + ":";
            }
        }
        if (elemento.value.length == 2) {
            if (elemento.value > 24) {
                valor = elemento.value.charAt(0);
            }
            else {

                valor = elemento.value + ":";
            }
        }
        if (elemento.value.length == 4) {
            if (elemento.value.charAt(3) > 5) {
                valor = elemento.value.charAt(0) + elemento.value.charAt(1) + elemento.value.charAt(2);
            }
            else {
                valor = elemento.value;
            }
        }
    }
    return valor;
}
function MascIP() {
    var conteudo;
    conteudo = event.srcElement.value;
    if ((event.keyCode == '46') && (conteudo.indexOf(".") > 10)) {
        event.returnValue = false;
    }
    if ((event.keyCode < '48' || event.keyCode > '57') &&
(event.keyCode != '46') &&
(event.keyCode != '8'))
        event.returnValue = false;
}
function MascData(tipo) {
    var valor, novo_valor, mes;
    valor = event.srcElement.value;
    tipo = tipo.toUpperCase();
    if ((event.keyCode < '48' || event.keyCode > '57') && (event.keyCode != '8')) {
        event.returnValue = false;
    }
    else {
        novo_valor = event.srcElement.value + String.fromCharCode(event.keyCode);
        if ((tipo == 'MM/YYYY') && ((valor.length + 1) == 2)) {
            if (ValidaInfo(novo_valor, 'MM')) {
                event.srcElement.value = novo_valor + '/';
            }
            event.returnValue = false;
        }
        else {
            if (tipo == 'DD/MM/YYYY') {
                if ((valor.length + 1) == 2) {
                    if (ValidaInfo(novo_valor, 'DD'))
                        event.srcElement.value = novo_valor + '/';
                    event.returnValue = false;
                }
                if ((valor.length + 1) == 5) {
                    mes = novo_valor.substr(3, 2);
                    if (ValidaInfo(mes, 'MM'))
                        event.srcElement.value = novo_valor + '/';

                    event.returnValue = false;
                }
            }
        }
    }
}
function MascCpf() {
    var valor;
    valor = event.srcElement.value;
    if ((event.keyCode < '48' || event.keyCode > '57') &&
(event.keyCode != '8')) {
        event.returnValue = false;
    }
    else {
        if (((valor.length + 1) == 3) ||
((valor.length + 1) == 7)) {
            event.srcElement.value += String.fromCharCode(event.keyCode) + '.';
            event.returnValue = false;
        }
        else {
            if (((valor.length + 1) == 11)) {
                event.srcElement.value += String.fromCharCode(event.keyCode) + '-';
                event.returnValue = false;
            }
        }
    }
}
function MascCgc() {
    var valor;
    valor = event.srcElement.value;
    if ((event.keyCode < '48' || event.keyCode > '57') &&
(event.keyCode != '8')) {
        event.returnValue = false;
    }
    else {
        if (((valor.length + 1) == 2) ||
((valor.length + 1) == 6)) {
            event.srcElement.value += String.fromCharCode(event.keyCode) + '.';
            event.returnValue = false;
        }
        else {
            if (((valor.length + 1) == 10)) {
                event.srcElement.value += String.fromCharCode(event.keyCode) + '/';
                event.returnValue = false;
            }
            else {
                if (((valor.length + 1) == 15)) {
                    event.srcElement.value += String.fromCharCode(event.keyCode) + '-';
                    event.returnValue = false;
                }
            }
        }
    }
}
function MascCep() {
    var valor;
    valor = event.srcElement.value;
    if ((event.keyCode < '48' || event.keyCode > '57') &&
(event.keyCode != '8')) {
        event.returnValue = false;
    }
    else {
        if (((valor.length + 1) == 2)) {
            event.srcElement.value += String.fromCharCode(event.keyCode) + '.';
            event.returnValue = false;
        }
        else {
            if (((valor.length + 1) == 6)) {
                event.srcElement.value += String.fromCharCode(event.keyCode) + '-';
                event.returnValue = false;
            }
        }
    }
}
function MascHora() {
    var valor, novo_valor, minuto;
    valor = event.srcElement.value;
    if ((event.keyCode < '48' || event.keyCode > '57') &&
(event.keyCode != '8')) {
        event.keyCode = '';
        event.returnValue = false;
    }
    else {
        if (event.srcElement.value.length == 2) {
            event.srcElement.value = event.srcElement.value + ':'
        }
        novo_valor = event.srcElement.value + String.fromCharCode(event.keyCode);
        if ((valor.length + 1) == 2) {
            if (ValidaInfo(novo_valor, 'HH'))
                event.srcElement.value = novo_valor + ':';
            event.keyCode = '';
            event.returnValue = false;
        }
        if ((valor.length + 1) == 5) {
            minuto = novo_valor.substr(3, 2);
            if (ValidaInfo(minuto, 'MI'))
                event.srcElement.value = novo_valor;
            event.keyCode = '';
            event.returnValue = false;
        }
    }
    event.returnValue = true;
}
function MascNum() {
    var conteudo;
    conteudo = event.srcElement.value;
    if ((event.keyCode == '44') &&
(conteudo.indexOf(",") > 0))
        event.returnValue = false;
    if ((event.keyCode < '48' || event.keyCode > '57') &&
(event.keyCode != '44') &&
(event.keyCode != '8'))
        event.returnValue = false;
}
function MascInt() {
    var conteudo;
    conteudo = event.srcElement.value;
    if ((event.keyCode == '44'))
        event.returnValue = false;
    if ((event.keyCode < '48' || event.keyCode > '57'))
        event.returnValue = false;
}
function MascAlfa(bUpper, nTamanhoMaximo) {
    var tecla, novo_valor;
    if ((event.keyCode < '65' || event.keyCode > '90') &&
(event.keyCode < '97' || event.keyCode > '122') &&
(event.keyCode < '192' || event.keyCode > '196') &&
(event.keyCode < '199' || event.keyCode > '207') &&
(event.keyCode < '210' || event.keyCode > '214') &&
(event.keyCode < '217' || event.keyCode > '220') &&
(event.keyCode < '224' || event.keyCode > '228') &&
(event.keyCode < '231' || event.keyCode > '239') &&
(event.keyCode < '242' || event.keyCode > '246') &&
(event.keyCode < '249' || event.keyCode > '252') &&
(event.keyCode != '8') &&
(event.keyCode != '32') &&
(event.keyCode != '44') &&
(event.keyCode != '46') &&
(event.keyCode != '47') &&
(event.keyCode != '61') &&
(event.keyCode != '63') &&
(event.keyCode != '64') &&
(event.keyCode != '95')) {
        event.returnValue = false;
        return;
    }
    if (bUpper == true) {
        if (event.srcElement.value.length + 1 <= parseInt(nTamanhoMaximo)) {
            tecla = String.fromCharCode(event.keyCode);
            novo_valor = event.srcElement.value + tecla.toUpperCase();
            event.srcElement.value = novo_valor;
            event.returnValue = false;
        }
    }
    return;
}
function MascAlfaNum(bUpper, nTamanhoMaximo) {
    var tecla, novo_valor;
    if ((event.keyCode < '48' || event.keyCode > '57') &&
(event.keyCode < '65' || event.keyCode > '90') &&
(event.keyCode < '97' || event.keyCode > '122') &&
(event.keyCode < '192' || event.keyCode > '196') &&
(event.keyCode < '199' || event.keyCode > '207') &&
(event.keyCode < '210' || event.keyCode > '214') &&
(event.keyCode < '217' || event.keyCode > '220') &&
(event.keyCode < '224' || event.keyCode > '228') &&
(event.keyCode < '231' || event.keyCode > '239') &&
(event.keyCode < '242' || event.keyCode > '246') &&
(event.keyCode < '249' || event.keyCode > '252') &&
(event.keyCode != '8') &&
(event.keyCode != '32') &&
(event.keyCode != '44') &&
(event.keyCode != '46') &&
(event.keyCode != '47') &&
(event.keyCode != '38') &&
(event.keyCode != '61') &&
(event.keyCode != '63') &&
(event.keyCode != '64') &&
(event.keyCode != '95')) {
        event.returnValue = false;
        return;
    }

    if (bUpper == true) {
        if (event.srcElement.value.length + 1 <= parseInt(nTamanhoMaximo)) {
            tecla = String.fromCharCode(event.keyCode);
            novo_valor = event.srcElement.value + tecla.toUpperCase();
            event.srcElement.value = novo_valor;
            event.returnValue = false;
        }
    }
    return;
}
function ValidaPrecisaoNumero(vValor, vSeparador, vTamOracle, vDecOracle) {
    var contador = 0;
    var tamanho = 0;
    var pos_separador = 0;
    var nInteiros = 0;
    var nDecimais = 0;
    pos_separador = vValor.indexOf(vSeparador);
    tamanho = vValor.length;
    if (pos_separador == -1) {
        nInteiros = tamanho;
    }
    else {
        nInteiros = pos_separador;
        nDecimais = tamanho - (nInteiros + 1);
    }
    nMaxInteiros = parseInt(vTamOracle) - parseInt(vDecOracle);
    nMaxDecimais = parseInt(vDecOracle);
    if (nMaxInteiros < nInteiros) {
        alert("Número de casas inteiras inválida !!");
        return false;
    }
    if (nMaxDecimais < nDecimais) {
        alert("Número de casas decimais inválida !!");
        return false;
    }

    return true;
}

function IsDate(valor, tipo) {
    var data, dia = "", mes = "", ano = "";

    tipo = tipo.toUpperCase();

    if (tipo == 'DD/MM/YYYY') {
        data = valor;

        if (data.length != 10)
            return false;

        dia = valor.substr(0, 2);
        mes = valor.substr(3, 2);
        ano = valor.substr(6, 4);

        if ((mes < 1) || (mes > 12))
            return false;

        if ((dia < 1) || (dia > 31))
            return false;

        if (mes == 2) {
            if ((ano % 4 == 0) && (dia > 29))
                return false;

            if ((ano % 4 != 0) && (dia > 28))
                return false;

            if (ano < 1900)
                return false;
        }

        if (mes == 4 || mes == 6 || mes == 9 || mes == 11) {
            if (dia > 30)
                return false;
        }
    }
    else {
        if (tipo == 'MM/YYYY') {
            data = valor;

            if (data.length != 7)
                return false;

            mes = valor.substr(0, 2);
            ano = valor.substr(3, 4);

            if ((mes < 1) || (mes > 12))
                return false;
        }
    }

    return true;
}

function ComparaData(data1, data2, formato, comparacao) {
    if ((data1 != "") && (data2 != "")) {
        var strData1 = new String(data1);
        var strData2 = new String(data2);

        var dia1 = "";
        var mes1 = "";
        var ano1 = "";

        var dia2 = "";
        var mes2 = "";
        var ano2 = "";

        var dc1 = "";
        var dc2 = "";

        if (formato == 'DD/MM/YYYY') {
            dia1 = strData1.slice(0, 2);
            mes1 = strData1.slice(3, 5);
            ano1 = strData1.slice(6, 10);

            dia2 = strData2.slice(0, 2);
            mes2 = strData2.slice(3, 5);
            ano2 = strData2.slice(6, 10);

            dc1 = ano1 + mes1 + dia1;
            dc2 = ano2 + mes2 + dia2;
        }
        else {
            mes1 = strData1.slice(0, 2);
            ano1 = strData1.slice(3, 7);

            mes2 = strData2.slice(0, 2);
            ano2 = strData2.slice(3, 7);

            dc1 = ano1 + mes1;
            dc2 = ano2 + mes2;
        }

        expressao = eval("parseFloat(dc1) " + comparacao + " parseFloat(dc2)");
        if (expressao) {
            return true;
        }
    }
    return false;
}
function IsNumeric(valor) {
    for (var i = 0; i < valor.length; i++) {
        if (!parseFloat(valor.charAt(i))) {
            if (valor.charAt(i) != '0') {
                if (valor.charAt(i) != ',') {
                    return false;
                    break;
                }
            }
        }
    }
    return true;
}
function ValidaEmail(email) {
    var prim = email.value.indexOf("@");

    if (prim < 2) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf("@", prim + 1) != -1) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf(".") < 1) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf(" ") != -1) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf(".@") > 0) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf("@.") > 0) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf(".com.br.") > 0) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf("/") > 0) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf("[") > 0) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf("]") > 0) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf("(") > 0) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf(")") > 0) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    if (email.value.indexOf("..") > 0) {
        alert("E-mail inválido.");
        email.focus();
        email.select();
        return false;
    }

    return true;
}
function ContarTexto(elemento, tamanho, legenda) {
    if ((event.keyCode < '37' || event.keyCode > '40') &&
(event.keyCode != 46) && (event.keyCode != 08) && (event.keyCode != 09)) {
        elemento1 = elemento.value;
        elemento2 = elemento1.length;
        if (elemento2 > tamanho) {
            event.returnValue = false;
            elemento.value = elemento.value.substr(0, tamanho);
            alert("Você já digitou o limite máximo de " + tamanho + " caracteres");
            elemento.focus();
            return false;
        }
    }

    if (legenda != "") {
        elemento2 = elemento.value.length;
        aux = eval(legenda);

        if (event.keyCode == "8") {
            aux.innerHTML = (parseInt(tamanho) - parseInt(elemento2)) + " caracteres restantes";
        } else {
            aux.innerHTML = (parseInt(tamanho) - parseInt(elemento2)) + " caracteres restantes";
        }
    }
}
function HabilitaCampos(formulario) {
    elementos = document.forms[formulario].elements;

    tot = elementos.length;

    for (i = 0; i < tot; i++) {
        if (elementos[i].disabled == true) {
            elementos[i].disabled = false;
        }
    }
    return true;
}
function DesabilitaCampos(p_formulario, p_campo) {
    if (p_formulario == null) {
        p_formulario = 'form01';
    }

    var elementos = document.forms[p_formulario].elements;
    var tot = elementos.length;
    var e;

    for (var i = 0; i < tot; i++) {
        if (p_campo != null) {
            try {
                if (elementos[i].name.toUpperCase() == p_campo.toUpperCase() && elementos[i].disabled == false) {
                    elementos[i].disabled = true;

                    if (elementos[i].tagName != 'FIELDSET') {
                        elementos[i].className = 'camposblocks';

                    }

                    if (elementos[i].type == 'button') {
                        elementos[i].style.display = 'none';
                    }
                }
            }
            catch (e) {
            }
        }
        else {
            if (elementos[i].disabled == false) {
                if (elementos[i].tagName != 'FIELDSET') {
                    elementos[i].className = 'camposblocks';
                    elementos[i].disabled = true;
                }
                if (elementos[i].type == 'button') {
                    elementos[i].style.display = 'none';
                }
            }
        }
    }
    return true;
}
function ValidaInfo(valor, tipo) {
    tipo = tipo.toUpperCase();
    nvalor = parseInt(valor, 10);
    if (tipo == 'DD') {
        if (nvalor < 1 || nvalor > 31)
            return false;
    }
    else if (tipo == 'MM') {
        if (nvalor < 1 || nvalor > 12)
            return false;
    }
    else if (tipo == 'HH') {
        if (nvalor > 24)
            return false;
    }
    else if (tipo == 'MI') {
        if (nvalor > 59)
            return false;
    }
    return true;
}
function TeclaEnter(strFuncao) {
    if (event.keyCode == '13') {
        if (strFuncao == null) {
            event.keyCode = '9';
        }
        else {
            eval(strFuncao);
        }
    }
    return true;
}
function acao_continuar() {
    document.form01.submit();
}

function AbrePesquisa(urlPesq, img_name, Titulo, vWidth, vHeight, vTop, vLeft, vModal) {
return;
}
function AbrePesquisa2(urlPesq, img_name, Titulo, vWidth, vHeight, vTop, vLeft, vModal, vSubmit, vCodCampo) {
return;
}
function AbrePesquisaUnico(urlPesq, img_name, Titulo, vWidth, vHeight, vTop, vLeft) {
return;
}
function isCGC(x) {
    strNum = "";
    if (x == "") {
        return false;
    }
    cnpjO = x.replace(".", "");
    cnpjO = cnpjO.replace(".", "");
    cnpjO = cnpjO.replace("/", "");
    cnpjO = cnpjO.replace("-", "");
    x = cnpjO;
    l = x.length;
    for (i = 0; i < l; i++) {
        caracter = x.substring(i, i + 1)
        if ((caracter >= '0') && (caracter <= '9'))
            strNum = strNum + caracter;
    }
    strMul = "6543298765432";
    iValido = 1;
    if (strNum.length != 14)
        return (false);
    iSoma = 0;
    strNum_base = strNum.substring(0, 12);
    iLenNum_base = strNum_base.length - 1;
    iLenMul = strMul.length - 1;
    for (i = 0; i < 12; i++)
        iSoma = iSoma +
parseInt(strNum_base.substring((iLenNum_base - i), (iLenNum_base - i) + 1), 10) *
parseInt(strMul.substring((iLenMul - i), (iLenMul - i) + 1), 10)
    iSoma = 11 - (iSoma - Math.floor(iSoma / 11) * 11);
    if (iSoma == 11 || iSoma == 10)
        iSoma = 0;
    strNum_base = strNum_base + iSoma;
    iSoma = 0;
    iLenNum_base = strNum_base.length - 1
    for (i = 0; i < 13; i++)
        iSoma = iSoma +
parseInt(strNum_base.substring((iLenNum_base - i), (iLenNum_base - i) + 1), 10) *
parseInt(strMul.substring((iLenMul - i), (iLenMul - i) + 1), 10)
    iSoma = 11 - (iSoma - Math.floor(iSoma / 11) * 11);
    if (iSoma == 11 || iSoma == 10)
        iSoma = 0;
    strNum_base = strNum_base + iSoma;
    if (strNum != strNum_base)
        return (false);
    return (true);
}
function isCPF(st) {
    if (st == "") {
        return false;
    }
    st = st.replace(".", "");
    st = st.replace(".", "");
    st = st.replace("-", "");
    l = st.length;
    st2 = "";
    for (i = 0; i < l; i++) {
        caracter = st.substring(i, i + 1);
        if ((caracter >= '0') && (caracter <= '9'));
        st2 = st2 + caracter;
    }
    if ((st2.length > 11) || (st2.length < 10)) {
        return false;
    }
    if (st2.length == 10) {
        st2 = '0' + st2;
    }
    digito1 = st2.substring(9, 10);
    digito2 = st2.substring(10, 11);
    digito1 = parseInt(digito1, 10);
    digito2 = parseInt(digito2, 10);
    sum = 0; mul = 10;
    for (i = 0; i < 9; i++) {
        digit = st2.substring(i, i + 1);
        tproduct = parseInt(digit, 10) * mul;
        sum += tproduct;
        mul--;
    }
    dig1 = (sum % 11);
    if (dig1 == 0 || dig1 == 1) {
        dig1 = 0;
    } else {
        dig1 = 11 - dig1;
    }
    if (dig1 != digito1) {
        return false;
    }
    sum = 0;
    mul = 11;
    for (i = 0; i < 10; i++) {
        digit = st2.substring(i, i + 1);
        tproduct = parseInt(digit, 10) * mul;
        sum += tproduct;
        mul--;
    }
    dig2 = (sum % 11);
    if (dig2 == 0 || dig2 == 1) {
        dig2 = 0;
    } else {
        dig2 = 11 - dig2;
    }
    if (dig2 != digito2) {
        return false;
    }
    return true;
}
function esconder() {
    var cabec = document.all.item("cabec");
    if (isNaN(cabec.length)) {
        cabec.style.display = 'none';
    }
    else {
        tam = cabec.length;
        for (var i = 0; i < tam; i++) {
            cabec[i].style.display = 'none';
        }
    }

    var rodape = document.all.item("rodape");
    if (isNaN(rodape.length)) {
        rodape.style.display = 'none';
    }
    else {
        tam = rodape.length;
        for (var i = 0; i < tam; i++) {
            rodape[i].style.display = 'none';
        }
    }
}
function mostrar() {
    var cabec = document.all.item("cabec");
    if (isNaN(cabec.length)) {
        cabec.style.display = '';
    }
    else {
        tam = cabec.length;
        for (var i = 0; i < tam; i++) {
            cabec[i].style.display = '';
        }
    }
    var rodape = document.all.item("rodape");
    if (isNaN(rodape.length)) {
        rodape.style.display = '';
    }
    else {
        tam = rodape.length;
        for (var i = 0; i < tam; i++) {
            rodape[i].style.display = '';
        }
    }
}
/*var message="";

function clickIE() {
if (document.all) {
(message);
return false;
}
}

function clickNS(e){
if (document.layers||(document.getElementById&&!document.all)) {
if (e.which==2||e.which==3){
(message);
return false;
}
}
}

if (document.layers){
document.captureEvents(Event.MOUSEDOWN);
document.onmousedown=clickNS;
}else{
document.onmouseup=clickNS;document.oncontextmenu=clickIE;
}
document.oncontextmenu=new Function("return false")


*/

function MascValNeg() {
    var conteudo;
    conteudo = event.srcElement.value;
    if ((event.keyCode == '44') &&
(conteudo.indexOf(",") > -1))
        event.returnValue = false;
    if ((event.keyCode == '45') &&
((conteudo.indexOf("-") > -1) ||
(conteudo.indexOf(",") > -1)))
        event.returnValue = false;

    if ((event.keyCode < '48' || event.keyCode > '57') &&
(event.keyCode != '44') &&
(event.keyCode != '8') &&
(event.keyCode != '45'))
        event.returnValue = false;
}
function IsNumericNeg(valor) {
    if (valor.length == "1" && (valor == "-" || valor == ","))
        return false;
    if (valor.charAt(0) != "-" && valor.indexOf("-") > -1)
        return false;
    for (var i = 0; i < valor.length; i++) {
        if (!parseFloat(valor.charAt(i))) {
            if (valor.charAt(i) != '0') {
                if (valor.charAt(i) != ',') {
                    if (valor.charAt(i) != '-') {
                        return false;
                        break;
                    }
                }
            }
        }
    }
    return true;
}
function addRowDOM(tableID) {
    var table =
document.all ? document.all[tableID] :
document.getElementById(tableID);
    if (arguments.length > 1) {
        var row = table.insertRow(table.rows.length);
        if (document.all) {
            for (var i = 1; i < arguments.length; i++) {
                var cell = row.insertCell(i - 1);
                cell.innerHTML = arguments[i];
            }
        }
        else if (document.getElementById) {
            for (var i = arguments.length - 1; i >= 1; i--) {
                var cell = row.insertCell(arguments.length - 1 - i);
                cell.appendChild(document.createTextNode(arguments[i]));
            }
        }
    }
}
function stringReplace(originalString, findText, replaceText) {
    var pos = 0;
    var len = findText.length;
    originalString = originalString.toString();

    pos = originalString.indexOf(findText);
    while (pos != -1) {
        preString = originalString.substring(0, pos);
        postString = originalString.substring(pos + len, originalString.length);
        originalString = preString + replaceText + postString;
        pos = originalString.indexOf(findText);
    }

    return originalString;
}
function arredonda(pNumero, Casas) {
    var numero_round = "";
    var strNumero = pNumero.toString();
    var bol_negativo = false;
    var bol_tem_ponto = false;
    var strDecimal = "";
    var strDecimal_Fmt = "";
    var i = 0;
    if (pNumero < 0) {
        pNumero = pNumero * -1.00;
        strNumero = pNumero.toString();
        bol_negativo = true;
    }

    var nPonto = strNumero.indexOf(".");

    if (nPonto == -1) {
        numero_round = strNumero + ".00";
        bol_tem_ponto = true;
    }
    else {
        numero_round = strNumero.substr(0, nPonto + Casas + 1);
        numero_round = Math.round(1000 * numero_round) / 1000;
        strNumero = numero_round.toString();
        strInteiro = strNumero.substr(0, nPonto);
        strDecimal = strNumero.substr(nPonto + 1, Casas);
        i = 0;
        while (i < Casas) {
            if (strDecimal.charAt(i) == "") {
                strDecimal_Fmt = strDecimal_Fmt + "0";
            }
            else {
                strDecimal_Fmt = strDecimal_Fmt + strDecimal.charAt(i);
            }

            i = i + 1;
        }
        numero_round = strInteiro + "." + strDecimal_Fmt;
    }

    if (bol_negativo == false) {
        return numero_round;
    }
    else {
        return "-" + numero_round;
    }
}
function formataNumero(pNumero, Casas) {
    var numero_round = "";
    var strNumero = pNumero.toString();
    var bol_negativo = false;
    var bol_tem_ponto = false;
    var strDecimal = "";
    var strDecimal_Fmt = "";
    var i = 0;

    if (pNumero < 0) {
        pNumero = pNumero * -1.00;
        strNumero = pNumero.toString();
        bol_negativo = true;
    }
    strNumero = stringReplace(strNumero, ',', '.');

    var nPonto = strNumero.indexOf(".");

    if (nPonto == -1) {
        numero_round = strNumero + ".00";
        bol_tem_ponto = true;
    }
    else {
        numero_round = strNumero.substr(0, nPonto + Casas + 1);
        numero_round = Math.round(1000 * numero_round) / 1000;
        strNumero = numero_round.toString();
        strInteiro = strNumero.substr(0, nPonto);
        strDecimal = strNumero.substr(nPonto + 1, Casas);
        i = 0;
        while (i < Casas) {
            if (strDecimal.charAt(i) == "") {
                strDecimal_Fmt = strDecimal_Fmt + "0";
            }
            else {
                strDecimal_Fmt = strDecimal_Fmt + strDecimal.charAt(i);
            }

            i = i + 1;
        }
        numero_round = strInteiro + "." + strDecimal_Fmt;
    }
    numero_round = stringReplace(numero_round, '.', ',');

    if (bol_negativo == false) {
        return numero_round;
    }
    else {
        return "-" + numero_round;
    }
}
fillStringRight = function(str, fillStr, fillCount) {
    for (var t = '', x = 0; x < fillCount - String(str).length; x++)
        t += fillStr;
    return str + t;
};

fillStringLeft = function(str, fillStr, fillCount) {
    for (var t = '', x = 0; x < fillCount - String(str).length; x++)
        t += fillStr;
    return t + str;
};
function recuperaFrameNome(p_location, p_obj_principal) {
    var nome;
    var oparent;

    if (p_obj_principal != null) {
        oparent = p_obj_principal;
    }
    else {
        oparent = parent;
    }

    for (var i = 0; i < oparent.frames.length; i++) {
        if (oparent.frames[i].location.pathname.toUpperCase().indexOf(p_location.toUpperCase()) > -1) {
            nome = oparent.frames[i].name;
            break;
        }
    }

    return nome;
}
function recuperaFrameForm(p_location, p_obj_principal) {
    var oForm;
    var oparent;

    if (p_obj_principal != null) {
        oparent = p_obj_principal;
    }
    else {
        oparent = parent;
    }

    for (var i = 0; i < oparent.frames.length; i++) {
        if (oparent.frames[i].location.pathname.toUpperCase().indexOf(p_location.toUpperCase()) > -1) {
            oForm = oparent.frames[i].document.form01;
            break;
        }
    }

    return oForm;
}
function recuperaFrameDocument(p_location, p_obj_principal) {
    var oForm;
    var oparent;

    if (p_obj_principal != null) {
        oparent = p_obj_principal;
    }
    else {
        oparent = parent;
    }

    for (var i = 0; i < oparent.frames.length; i++) {
        if (oparent.frames[i].location.pathname.toUpperCase().indexOf(p_location.toUpperCase()) > -1) {
            oForm = oparent.frames[i].document;
            break;
        }
    }

    return oForm;
}
function getFieldXMLAjax(pObj, pNomeCampo, pLinha) {
    if (pLinha == null) {
        pLinha = 0;
    }

    if (pObj.getElementsByTagName(pNomeCampo)[pLinha].firstChild != null) {
        return pObj.getElementsByTagName(pNomeCampo)[pLinha].firstChild.nodeValue;
    }
    else {
        return '';
    }
}
function MontaStrSituacao() {
    var Str = "";
    Str = "&ind_nao_analisado=" + readCookie("26_ind_nao_analisado");
    Str = Str + "&ind_exigencia=" + readCookie("26_ind_exigencia");
    Str = Str + "&ind_pericia=" + readCookie("26_ind_pericia");
    Str = Str + "&ind_analise=" + readCookie("26_ind_analise");
    Str = Str + "&ind_digitacao=" + readCookie("26_ind_digitacao");
    Str = Str + "&ind_pend_exec=" + readCookie("26_ind_pend_exec");
    Str = Str + "&ind_liberacao=" + readCookie("26_ind_liberacao");
    Str = Str + "&cod_grupo_encaminhamento=" + readCookie("26_cod_grupo_encaminhamento");
    Str = Str + "&dt_ini_pendente=" + readCookie("26_dt_ini_pendente");
    Str = Str + "&dt_fim_pendente=" + readCookie("26_dt_fim_pendente");
    Str = Str + "&ind_negado=" + readCookie("26_ind_negado");
    Str = Str + "&ind_autorizado=" + readCookie("26_ind_autorizado");
    Str = Str + "&ind_cancelado=" + readCookie("26_ind_cancelado");
    Str = Str + "&dt_ini_analisado=" + readCookie("26_dt_ini_analisado");
    Str = Str + "&dt_fim_analisado=" + readCookie("26_dt_fim_analisado");
    Str = Str + "&cod_prestador=" + readCookie("26_cod_prestador");
    Str = Str + "&num_contrato=" + readCookie("26_num_contrato");
    Str = Str + "&num_associado=" + readCookie("26_num_associado");
    Str = Str + "&cod_usuario=" + readCookie("26_cod_usuario");
    return Str;
}
function writeCookie(name, value, time_exp) {
    return "";
}

function readCookie(name) {
    return "";
}
function deleteCookie(name, path, domain) {
    return "";
}
function valida_data_hora(campo) {

    var valor = campo.value;
    var data = valor.substring(0, 10);
    var hora = valor.substring(11);

    if (!IsDate(data, 'dd/mm/yyyy')) {
        return false;
    }

    if (!valida_hora(hora)) {
        return false;
    }

    return true;

}
function valida_hora(horario) {

    var tamanho = horario.length;
    var hora = "", minuto = "", segundo = "", sep1 = "", sep2 = "";
    var i;
	
    //Verifica se o horario tem 8 (hh:mm:ss) ou 0 posições
    if ((tamanho != 8) && (tamanho != 0)) {
        return false;
    }

    //Se a hora não estiver preenchida, completa com zero
    if (tamanho == 0) {
       horario = "00:00:00";
       tamanho = 8;
    }

    for (i = 0; i < tamanho; i++) {
        if ((i != 2) && (i != 5)) {
            if (!parseFloat(horario.charAt(i))) {
                if (horario.charAt(i) != '0') {
                    return false;
                }
            }
        }
        if (i < 2) {
            hora = (hora + horario.charAt(i));
        }
        if (i == 2) {
            sep1 = (sep1 + horario.charAt(i));
        }
        if ((i > 2) && (i < 5)) {
            minuto = (minuto + horario.charAt(i));
        }
        if (i == 5) {
            sep2 = (sep2 + horario.charAt(i));
        }
        if (i > 5) {
            segundo = (segundo + horario.charAt(i));
        }
    }
    if (parseFloat(hora) < 0 || parseFloat(hora) > 23) {
        return false;
    }
    if (parseFloat(minuto) < 0 || parseFloat(minuto) > 59) {
        return false;
    }
    if (parseFloat(segundo) < 0 || parseFloat(segundo) > 59) {
        return false;
    }
    if (sep1 != ':') {
        return false;
    }
    if (sep2 != ':') {
        return false;
    }
    return true;
}