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
    constraint chk_renda_conj check (renda_conj >= 0),
    sexo_conj char(1) not null,
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
	num_ped int not null,
    foreign key (num_ped) references Pedido(cod_ped),
    cod_tit int not null,
    foreign key (cod_tit) references Titulo(cod_tit),
    qtd_cd int not null,
    constraint chk_qtd_cd check (qtd_cd >=1),
    val_cd decimal(10,2) not null,
    constraint chk_val_cd check (val_cd >0)
);

create table Titulo_artista (
	cod_tit int not null,
    foreign key (cod_tit) references Titulo(cod_tit),
    cod_art int not null,
    foreign key (cod_art) references Artista(cod_art)
);


