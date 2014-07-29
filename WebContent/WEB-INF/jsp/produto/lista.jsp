<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<head>
<script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		function removeProduto(id){
			$("#mensagem").load('<c:url value="/produto/remove"/>' + '?produto.id=' + id);
			$("#produto" + id).remove();
		}
	</script>

	<h1>Produtos</h1>
	<h2><fmt:message key="mensagem.bemvindo" /></h2>
	<div id="mensagem"></div>
	<table width="100%">
		<tr>
			<td>Contador</td>
			<td width="20%">Nome</td>
			<td>Preco</td>
			<td>Descricao</td>
			<td>Data de Inicio da Venda</td>
			<td>Usado?</td>
			<td width="20%">Remover?</td>
		</tr>
		
		<!-- Taglib JSTL COM EL -->
		<c:forEach var="p" items="${produtoList}" varStatus="st">
		
			<tr id="produto${p.id}">
				<td>Contador: ${st.count}</td>
				<td>${p.nome.toUpperCase()}</td>
				<td>
					<fmt:formatNumber value="${p.preco}" type="currency" />
				</td>
				<td>${p.descricao}</td>
				<td>
					<fmt:formatDate value="${p.dataInicioVenda.time}" pattern="EEEE, dd 'de' MMMM 'de' yyyy"/>
				</td>
				
				<!-- FUNCIONA COMO UM SWITCH CASE, MAS POSSUÍ UM ELSE COMO OTHERWISE -->
				<c:choose>
					
					<c:when test="${p.usado}">
						<td>Sim</td>
					</c:when>
					
					<c:otherwise>
						<td>Não</td>
					</c:otherwise>
					
				</c:choose>
				
				<td><a href="#" onclick="return removeProduto(${p.id})">Remover</a></td>
			</tr>
		</c:forEach>
		
	</table>
	
	<!-- USANDO ESTA TAG, NÃO PRECISAMOS MUDAR O CONTEXT ROOT (PASTA DA APLICAÇÃO) QUANDO O SITE ESTIVER EM PRODUÇÃO (GERALMENTE O RETIRAMOS, POIS FICA NA RAIZ) -->
	<c:url value="/produto/formulario" var="urlAdicionar" />
	<a href="${urlAdicionar}">Adicionar um produto (c:url)</a>
	
	<!-- CAMINHO COMPLETO QUE MUDA SE FOR PARA DEPLOY -->
	<a href="/produtos/produto/formulario"><fmt:message key="mensagem.novoProduto" /></a>
	
	<c:import url="../_comum/rodape.jsp" />
	
</body>
</html>