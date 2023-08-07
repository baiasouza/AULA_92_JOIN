-- criação do banco de dados
create database ibge;

-- ativação do banco de dados
use ibge;

-- criação da tabela
create table unidades_federativas (
	cod_uf int,
    uf char(2),
    nome_uf varchar(30),
    primary key(cod_uf)
    );
    
-- criação da tabela e relacionamento
create table municipios (
	cod_municipio int,
    cod_uf int,
    nome_municipio varchar(40),
    populacao int,
    primary key (cod_municipio),
    foreign key(cod_uf) references unidades_federativas(cod_uf)
);

-- listar todos os municípios e suas unidades federativas 
select m.nome_municipio, u.nome_uf from municipios m 
inner join unidades_federativas u on m.cod_uf = u.cod_uf;

-- listar os munícipios com sua população e a sigla da unidade
select m.nome_municipio, m.populacao, u.uf as sigla_uf from municipios m 
inner join unidades_federativas u on m.cod_uf = u.cod_uf;

-- Listar os municípios que possuem uma população superior a
-- 100.000 habitantes, juntamente com a sigla da unidade federativa
select m.nome_municipio, u.uf from municipios m
inner join unidades_federativas u on m.cod_uf = u.cod_uf where m.populacao > 100000;

-- Listar os municípios que têm o mesmo 
-- nome que sua respectiva unidade federativa
select m.cod_municipio, m.cod_uf, m.nome_municipio, m.populacao, u.nome_uf
from municipios m 
join unidades_federativas u on m.cod_uf = u.cod_uf
 where m.nome_municipio = u.nome_uf;
 
 -- Calcular a média de população dos 
 -- municípios para cada unidade federativa
 select u.nome_uf, avg(m.populacao) as medida_populacao 
 from municipios m inner join unidades_federativas u on m.cod_uf = u.cod_uf group by u.uf;
 
 -- Listar os municípios que têm uma população maior que a 
 -- média da população de todos os municípios
 select * from municipios m where populacao > (select avg(m.populacao) as media_populacao from municipios m);
 
 -- DESAFIO ( Contar quantos municípios existem
 -- em cada unidade federativa. O resultado esperado está ao lado.)
 select u.nome_uf, count(*) as quantidade_municipios from municipios m inner join unidades_federativas u on m.cod_uf = u.cod_uf 
 group by u.uf;