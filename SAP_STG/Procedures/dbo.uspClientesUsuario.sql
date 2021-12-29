SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 23/07/2015
-- Description:	Analisis Clientes usuario
-- Ejecutar consulta según tipo de usuario
--		1: Central
--		2: Area Manager
--		3: Delegado
--		4: ATC
--		5: Promotor
--		6: Autoventa
--		7: Almacenero
--		8: Vending
--		9: RACE
--		10: SAT
-- =============================================
CREATE PROCEDURE [dbo].[uspClientesUsuario]
	@Usuario int
AS
BEGIN
	
	-- Declarar variables
	declare @TipoUsuario int
	declare @CodEmpresa int=2

	-- Recuperar el tipo de usuario mediante llamada a funcion
	select @TipoUsuario=dbo.ufGetTipoUsuario(@CodEmpresa, @Usuario)

	if @TipoUsuario=1
		-- Datos de Central
		select  t5.CodAreaManager CodElemento
				,t6.NombreCompleto Elemento
				,t1.codTipoCliente
				,t2.desTipoCliente
				, count(t1.CodCliente) NumClientes
		from sym_iClientes t1
			inner join sym_iTiposCliente t2
				on t1.codEmpresa=t2.codEmpresa
					and t1.codTipoCliente=t2.codTipoCliente
			inner join sym_iAgentes t3
				on t1.codEmpresa=t3.codEmpresa
					and t1.codAgente=t3.codAgente
			inner join stgF2Vendedores t4
				on t3.codEmpresa=t4.CodEmpresa
					and t3.codAgente=t4.CodVendedor
			inner join inaDelegaciones t5
				on t4.CodDelegacion=t5.CodDelegacion
					and t5.Ina=1
			inner join stgF2Vendedores t6
				on t5.CodAreaManager=t6.CodVendedor
					and t6.CodEmpresa=@CodEmpresa
		where t1.codEmpresa=@CodEmpresa
		group by t5.CodAreaManager 
				,t6.NombreCompleto
				,t1.codTipoCliente
				,t2.desTipoCliente

	if @TipoUsuario=2
		-- Datos de Area Manager
				select  t3.CodDelegacion CodElemento
				,t4.Delegacion Elemento
				,t1.codTipoCliente
				,t2.desTipoCliente
				, count(t1.CodCliente) NumClientes
		from sym_iClientes t1
			inner join sym_iTiposCliente t2
				on t1.codEmpresa=t2.codEmpresa
					and t1.codTipoCliente=t2.codTipoCliente
			inner join stgF2Vendedores t3
				on t1.codEmpresa=t3.CodEmpresa
					and t1.codAgente=t3.CodVendedor
			inner join inaDelegaciones t4
				on t3.CodDelegacion=t4.CodDelegacion
					and t4.Ina=1
		where t1.codEmpresa=@CodEmpresa
				and t4.CodAreaManager=@Usuario
		group by t3.CodDelegacion
				,t4.Delegacion
				,t1.codTipoCliente
				,t2.desTipoCliente

	if @TipoUsuario=3
		-- Datos de Delegado
				select  t1.CodAgente CodElemento
				,t5.Nombre Elemento
				,t1.codTipoCliente
				,t2.desTipoCliente
				, count(t1.CodCliente) NumClientes
		from sym_iClientes t1
			inner join sym_iTiposCliente t2
				on t1.codEmpresa=t2.codEmpresa
					and t1.codTipoCliente=t2.codTipoCliente
			inner join stgF2Vendedores t3
				on t1.codEmpresa=t3.CodEmpresa
					and t1.codAgente=t3.CodVendedor
			inner join inaDelegaciones t4
				on t3.CodDelegacion=t4.CodDelegacion
					and t4.Ina=1
			inner join inaAgentes t5
				on t1.codEmpresa=t5.CodEmpresa
					and t1.codAgente=t5.CodAgente
		where t1.codEmpresa=@CodEmpresa
				and t4.CodDelegado=@Usuario
		group by t1.CodAgente
				,t5.Nombre
				,t1.codTipoCliente
				,t2.desTipoCliente

	if @TipoUsuario=4
		-- Datos de ATC
		select  t1.CodAgente CodElemento
				,t3.NombreCompleto Elemento
				,t1.codTipoCliente
				,t2.desTipoCliente
				, count(t1.CodCliente) NumClientes
		from sym_iClientes t1
			inner join sym_iTiposCliente t2
				on t1.codEmpresa=t2.codEmpresa
					and t1.codTipoCliente=t2.codTipoCliente
			inner join stgF2Vendedores t3
				on t1.codEmpresa=t3.CodEmpresa
					and t1.codAgente=t3.CodVendedor
			inner join inaAgentes t5
				on t1.codEmpresa=t5.CodEmpresa
					and t1.codAgente=t5.CodAgente
					and t5.Ina=1
		where t1.codEmpresa=@CodEmpresa
				and dbo.ufGetATC(@CodEmpresa, t1.codAgente)=@Usuario
		group by t1.CodAgente
				,t3.NombreCompleto
				,t1.codTipoCliente
				,t2.desTipoCliente

	if @TipoUsuario=5
		-- Datos de Promotor
		select  t1.CodAgente CodElemento
				,t3.NombreCompleto Elemento
				,t1.codTipoCliente
				,t2.desTipoCliente
				, count(t1.CodCliente) NumClientes
		from sym_iClientes t1
			inner join sym_iTiposCliente t2
				on t1.codEmpresa=t2.codEmpresa
					and t1.codTipoCliente=t2.codTipoCliente
			inner join stgF2Vendedores t3
				on t1.codEmpresa=t3.CodEmpresa
					and t1.codAgente=t3.CodVendedor
			inner join inaAgentes t5
				on t1.codEmpresa=t5.CodEmpresa
					and t1.codAgente=t5.CodAgente
					and t5.Ina=1
		where t1.codEmpresa=@CodEmpresa
				and t1.codAgente=@Usuario
		group by t1.CodAgente
				,t3.NombreCompleto
				,t1.codTipoCliente
				,t2.desTipoCliente

	if @TipoUsuario=9 and @Usuario<>374
		-- Datos de Race sin Viruete
		select  t1.CodAgente CodElemento
				,t3.NombreCompleto Elemento
				,t1.codTipoCliente
				,t2.desTipoCliente
				, count(t1.CodCliente) NumClientes
		from sym_iClientes t1
			inner join sym_iTiposCliente t2
				on t1.codEmpresa=t2.codEmpresa
					and t1.codTipoCliente=t2.codTipoCliente
			inner join stgF2Vendedores t3
				on t1.codEmpresa=t3.CodEmpresa
					and t1.codAgente=t3.CodVendedor
			inner join inaAgentes t5
				on t1.codEmpresa=t5.CodEmpresa
					and t1.codAgente=t5.CodAgente
					and t5.Ina=1
		where t1.codEmpresa=@CodEmpresa
				and t1.codAgente=@Usuario
		group by t1.CodAgente
				,t3.NombreCompleto
				,t1.codTipoCliente
				,t2.desTipoCliente

	if @TipoUsuario=9 and @Usuario=374
		-- Datos de Viruete
		select  374 CodElemento
				,'VIRUETE, JULIAN' Elemento
				,t1.codTipoCliente
				,t2.desTipoCliente
				, count(t1.CodCliente) NumClientes
		from sym_iClientes t1
			inner join sym_iTiposCliente t2
				on t1.codEmpresa=t2.codEmpresa
					and t1.codTipoCliente=t2.codTipoCliente
			inner join stgF2Vendedores t3
				on t1.codEmpresa=t3.CodEmpresa
					and t1.codAgente=t3.CodVendedor
		where t1.codEmpresa=2
				and t1.codAgente in(select convert(int,AUTOV) from ZSD013 
										where	CodEmpresa=2 
												and MANDT=100
												and ATC=374) 
		group by t1.codTipoCliente
				,t2.desTipoCliente

END
GO
