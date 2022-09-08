create database if not exists Oficina_mecanica;
use Oficina_mecanica;

-- Tabela de Clientes
create table if not exists cliente(
	idCliente int unsigned auto_increment primary key,
    CPF char(9),
    nome varchar(80),
    constraint unique_cpf_client unique(CPF)
);
-- Tabela de OS
create table if not exists ordemDeServico(
	idOS int unsigned auto_increment primary key,
    OS_idCliente int unsigned not null,
    emissao date,
    conclusao date,
    valorTotal decimal(10,2),
    OS_status boolean,
    constraint foreign_key_OS foreign key (OS_idCliente) references cliente(idCliente)
);
-- Tabela de VEM
create table if not exists veiculosEmManutencao(
	idVeiculoEM int unsigned not null,
    veiculo_idOS int unsigned not null,
    veiculo_idGMecanicos int unsigned not null,
    constraint foreign_key_veiculo1 foreign key (idVeiculoEM) references veiculo(idVeiculo),
    constraint foreign_key_veiculo2 foreign key (veiculo_idOS) references ordemDeServico(idOS),
    constraint foreign_key_veiculo3 foreign key (veiculo_idGMecanicos) references equipeDeMecanicos(idEquipeM)
);
-- Tabela Veículo
create table if not exists veiculo(
	idVeiculo int unsigned auto_increment primary key,
    placa char(9),
    cor varchar(12),
    modelo varchar(20),
    veiculo_idCliente int unsigned
);
-- Tabela de Mão de Obra
create table if not exists maoDeObra(
	idMaoDeObra int unsigned auto_increment primary key,
    valor decimal(10,2),
    MDO_IdOS int unsigned not null,
    constraint foreign_key_maoDeObra foreign key (MDO_IdOS) references ordemDeServico(idOS)
);
-- Tabela de Peças
create table if not exists peca(
	idPeca int unsigned auto_increment primary key,
    nome varchar(100),
    valor decimal(10,2),
    peca_idOS int unsigned not null,
    constraint foreign_key_peca foreign key (peca_idOS) references ordemDeServico(idOS)
);
-- Tabela de equipe de mecânicos
create table if not exists equipeDeMecanicos(
	idEquipeM int unsigned auto_increment primary key,
    nomeTime varchar(30)
);
-- Tabela de mecanicos
create table if not exists mecanico(
	idMecanico int unsigned auto_increment primary key,
    nome varchar(80),
    endereco varchar(150),
    especialidade varchar(50),
    equipe int unsigned,
    constraint foreign_key_mecanico foreign key (equipe) references equipeDeMecanicos(idEquipeM)
);

-- Inserindo dados

insert into cliente(CPF, nome) values ('000000000', 'Rafael'), ('111111111', 'Júnior');
insert into ordemDeServico(OS_idCliente, emissao, conclusao, valorTotal, OS_status) values
(1, STR_TO_DATE( "01/05/2014", "%m/%d/%Y" ), STR_TO_DATE( "01/08/2014", "%m/%d/%Y" ), 180, true),
(2, STR_TO_DATE( "01/09/2014", "%m/%d/%Y" ), STR_TO_DATE( "01/18/2014", "%m/%d/%Y" ), 180, false);
insert into veiculo(placa , cor, modelo, veiculo_idCliente) values
('00000-000', 'verde', 'corsa', 1),('11111-111', 'branco', 'corolla', 2),('22222-111', 'preto', 'corolla', 2);
insert into maoDeObra(valor, MDO_IdOS) values (90.00, 1),(140.00, 2);
insert into peca(nome, valor, peca_idOS) values ('Disco de freio', 40.00, 2);
insert into equipeDeMecanicos(nomeTime) values ('Funilaria'),('mecanicos');
insert into mecanico(nome, endereco, especialidade, equipe) values ('Miguel', '---', 'Funilaria', 1),('Rafael','---','mecanicos',2),('Simael','---', 'Funilaria' , 1),('Jamal','---','mecanicos',2),('Dutra','---','mecanicos',2);

-- Buscas na tabela
select * from cliente;
select m.*, e.nomeTime from mecanico m, equipeDeMecanicos e where m.equipe = e.idEquipeM order by e.nomeTime;
select * from ordemDeServico o, maoDeObra m, peca p where m.idMaoDeObra = o.idOS and p.peca_idOS = o.idOS;