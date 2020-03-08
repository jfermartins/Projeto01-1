<%-- 
    Document   : amortizaçãoconstante.jsp
    Created on : 03/03/2020, 15:57:38
    Author     : Marcos Paulo da Rocha Moura
    REGRA DE NEGÓCIO:
        O usuario deve entrar com 3 valores (Valor Financiado, Total das Parcelas e Jurus)
    e deve sair na mesma pagina uma tabela.
    CALCULO:
        Tabela de 5 setores (Mês, Parcela, Amortizações,Jurus,Saldo Devedor).
        Mês: Mês da Percela.
        parcela: 1° Mês = (valor/tempo)+(taxa*valor).
                 2° Mês = (valor/tempo)+(taxa*(valor-1*(valor/tempo)).
                 3° Mês = (valor/tempo)+(taxa*(valor-2*(valor/tempo)).
        Amortizações = (valor/tempo).
        Jurus: Taxa de Jurus.
        Saldo Devedor: Quanto foi Pago - Quanto falta a ser pago.
    ESTRUTURA:
        3 campos para digitar dados.
        1 Botão Para envio do dados.
        Criação da tabela com estrutura HTML.
        Popular a tabela com laço de repetição.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">     
    </head>
    <body>
        <%-- Include do menu jspf --%> 
        <nav id="menu">
            <%@include file="WEB-INF/jspf/menu.jspf" %>
        </nav>    
        <h1>Amortização Constante</h1>
        <%--Inicio FORM--%>
        <form>
            <label>Indique o valor financiado:</label><br>               
            <input type="number" name="montante"/><br><br>    
            <label>Indique a quantidade de prestações:</label><br>
            <input type="number" name="tempo"/><br><br>  
            <label>Indique o jurus:</label><br>
            <input type="number" name="jurus"/><br><br>  
            <br>
            <input type="submit" name="calcular" value="Calcular Amortização Constante"/><br><br>
            <input type="submit" name="cancelar" value="Cancelar" />
            <hr>
        </form> 


            <% try {%>
                   <%--Recebendo Dados--%>
                <%
                    double valor = Double.parseDouble(request.getParameter("montante"));
                    double total = Double.parseDouble(request.getParameter("montante"));          
                    double tempo = Double.parseDouble(request.getParameter("tempo"));
                    double taxa = Double.parseDouble(request.getParameter("jurus"));
                %>
                <%--Construindo Tabela--%>
                <table border="1">
                    <tr>
                        <th>Mês</th>
                        <th>Parcela</th>
                        <th>Amortizações</th>
                        <th>Jurus</th>
                        <th>Saldo Devedor</th>              
                    </tr>
                    
                    <%--Populando Tabela--%>
                    <%for(int i=1; i<=tempo; i++){%>
                    <tr>
                        <td><%=i%></td> <%--Mês--%>
                        <%if(tempo<2){%>   
                            <td><=%(valor/tempo)+(taxa*valor)%></td> <%--Parcela 1° mês--%>
                        <%}else{%>
                            <td>(valor/tempo)+(taxa*(valor-(i-1)*(valor/tempo))</td> <%--Parcela 2° mês em diante--%>
                        <%}%>
                        <td><%=(valor/tempo)%></td><%--Amortizações--%>
                        <td><%=taxa%></td><%--Jurus--%>
                        <%if(tempo<2){%>   
                            <td><=%total - ((valor/tempo)+(taxa*valor))%></td> <%--Saldo Devedor 1° mês--%>
                        <%}else{%>
                            <td>total - (valor/tempo)+(taxa*(valor-(i-1)*(valor/tempo))</td> <%--Saldo Devedor 2° mês em diante--%>
                        <%}%>      
                        <%}%>
                        <%} catch (Exception ex) {%>
                            <b>Insira todos os dados.</b><br>
                        <%}%>
                        <br>
                    </tr>
                </table>
                    

        <%-- Include do rodapé --%>
        <footer>
            <%@include file="WEB-INF/jspf/footer.jspf" %>
        </footer>
    </body>
</body>
