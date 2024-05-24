create database DB_CDs;
use DB_CDs;

create table Artista (
    cod_art int not null auto_increment primary key,
    nome_art varchar(100) not null unique
);

create table Gravadora (
    cod_grav int auto_increment not null primary key,
    nome_grav varchar(50) not null unique
);

create table Categoria (
    cod_cat int auto_increment not null primary key,
    nome_cat varchar(100) not null unique
);

create table Estado (
    sigla_est char(2) not null primary key,
    nome_est varchar(100) not null unique
);

create table Cidade (
    cod_cidade char(2) not null primary key,
    sigla_est char(2) not null,
    foreign key (sigla_est) references Estado(sigla_est),
    nome_cid varchar(100) not null
);

create table Cliente (
    cod_cli int not null auto_increment primary key,
    cod_cid char(2) not null,
    foreign key (cod_cid) references Cidade(cod_cidade),
    nome_cli varchar(100) not null,
    endereco_cli varchar(200) not null,
    renda_cli decimal(10,2) not null,
    sexo_cli char(1) not null,
    constraint chk_renda_cli check (renda_cli >= 0),
    constraint chk_sexo check (sexo_cli in ('M', 'F'))
);

create table Conjuge (
    cod_cli int not null primary key,
    foreign key (cod_cli) references Cliente(cod_cli),
    nome_conj varchar(100) not null,
    renda_conj decimal(10,2) not null,
    sexo_conj char(1) not null,
    constraint chk_renda_conj check (renda_conj >= 0),
    constraint chk_sexo_conj check (sexo_conj in ('F', 'M'))
);

create table Funcionario (
    cod_func int not null auto_increment primary key,
    nome_func varchar(100) not null,
    end_func varchar(200) not null,
    sal_func decimal(10,2) not null,
    constraint chk_sal_func check (sal_func >= 0),
    sexo_func char(1) not null,
    constraint sexo_func check (sexo_func in ('F', 'M'))
);

create table Dependente (
    cod_dep int auto_increment primary key,
    cod_func int not null,
    foreign key (cod_func) references Funcionario(cod_func),
    nome_dep varchar(100) not null,
    sexo_dep char(1) not null, 
    constraint chk_sexo_dep check (sexo_dep in ('F', 'M'))
);

create table Titulo (
    cod_tit int not null auto_increment primary key,
    cod_cat int not null,
    foreign key (cod_cat) references Categoria(cod_cat),
    cod_grav int not null,
    foreign key (cod_grav) references Gravadora(cod_grav),
    nome_cd varchar(100) not null unique,
    val_cd decimal(10,2) not null,
    constraint chk_val_cd check (val_cd > 0),
    qtd_estq int not null,
    constraint chk_qtd_estq check (qtd_estq >=0)
);

create table Pedido (
    cod_ped int not null auto_increment primary key,
    cod_cli int not null,
    foreign key (cod_cli) references Cliente(cod_cli),
    cod_func int not null,
    foreign key (cod_func) references Funcionario(cod_func),
    data_ped datetime not null,
    val_ped decimal(10,2) not null,
    constraint chk_val_ped check (val_ped > 0)
);

create table Titulo_Pedido (
    cod_ped int not null,
    foreign key (cod_ped) references Pedido(cod_ped),
    cod_tit int not null,
    foreign key (cod_tit) references Titulo(cod_tit),
    qtd_cd int not null,
    constraint chk_qtd_cd check (qtd_cd >=1),
    val_cd decimal(10,2) not null,
    constraint chk_val_cd check (val_cd >0)
);

create table Titulo_Artista (
    cod_tit int not null,
    foreign key (cod_tit) references Titulo(cod_tit),
    cod_art int not null,
    foreign key (cod_art) references Artista(cod_art)
);

insert into Artista (nome_art) values
('Marisa Monte'),
('Gilberto Gil'),
('Caetano Veloso'),
('Milton Nascimento'),
('Legião Urbana'),
('The Beatles'),
('Rita Lee');


insert into Gravadora (nome_grav) values
('Polygram'),
('EMI'),
('Som Livre'),
('Sony Music');


insert into Categoria (nome_cat) values
('MPB'),
('Trilha Sonora'),
('Rock Internacional'),
('Rock Nacional');


insert into Estado (sigla_est, nome_est) values
('SP', 'São Paulo'),
('MG', 'Minas Gerais'),
('RJ', 'Rio de Janeiro');


