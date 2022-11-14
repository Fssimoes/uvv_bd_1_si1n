-- primeiro criamos o usuário administrador do banco de dados

CREATE USER 'felipesimoes'@'localhost' IDENTIFIED BY '123';
GRANT Alter ON *.* TO 'felipesimoes'@'localhost';
GRANT Create ON *.* TO 'felipesimoes'@'localhost';
GRANT Create view ON *.* TO 'felipesimoes'@'localhost';
GRANT Delete ON *.* TO 'felipesimoes'@'localhost';
GRANT Delete history ON *.* TO 'felipesimoes'@'localhost';
GRANT Drop ON *.* TO 'felipesimoes'@'localhost';
GRANT Grant option ON *.* TO 'felipesimoes'@'localhost';
GRANT Index ON *.* TO 'felipesimoes'@'localhost';
GRANT Insert ON *.* TO 'felipesimoes'@'localhost';
GRANT References ON *.* TO 'felipesimoes'@'localhost';
GRANT Select ON *.* TO 'felipesimoes'@'localhost';
GRANT Show view ON *.* TO 'felipesimoes'@'localhost';
GRANT Trigger ON *.* TO 'felipesimoes'@'localhost';
GRANT Update ON *.* TO 'felipesimoes'@'localhost';

-- depois excluímos a base de dados uvv caso exista ao passo que criamos a nossa

drop database if exists uvv;

create database uvv;

GRANT ALL PRIVILEGES ON * . * TO 'felipesimoes'@'localhost';
FLUSH PRIVILEGES;

use uvv;

-- criação das tabelas 

CREATE TABLE regiao (
                id_regiao INT NOT NULL,
                nome VARCHAR(25) NOT NULL,
                PRIMARY KEY (id_regiao)
);

ALTER TABLE regiao COMMENT 'armazena os dados relativas as regiões do globo terrestre no qual a entidade está distribuída.';

ALTER TABLE regiao MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave primária da tabela região,';

ALTER TABLE regiao MODIFY COLUMN nome VARCHAR(25) COMMENT 'Nome completo da região';


CREATE UNIQUE INDEX regiao_idx
 ON regiao
 ( nome );

CREATE TABLE pais (
                id_pais CHAR(2) NOT NULL,
                nome_pais VARCHAR(50) NOT NULL,
                id_regiao INT,
                PRIMARY KEY (id_pais)
);

ALTER TABLE pais COMMENT 'armazena as informações relativas aos países nos quais a empresa está alocada.';

ALTER TABLE pais MODIFY COLUMN id_pais CHAR(2) COMMENT 'Chave primária da tabela países.';

ALTER TABLE pais MODIFY COLUMN nome_pais VARCHAR(50) COMMENT 'armazena o nome completo do país, por extenso.';

ALTER TABLE pais MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave estrangeira proveniente da tabela regiões';

CREATE UNIQUE INDEX pais_idx
 ON pais
 ( nome_pais );

CREATE TABLE localizacoes (
                id_localizacao INT NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2),
                PRIMARY KEY (id_localizacao)
);

ALTER TABLE localizacoes COMMENT 'Armazena as localizações dos escritórios da empresa.
Não armazena endereços de clientes.';

ALTER TABLE localizacoes MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave primária da tabela.';

ALTER TABLE localizacoes MODIFY COLUMN endereco VARCHAR(50) COMMENT 'Armazena o endereço de cada escritório';

ALTER TABLE localizacoes MODIFY COLUMN cep VARCHAR(12) COMMENT 'Armaze o código postal de cada localização.';

ALTER TABLE localizacoes MODIFY COLUMN cidade VARCHAR(50) COMMENT 'cidade onde está localizado o escritório da entidade.';

ALTER TABLE localizacoes MODIFY COLUMN uf VARCHAR(25) COMMENT 'Estado abreviado ou por extenso de cada localização.';

ALTER TABLE localizacoes MODIFY COLUMN id_pais CHAR(2) COMMENT 'Chave estrangeira da tabela países.';

CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo DECIMAL(8,2),
                salario_maximo DECIMAL(8,2),
                PRIMARY KEY (id_cargo)
);

ALTER TABLE cargos COMMENT 'Tabela que contém os cargos existentes e a respectiva faixa salarial.';

ALTER TABLE cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave primária da tabela.';

ALTER TABLE cargos MODIFY COLUMN cargo VARCHAR(35) COMMENT 'Nome do cargo.';

ALTER TABLE cargos MODIFY COLUMN salario_minimo DECIMAL(8, 2) COMMENT 'O menor salario admitido para um cargo.';

ALTER TABLE cargos MODIFY COLUMN salario_maximo DECIMAL(8, 2) COMMENT 'O maior salário admitido para um cargo.';


CREATE UNIQUE INDEX cargos_idx
 ON cargos
 ( cargo );