insert into Cidade (cod_cidade, sigla_est, nome_cid) values
('SP', 'SP', 'São Paulo'),
('SO', 'SP', 'Sorocaba'),
('JU', 'SP', 'Jundiaí'),
('AM', 'SP', 'Americana'),
('AR', 'SP', 'Araraquara'),
('OP', 'MG', 'Ouro Preto'),
('CI', 'SP', 'Cachoeira de Itapemirim'); /*Fica na verdade em Espirito Santo*/


insert into Cliente (cod_cid, nome_cli, endereco_cli, renda_cli, sexo_cli) values
('SP', 'José Nogueira', 'Rua A', 1500.00, 'M'),
('SP', 'Angelo Pereira', 'Rua B', 2000.00, 'M'),
('SP', 'Além Mar Paranhos', 'Rua C', 1500.00, 'F'),
('SP', 'Catarina Souza', 'Rua D', 892.00, 'F'),
('SP', 'Vagner Costa', 'Rua E', 950.00, 'M'),
('MG', 'Antenos da Costa', 'Rua F', 1582.00, 'M'),
('SP', 'Maria Amélia de Sousa', 'Rua G', 1152.00, 'F'),
('SP', 'Paulo Roberto Silva', 'Rua H', 3250.00, 'M'),
('SP', 'Fátima Souza', 'Rua I', 1632.00, 'F'),
('SP', 'Joel da Rocha', 'Rua J', 2000.00, 'M');


insert into Conjuge (cod_cli, nome_conj, renda_conj, sexo_conj) values
(1, 'Carla Nogueira', 2500.00, 'F'),
(2, 'Emília Pereira', 5500.00, 'F'),
(3, 'Altiva da Costa', 3000.00, 'F'),
(7, 'Carlos de Souza', 3250.00, 'M');

insert into Funcionario (nome_func, end_func, sal_func, sexo_func) values
('Vânia Gabriela Pereira', 'Rua A', 2500.00, 'F'),
('Norberto Pereira da Silva', 'Rua B', 3000.00, 'M'),
('Olavio Linhares', 'Rua C', 5800.00, 'M'),
('Paula da Silva', 'Rua D', 3000.00, 'F'),
('Rolando Rocha', 'Rua E', 2000.00, 'M');


insert into Dependente (cod_func, nome_dep, sexo_dep) values
(1, 'Ana Pereira', 'F'),
(1, 'Roberto Pereira', 'M'),
(1, 'Celso Pereira', 'M'),
(3, 'Brisa Linhares', 'F'),
(3, 'Mari Sol Linhares', 'F'),
(4, 'Sonia da Silva', 'F');


insert into Titulo (cod_cat, cod_grav, nome_cd, val_cd, qtd_estq) values
(1, 1, 'Tribalista', 30.00, 1500),
(2, 2, 'Tropicália', 50.00, 500),
(1, 1, 'Aquele Abraço', 50.00, 600),
(2, 2, 'Refazenda', 60.00, 1000),
(3, 3, 'Totalmente demais', 50.00, 2000),
(3, 3, 'Travessia', 55.00, 500),
(2, 2, 'Courage', 30.00, 200),
(3, 4, 'Legião Urbana', 20.00, 100),
(1, 3, 'The Beatles', 30.00, 300),
(1, 4, 'Rita Lee', 30.00, 500);


insert into Pedido (cod_cli, cod_func, data_ped, val_ped) values
(1, 2, '2022-02-02', 1500.00),
(3, 4, '2022-05-02', 50.00),
(4, 2, '2022-06-02', 100.00),
(1, 4, '2023-02-02', 200.00),
(7, 5, '2023-03-02', 300.00),
(4, 4, '2023-03-02', 100.00),
(5, 5, '2023-03-02', 50.00),
(8, 2, '2023-03-02', 50.00),
(2, 2, '2023-03-02', 2000.00),
(7, 1, '2023-03-02', 3000.00);


insert into Titulo_Artista (cod_tit, cod_art) values
(1, 1),
(2, 2),
(3, 2),
(4, 2),
(5, 3),
(6, 4),
(7, 4),
(8, 5),
(9, 6),
(10, 7);


insert into Titulo_Pedido (cod_ped, cod_tit, qtd_cd, val_cd) values
(1, 1, 2, 30.00),
(1, 2, 3, 20.00),
(2, 1, 1, 50.00),
(2, 2, 3, 30.00),
(3, 1, 2, 40.00),
(4, 2, 3, 20.00),
(5, 1, 2, 25.00),
(6, 2, 3, 30.00),
(7, 4, 2, 55.00),
(8, 1, 4, 60.00),
(9, 2, 3, 15.00),
(10, 7, 2, 15.00);