CREATE TABLE empregados (
                id_empregado INT NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario DECIMAL(8,2),
                comissao DECIMAL(4,2),
                id_departamento INT,
                id_supervisor INT,
                PRIMARY KEY (id_empregado)
);

ALTER TABLE empregados COMMENT 'Esta tabela armazenará informações acerca dos empregados do órgão/entidade.';

ALTER TABLE empregados MODIFY COLUMN id_empregado INTEGER COMMENT 'Chave única de identificação de cada empregado.';

ALTER TABLE empregados MODIFY COLUMN nome VARCHAR(75) COMMENT 'Nome completo de cada empregado';

ALTER TABLE empregados MODIFY COLUMN email VARCHAR(35) COMMENT 'Parte inicial do e-mail, antes do @.';

ALTER TABLE empregados MODIFY COLUMN telefone VARCHAR(20) COMMENT 'telefone do empregado - com identificador do país e DDD.';

ALTER TABLE empregados MODIFY COLUMN data_contratacao DATE COMMENT 'Data em que o funcionário iniciou no cargo atual.';

ALTER TABLE empregados MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave estrangeira da tabela cargos.';

ALTER TABLE empregados MODIFY COLUMN salario DECIMAL(8, 2) COMMENT 'Salário mensal atual do empregado.';

ALTER TABLE empregados MODIFY COLUMN comissao DECIMAL(4, 2) COMMENT 'Percentual de comissão.';

ALTER TABLE empregados MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave estrangeira para tabela departamento.';

ALTER TABLE empregados MODIFY COLUMN id_supervisor INTEGER COMMENT 'Autorrelacionamento.';

CREATE UNIQUE INDEX empregados_idx
 ON empregados
 ( email );

CREATE TABLE departamentos (
                id_departamento INT NOT NULL,
                nome VARCHAR(50),
                id_localizacao INT,
                id_gerente INT,
                PRIMARY KEY (id_departamento)
);

ALTER TABLE departamentos COMMENT 'Esta Tabela armazena informações acerca de todos os departamento da entidade.';

ALTER TABLE departamentos MODIFY COLUMN id_departamento INTEGER COMMENT 'Identificador único de cada departamento.';

ALTER TABLE departamentos MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome de cada departamento.';

ALTER TABLE departamentos MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave estrangeira da tabela localizações.';

ALTER TABLE departamentos MODIFY COLUMN id_gerente INTEGER COMMENT 'Chave estrangeira para identificação do gerente.';

CREATE UNIQUE INDEX departamentos_idx
 ON departamentos
 ( nome );

CREATE TABLE historico_cargos (
                id_empregado INT NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargos VARCHAR(10) NOT NULL,
                id_departamento INT,
                PRIMARY KEY (id_empregado, data_inicial)
);

ALTER TABLE historico_cargos COMMENT 'Tabela que armazena toda a movimentação dos empregados, promoções, demissões e afins.';

ALTER TABLE historico_cargos MODIFY COLUMN id_empregado INTEGER COMMENT 'Chave primária particionada.';

ALTER TABLE historico_cargos MODIFY COLUMN data_inicial DATE COMMENT 'Chave primária particionada da tabela.';

ALTER TABLE historico_cargos MODIFY COLUMN data_final DATE COMMENT 'Último dia do empregado naquele cargo.';

ALTER TABLE historico_cargos MODIFY COLUMN id_cargos VARCHAR(10) COMMENT 'Chave estrangeira da tabela cargos.';

ALTER TABLE historico_cargos MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave estrangeira da tabela departamentos.';

-- criação das constraints

ALTER TABLE pais ADD CONSTRAINT regiao_pais_fk
FOREIGN KEY (id_regiao)
REFERENCES regiao (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes ADD CONSTRAINT pais_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES pais (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargos)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- inserindo os dados

INSERT INTO regiao values (1,'Europe');
INSERT INTO regiao values (2,'Americas');
INSERT INTO regiao values (3,'Asia');
INSERT INTO regiao values (4,'Middle East and Africa');

INSERT INTO pais VALUES ('AR','Argentina','2');
INSERT INTO pais VALUES ('AU','Australia','3');
INSERT INTO pais VALUES ('BE','Belgium','1');
INSERT INTO pais VALUES ('BR','Brazil','2');
INSERT INTO pais VALUES ('CA','Canada','2');
INSERT INTO pais VALUES ('CH','Switzerland','1');
INSERT INTO pais VALUES ('CN','China','3');
INSERT INTO pais VALUES ('DE','Germany','1');
INSERT INTO pais VALUES ('DK','Denmark','1');
INSERT INTO pais VALUES ('EG','Egypt','4');
INSERT INTO pais VALUES ('FR','France','1');
INSERT INTO pais VALUES ('IL','Israel','4');
INSERT INTO pais VALUES ('IN','India','3');
INSERT INTO pais VALUES ('IT','Italy','1');
INSERT INTO pais VALUES ('JP','Japan','3');
INSERT INTO pais VALUES ('KW','Kuwait','4');
INSERT INTO pais VALUES ('ML','Malaysia','3');
INSERT INTO pais VALUES ('MX','Mexico','2');
INSERT INTO pais VALUES ('NG','Nigeria','4');
INSERT INTO pais VALUES ('NL','Netherlands','1');
INSERT INTO pais VALUES ('SG','Singapore','3');
INSERT INTO pais VALUES ('UK','United Kingdom','1');
INSERT INTO pais VALUES ('US','United States of America','2');
INSERT INTO pais VALUES ('ZM','Zambia','4');
INSERT INTO pais VALUES ('ZW','Zimbabwe','4');

INSERT INTO localizacoes VALUES (1000, '1297 Via Cola di Rie','00989','Roma','','IT');
INSERT INTO localizacoes VALUES (1100, '93091 Calle della Testa','10934','Venice','','IT');
INSERT INTO localizacoes VALUES (1200, '2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP');
INSERT INTO localizacoes VALUES (1300, '9450 Kamiya-cho','6823','Hiroshima','','JP');
INSERT INTO localizacoes VALUES (1400, '2014 Jabberwocky Rd','26192','Southlake','Texas','US');
INSERT INTO localizacoes VALUES (1500, '2011 Interiors Blvd','99236','South San Francisco','California','US');
INSERT INTO localizacoes VALUES (1600, '2007 Zagora St','50090','South Brunswick','New Jersey','US');
INSERT INTO localizacoes VALUES (1700, '2004 Charade Rd','98199','Seattle','Washington','US');
INSERT INTO localizacoes VALUES (1800, '147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA');
INSERT INTO localizacoes VALUES (1900, '6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA');
INSERT INTO localizacoes VALUES (2000, '40-5-12 Laogianggen','190518','Beijing','','CN');
INSERT INTO localizacoes VALUES (2100, '1298 Vileparle (E)','490231','Bombay','Maharashtra','IN');
INSERT INTO localizacoes VALUES (2200, '12-98 Victoria Street','2901','Sydney','New South Wales','AU');
INSERT INTO localizacoes VALUES (2300, '198 Clementi North','540198','Singapore','','SG');
INSERT INTO localizacoes VALUES (2400, '8204 Arthur St','','London','','UK');
INSERT INTO localizacoes VALUES (2500, 'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK');
INSERT INTO localizacoes VALUES (2600, '9702 Chester Road','09629850293','Stretford','Manchester','UK');
INSERT INTO localizacoes VALUES (2700, 'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE');
INSERT INTO localizacoes VALUES (2800, 'Rua Frei Caneca 1360 ','01307-002','Sao Paulo','Sao Paulo','BR');
INSERT INTO localizacoes VALUES (2900, '20 Rue des Corps-Saints','1730','Geneva','Geneve','CH');
INSERT INTO localizacoes VALUES (3000, 'Murtenstrasse 921','3095','Bern','BE','CH');
INSERT INTO localizacoes VALUES (3100, 'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL');
INSERT INTO localizacoes VALUES (3200, 'Mariano Escobedo 9991','11932','Mexico City','Distrito Federal,','MX');

INSERT INTO cargos VALUES ('AD_PRES', 'President',20080,40000);
INSERT INTO cargos VALUES ('AD_VP', 'Administration Vice President',15000,30000);
INSERT INTO cargos VALUES ('AD_ASST', 'Administration Assistant',3000,6000);
INSERT INTO cargos VALUES ('FI_MGR', 'Finance Manager',8200,16000);
INSERT INTO cargos VALUES ('FI_ACCOUNT', 'Accountant',4200,9000);
INSERT INTO cargos VALUES ('AC_MGR', 'Accounting Manager',8200,16000);
INSERT INTO cargos VALUES ('AC_ACCOUNT', 'Public Accountant',4200,9000);
INSERT INTO cargos VALUES ('SA_MAN', 'Sales Manager',10000,20080);
INSERT INTO cargos VALUES ('SA_REP', 'Sales Representative',6000,12008);
INSERT INTO cargos VALUES ('PU_MAN', 'Purchasing Manager',8000,15000);
INSERT INTO cargos VALUES ('PU_CLERK', 'Purchasing Clerk',2500,5500);
INSERT INTO cargos VALUES ('ST_MAN', 'Stock Manager',5500,8500);
INSERT INTO cargos VALUES ('ST_CLERK', 'Stock Clerk',2008,5000);
INSERT INTO cargos VALUES ('SH_CLERK', 'Shipping Clerk',2500,5500);
INSERT INTO cargos VALUES ('IT_PROG', 'Programmer',4000,10000);
INSERT INTO cargos VALUES ('MK_MAN', 'Marketing Manager',9000,15000);
INSERT INTO cargos VALUES ('MK_REP', 'Marketing Representative',4000,9000);
INSERT INTO cargos VALUES ('HR_REP', 'Human Resources Representative',4000,9000);
INSERT INTO cargos VALUES ('PR_REP', 'Public Relations Representative',4500,10500);

INSERT INTO departamentos VALUES (10, 'Administration',1700,null);
INSERT INTO departamentos VALUES (20, 'Marketing',1800,null);
INSERT INTO departamentos VALUES (30, 'Purchasing',1700,null);
INSERT INTO departamentos VALUES (40, 'Human Resources',2400,null);
INSERT INTO departamentos VALUES (50, 'Shipping',1500,null);
INSERT INTO departamentos VALUES (60, 'IT',1400,null);
INSERT INTO departamentos VALUES (70, 'Public Relations',2700,null);
INSERT INTO departamentos VALUES (80, 'Sales',2500,null);
INSERT INTO departamentos VALUES (90, 'Executive',1700,null);
INSERT INTO departamentos VALUES (100, 'Finance',1700,null);
INSERT INTO departamentos VALUES (110, 'Accounting',1700,null);
INSERT INTO departamentos VALUES (120, 'Treasury',1700,null);
INSERT INTO departamentos VALUES (130, 'Corporate Tax',1700,null);
INSERT INTO departamentos VALUES (140, 'Control And Credit',1700,null);
INSERT INTO departamentos VALUES (150, 'Shareholder Services',1700,null);
INSERT INTO departamentos VALUES (160, 'Benefits',1700,null);
INSERT INTO departamentos VALUES (170, 'Manufacturing',1700,null);
INSERT INTO departamentos VALUES (180, 'Construction',1700,null);
INSERT INTO departamentos VALUES (190, 'Contracting',1700,null);
INSERT INTO departamentos VALUES (200, 'Operations',1700,null);
INSERT INTO departamentos VALUES (210, 'IT Support',1700,null);
INSERT INTO departamentos VALUES (220, 'NOC',1700,null);
INSERT INTO departamentos VALUES (230, 'IT Helpdesk',1700,null);
INSERT INTO departamentos VALUES (240, 'Government Sales',1700,null);
INSERT INTO departamentos VALUES (250, 'Retail Sales',1700,null);
INSERT INTO departamentos VALUES (260, 'Recruiting',1700,null);
INSERT INTO departamentos VALUES (270, 'Payroll',1700,null);

INSERT INTO empregados VALUES
(100, 'Steven King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000, null, 90, null);
INSERT INTO empregados VALUES
(101, 'Neena Kochhar', 'NKOCHHAR', '515.123.4568', '2005-09-21', 'AD_VP', 17000, null, 90, 100);
INSERT INTO empregados VALUES
(102, 'Lex De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13', 'AD_VP', 17000, null, 90, 100);
INSERT INTO empregados VALUES
(103, 'Alexander Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000, null, 60, 102);
INSERT INTO empregados VALUES
(104, 'Bruce Ernst', 'BERNST', '590.423.4568', '2007-05-21', 'IT_PROG', 6000, null, 60, 103);
INSERT INTO empregados VALUES
(105, 'David Austin', 'DAUSTIN', '590.423.4569', '2005-06-25', 'IT_PROG', 4800, null, 60, 103);
INSERT INTO empregados VALUES
(106, 'Valli Pataballa', 'VPATABAL', '590.423.4560', '2006-02-05', 'IT_PROG', 4800, null, 60, 103);
INSERT INTO empregados VALUES
(107, 'Diana Lorentz', 'DLORENTZ', '590.423.5567', '2007-02-07', 'IT_PROG', 4200, null, 60, 103);
INSERT INTO empregados VALUES
(108, 'Nancy Greenberg', 'NGREENBE', '515.124.4569', '2002-08-17', 'FI_MGR', 12008, null, 100, 101);
INSERT INTO empregados VALUES
(109, 'Daniel Faviet', 'DFAVIET', '515.124.4169', '2002-08-16', 'FI_ACCOUNT', 9000, null, 100, 108);
INSERT INTO empregados VALUES
(110, 'John Chen', 'JCHEN', '515.124.4269', '2005-09-28', 'FI_ACCOUNT', 8200, null, 100, 108);
INSERT INTO empregados VALUES
(111, 'Ismael Sciarra', 'ISCIARRA', '515.124.4369', '2005-09-30', 'FI_ACCOUNT', 7700, null, 100, 108);
INSERT INTO empregados VALUES
(112, 'Jose Manuel Urman', 'JMURMAN', '515.124.4469', '2006-03-07', 'FI_ACCOUNT', 7800, null, 100, 108);
INSERT INTO empregados VALUES
(113, 'Luis Popp', 'LPOPP', '515.124.4567', '2007-12-07', 'FI_ACCOUNT', 6900, null, 100, 108);
INSERT INTO empregados VALUES
(114, 'Den Raphaely', 'DRAPHEAL', '515.127.4561', '2002-12-07', 'PU_MAN', 11000, null, 30, 100);
INSERT INTO empregados VALUES
(115, 'Alexander Khoo', 'AKHOO', '515.127.4562', '2003-05-18', 'PU_CLERK', 3100, null, 30, 114);
INSERT INTO empregados VALUES
(116, 'Shelli Baida', 'SBAIDA', '515.127.4563', '2005-12-24', 'PU_CLERK', 2900, null, 30, 114);
INSERT INTO empregados VALUES
(117, 'Sigal Tobias', 'STOBIAS', '515.127.4564', '2005-07-24', 'PU_CLERK', 2800, null, 30, 114);
INSERT INTO empregados VALUES
(118, 'Guy Himuro', 'GHIMURO', '515.127.4565', '2006-11-15', 'PU_CLERK', 2600, null, 30, 114);
INSERT INTO empregados VALUES
(119, 'Karen Colmenares', 'KCOLMENA', '515.127.4566', '2007-08-10', 'PU_CLERK', 2500, null, 30, 114);
INSERT INTO empregados VALUES
(120, 'Matthew Weiss', 'MWEISS', '650.123.1234', '2004-07-18', 'ST_MAN', 8000, null, 50, 100);
INSERT INTO empregados VALUES
(121, 'Adam Fripp', 'AFRIPP', '650.123.2234', '2005-04-10', 'ST_MAN', 8200, null, 50, 100);
INSERT INTO empregados VALUES
(122, 'Payam Kaufling', 'PKAUFLIN', '650.123.3234', '2003-05-01', 'ST_MAN', 7900, null, 50, 100);
INSERT INTO empregados VALUES
(123, 'Shanta Vollman', 'SVOLLMAN', '650.123.4234', '2005-10-10', 'ST_MAN', 6500, null, 50, 100);
INSERT INTO empregados VALUES
(124, 'Kevin Mourgos', 'KMOURGOS', '650.123.5234', '2007-11-16', 'ST_MAN', 5800, null, 50, 100);
INSERT INTO empregados VALUES
(125, 'Julia Nayer', 'JNAYER', '650.124.1214', '2005-07-16', 'ST_CLERK', 3200, null, 50, 120);
INSERT INTO empregados VALUES
(126, 'Irene Mikkilineni', 'IMIKKILI', '650.124.1224', '2006-09-28', 'ST_CLERK', 2700, null, 50, 120);
INSERT INTO empregados VALUES
(127, 'James Landry', 'JLANDRY', '650.124.1334', '2007-01-14', 'ST_CLERK', 2400, null, 50, 120);
INSERT INTO empregados VALUES
(128, 'Steven Markle', 'SMARKLE', '650.124.1434', '2008-03-08', 'ST_CLERK', 2200, null, 50, 120);
INSERT INTO empregados VALUES
(129, 'Laura Bissot', 'LBISSOT', '650.124.5234', '2005-08-20', 'ST_CLERK', 3300, null, 50, 121);
INSERT INTO empregados VALUES
(130, 'Mozhe Atkinson', 'MATKINSO', '650.124.6234', '2005-10-30', 'ST_CLERK', 2800, null, 50, 121);
INSERT INTO empregados VALUES
(131, 'James Marlow', 'JAMRLOW', '650.124.7234', '2005-02-16', 'ST_CLERK', 2500, null, 50, 121);
INSERT INTO empregados VALUES
(132, 'TJ Olson', 'TJOLSON', '650.124.8234', '2007-04-10', 'ST_CLERK', 2100, null, 50, 121);
INSERT INTO empregados VALUES
(133, 'Jason Mallin', 'JMALLIN', '650.127.1934', '2004-06-14', 'ST_CLERK', 3300, null, 50, 122);
INSERT INTO empregados VALUES
(134, 'Michael Rogers', 'MROGERS', '650.127.1834', '2006-08-26', 'ST_CLERK', 2900, null, 50, 122);
INSERT INTO empregados VALUES
(135, 'Ki Gee', 'KGEE', '650.127.1734', '2007-12-12', 'ST_CLERK', 2400, null, 50, 122);
INSERT INTO empregados VALUES
(136, 'Hazel Philtanker', 'HPHILTAN', '650.127.1634', '2008-02-06', 'ST_CLERK', 2200, null, 50, 122);
INSERT INTO empregados VALUES
(137, 'Renske Ladwig', 'RLADWIG', '650.121.1234', '2003-07-14', 'ST_CLERK', 3600, null, 50, 123);
INSERT INTO empregados VALUES
(138, 'Stephen Stiles', 'SSTILES', '650.121.2034', '2005-10-26', 'ST_CLERK', 3200, null, 50, 123);
INSERT INTO empregados VALUES
(139, 'John Seo', 'JSEO', '650.121.2019', '2006-02-12', 'ST_CLERK', 2700, null, 50, 123);
INSERT INTO empregados VALUES
(140, 'Joshua Patel', 'JPATEL', '650.121.1834', '2006-04-06', 'ST_CLERK', 2500, null, 50, 123);
INSERT INTO empregados VALUES
(141, 'Trenna Rajs', 'TRAJS', '650.121.8009', '2003-10-17', 'ST_CLERK', 3500, null, 50, 124);
INSERT INTO empregados VALUES
(142, 'Curtis Davies', 'CDAVIES', '650.121.2994', '2005-01-29', 'ST_CLERK', 3100, null, 50, 124);
INSERT INTO empregados VALUES
(143, 'Randall Matos', 'RMATOS', '650.121.2874', '2006-03-15', 'ST_CLERK', 2600, null, 50, 124);
INSERT INTO empregados VALUES
(144, 'Peter Vargas', 'PVARGAS', '650.121.2004', '2006-07-09', 'ST_CLERK', 2500, null, 50, 124);
INSERT INTO empregados VALUES
(145, 'John Russell', 'JRUSSEL', '011.44.1344.429268', '2004-10-01', 'SA_MAN', 14000, .4, 80, 100);
INSERT INTO empregados VALUES
(146, 'Karen Partners', 'KPARTNER', '011.44.1344.467268', '2005-01-05', 'SA_MAN', 13500, .3, 80, 100);
INSERT INTO empregados VALUES
(147, 'Alberto Errazuriz', 'AERRAZUR', '011.44.1344.429278', '2005-03-10', 'SA_MAN', 12000, .3, 80, 100);
INSERT INTO empregados VALUES
(148, 'Gerald Cambrault', 'GCAMBRAU', '011.44.1344.619268', '2007-10-15', 'SA_MAN', 11000, .3, 80, 100);
INSERT INTO empregados VALUES
(149, 'Eleni Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '2008-01-29', 'SA_MAN', 10500, .2, 80, 100);
INSERT INTO empregados VALUES
(150, 'Peter Tucker', 'PTUCKER', '011.44.1344.129268', '2005-01-30', 'SA_REP', 10000, .3, 80, 145);
INSERT INTO empregados VALUES
(151, 'David Bernstein', 'DBERNSTE', '011.44.1344.345268', '2005-03-24', 'SA_REP', 9500, .25, 80, 145);
INSERT INTO empregados VALUES
(152, 'Peter Hall', 'PHALL', '011.44.1344.478968', '2005-08-20', 'SA_REP', 9000, .25, 80, 145);
INSERT INTO empregados VALUES
(153, 'Christopher Olsen', 'COLSEN', '011.44.1344.498718', '2006-03-30', 'SA_REP', 8000, .2, 80, 145);
INSERT INTO empregados VALUES
(154, 'Nanette Cambrault', 'NCAMBRAU', '011.44.1344.987668', '2006-12-09', 'SA_REP', 7500, .2, 80, 145);
INSERT INTO empregados VALUES
(155, 'Oliver Tuvault', 'OTUVAULT', '011.44.1344.486508', '2007-11-23', 'SA_REP', 7000, .15, 80, 145);
INSERT INTO empregados VALUES
(156, 'Janette King', 'JKING', '011.44.1345.429268', '2004-01-30', 'SA_REP', 10000, .35, 80, 146);
INSERT INTO empregados VALUES
(157, 'Patrick Sully', 'PSULLY', '011.44.1345.929268', '2004-03-04', 'SA_REP', 9500, .35, 80, 146);
INSERT INTO empregados VALUES
(158, 'Allan McEwen', 'AMCEWEN', '011.44.1345.829268', '2004-08-01', 'SA_REP', 9000, .35, 80, 146);
INSERT INTO empregados VALUES
(159, 'Lindsey Smith', 'LSMITH', '011.44.1345.729268', '2005-03-10', 'SA_REP', 8000, .3, 80, 146);
INSERT INTO empregados VALUES
(160, 'Louise Doran', 'LDORAN', '011.44.1345.629268', '2005-12-15', 'SA_REP', 7500, .3, 80, 146);
INSERT INTO empregados VALUES
(161, 'Sarath Sewall', 'SSEWALL', '011.44.1345.529268', '2006-11-03', 'SA_REP', 7000, .25, 80, 146);
INSERT INTO empregados VALUES
(162, 'Clara Vishney', 'CVISHNEY', '011.44.1346.129268', '2005-11-11', 'SA_REP', 10500, .25, 80, 147);
INSERT INTO empregados VALUES
(163, 'Danielle Greene', 'DGREENE', '011.44.1346.229268', '2007-03-19', 'SA_REP', 9500, .15, 80, 147);
INSERT INTO empregados VALUES
(164, 'Mattea Marvins', 'MMARVINS', '011.44.1346.329268', '2008-01-24', 'SA_REP', 7200, .1, 80, 147);
INSERT INTO empregados VALUES
(165, 'David Lee', 'DLEE', '011.44.1346.529268', '2008-02-23', 'SA_REP', 6800, .1, 80, 147);
INSERT INTO empregados VALUES
(166, 'Sundar Ande', 'SANDE', '011.44.1346.629268', '2008-03-24', 'SA_REP', 6400, .1, 80, 147);
INSERT INTO empregados VALUES
(167, 'Amit Banda', 'ABANDA', '011.44.1346.729268', '2008-04-21', 'SA_REP', 6200, .1, 80, 147);
INSERT INTO empregados VALUES
(168, 'Lisa Ozer', 'LOZER', '011.44.1343.929268', '2005-03-11', 'SA_REP', 11500, .25, 80, 148);
INSERT INTO empregados VALUES
(169, 'Harrison Bloom', 'HBLOOM', '011.44.1343.829268', '2006-03-23', 'SA_REP', 10000, .2, 80, 148);
INSERT INTO empregados VALUES
(170, 'Tayler Fox', 'TFOX', '011.44.1343.729268', '2006-01-24', 'SA_REP', 9600, .2, 80, 148);
INSERT INTO empregados VALUES
(171, 'William Smith', 'WSMITH', '011.44.1343.629268', '2007-02-23', 'SA_REP', 7400, .15, 80, 148);
INSERT INTO empregados VALUES
(172, 'Elizabeth Bates', 'EBATES', '011.44.1343.529268', '2007-03-24', 'SA_REP', 7300, .15, 80, 148);
INSERT INTO empregados VALUES
(173, 'Sundita Kumar', 'SKUMAR', '011.44.1343.329268', '2008-04-21', 'SA_REP', 6100, .1, 80, 148);
INSERT INTO empregados VALUES
(174, 'Ellen Abel', 'EABEL', '011.44.1644.429267', '2004-05-11', 'SA_REP', 11000, .3, 80, 149);
INSERT INTO empregados VALUES
(175, 'Alyssa Hutton', 'AHUTTON', '011.44.1644.429266', '2005-03-19', 'SA_REP', 8800, .25, 80, 149);
INSERT INTO empregados VALUES
(176, 'Jonathon Taylor', 'JTAYLOR', '011.44.1644.429265', '2006-03-24', 'SA_REP', 8600, .2, 80, 149);
INSERT INTO empregados VALUES
(177, 'Jack Livingston', 'JLIVINGS', '011.44.1644.429264', '2006-04-23', 'SA_REP', 8400, .2, 80, 149);
INSERT INTO empregados VALUES
(178, 'Kimberely Grant', 'KGRANT', '011.44.1644.429263', '2007-05-24', 'SA_REP', 7000, .15, null, 149);
INSERT INTO empregados VALUES
(179, 'Charles Johnson', 'CJOHNSON', '011.44.1644.429262', '2008-01-04', 'SA_REP', 6200, .1, 80, 149);
INSERT INTO empregados VALUES
(180, 'Winston Taylor', 'WTAYLOR', '650.507.9876', '2006-01-24', 'SH_CLERK', 3200, null, 50, 120);
INSERT INTO empregados VALUES
(181, 'Jean Fleaur', 'JFLEAUR', '650.507.9877', '2006-02-23', 'SH_CLERK', 3100, null, 50, 120);
INSERT INTO empregados VALUES
(182, 'Martha Sullivan', 'MSULLIVA', '650.507.9878', '2007-06-21', 'SH_CLERK', 2500, null, 50, 120);
INSERT INTO empregados VALUES
(183, 'Girard Geoni', 'GGEONI', '650.507.9879', '2008-02-03', 'SH_CLERK', 2800, null, 50, 120);
INSERT INTO empregados VALUES
(184, 'Nandita Sarchand', 'NSARCHAN', '650.509.1876', '2004-01-27', 'SH_CLERK', 4200, null, 50, 121);
INSERT INTO empregados VALUES
(185, 'Alexis Bull', 'ABULL', '650.509.2876', '2005-02-20', 'SH_CLERK', 4100, null, 50, 121);
INSERT INTO empregados VALUES
(186, 'Julia Dellinger', 'JDELLING', '650.509.3876', '2006-06-24', 'SH_CLERK', 3400, null, 50, 121);
INSERT INTO empregados VALUES
(187, 'Anthony Cabrio', 'ACABRIO', '650.509.4876', '2007-02-07', 'SH_CLERK', 3000, null, 50, 121);
INSERT INTO empregados VALUES
(188, 'Kelly Chung', 'KCHUNG', '650.505.1876', '2005-06-14', 'SH_CLERK', 3800, null, 50, 122);
INSERT INTO empregados VALUES
(189, 'Jennifer Dilly', 'JDILLY', '650.505.2876', '2005-08-13', 'SH_CLERK', 3600, null, 50, 122);
INSERT INTO empregados VALUES
(190, 'Timothy Gates', 'TGATES', '650.505.3876', '2006-07-11', 'SH_CLERK', 2900, null, 50, 122);
INSERT INTO empregados VALUES
(191, 'Randall Perkins', 'RPERKINS', '650.505.4876', '2007-12-19', 'SH_CLERK', 2500, null, 50, 122);
INSERT INTO empregados VALUES
(192, 'Sarah Bell', 'SBELL', '650.501.1876', '2004-02-04', 'SH_CLERK', 4000, null, 50, 123);
INSERT INTO empregados VALUES
(193, 'Britney Everett', 'BEVERETT', '650.501.2876', '2005-03-03', 'SH_CLERK', 3900, null, 50, 123);
INSERT INTO empregados VALUES
(194, 'Samuel McCain', 'SMCCAIN', '650.501.3876', '2006-07-01', 'SH_CLERK', 3200, null, 50, 123);
INSERT INTO empregados VALUES
(195, 'Vance Jones', 'VJONES', '650.501.4876', '2007-03-17', 'SH_CLERK', 2800, null, 50, 123);
INSERT INTO empregados VALUES
(196, 'Alana Walsh', 'AWALSH', '650.507.9811', '2006-04-24', 'SH_CLERK', 3100, null, 50, 124);
INSERT INTO empregados VALUES
(197, 'Kevin Feeney', 'KFEENEY', '650.507.9822', '2006-05-23', 'SH_CLERK', 3000, null, 50, 124);
INSERT INTO empregados VALUES
(198, 'Donald OConnell', 'DOCONNEL', '650.507.9833', '2007-06-21', 'SH_CLERK', 2600, null, 50, 124);
INSERT INTO empregados VALUES
(199, 'Douglas Grant', 'DGRANT', '650.507.9844', '2008-01-13', 'SH_CLERK', 2600, null, 50, 124);
INSERT INTO empregados VALUES
(200, 'Jennifer Whalen', 'JWHALEN', '515.123.4444', '2003-09-17', 'AD_ASST', 4400, null, 10, 101);
INSERT INTO empregados VALUES
(201, 'Michael Hartstein', 'MHARTSTE', '515.123.5555', '2004-02-17', 'MK_MAN', 13000, null, 20, 100);
INSERT INTO empregados VALUES
(202, 'Pat Fay', 'PFAY', '603.123.6666', '2005-08-17', 'MK_REP', 6000, null, 20, 201);
INSERT INTO empregados VALUES
(203, 'Susan Mavris', 'SMAVRIS', '515.123.7777', '2002-06-07', 'HR_REP', 6500, null, 40, 101);
INSERT INTO empregados VALUES
(204, 'Hermann Baer', 'HBAER', '515.123.8888', '2002-06-07', 'PR_REP', 10000, null, 70, 101);
INSERT INTO empregados VALUES
(205, 'Shelley Higgins', 'SHIGGINS', '515.123.8080', '2002-06-07', 'AC_MGR', 12008, null, 110, 101);
INSERT INTO empregados VALUES
(206, 'William Gietz', 'WGIETZ', '515.123.8181', '2002-06-07', 'AC_ACCOUNT', 8300, null, 110, 205);

UPDATE departamentos SET id_gerente = 200 WHERE id_departamento = 10;
UPDATE departamentos SET id_gerente = 201 WHERE id_departamento = 20;
UPDATE departamentos SET id_gerente = 114 WHERE id_departamento = 30;
UPDATE departamentos SET id_gerente = 203 WHERE id_departamento = 40;
UPDATE departamentos SET id_gerente = 121 WHERE id_departamento = 50;
UPDATE departamentos SET id_gerente = 103 WHERE id_departamento = 60;
UPDATE departamentos SET id_gerente = 204 WHERE id_departamento = 70;
UPDATE departamentos SET id_gerente = 145 WHERE id_departamento = 80;
UPDATE departamentos SET id_gerente = 100 WHERE id_departamento = 90;
UPDATE departamentos SET id_gerente = 108 WHERE id_departamento = 100;
UPDATE departamentos SET id_gerente = 205 WHERE id_departamento = 110;

INSERT INTO historico_cargos VALUES (102, '2001-01-13','2006-07-24','IT_PROG','60');
INSERT INTO historico_cargos VALUES (101, '1997-09-21','2001-10-27','AC_ACCOUNT','110');
INSERT INTO historico_cargos VALUES (101, '2001-10-28','2005-03-15','AC_MGR','110');
INSERT INTO historico_cargos VALUES (201, '2004-02-17','2007-12-17','MK_REP','20');
INSERT INTO historico_cargos VALUES (114, '2006-03-24','2007-12-31','ST_CLERK','50');
INSERT INTO historico_cargos VALUES (122, '2007-01-01','2007-12-31','ST_CLERK','50');
INSERT INTO historico_cargos VALUES (200, '1995-09-17','2001-06-17','AD_ASST','90');
INSERT INTO historico_cargos VALUES (176, '2006-03-24','2006-12-31','SA_REP','80');
INSERT INTO historico_cargos VALUES (176, '2007-01-01','2007-12-31','SA_MAN','80');
INSERT INTO historico_cargos VALUES (200, '2002-07-01','2006-12-06','AC_ACCOUNT','90');
