create database `bicity`;

use `bicity`;

create table `usuario` (
  `id` bigint primary key auto_increment,
  `nome_usuario` varchar(255) unique not null,
  `criado_em` timestamp default (now()),
  `id_perfil` bigint,
  `id_pessoa_fisica` bigint,
  `id_pessoa_juridica` bigint,
  `id_endereco` bigint,
  `id_email` bigint,
  `id_senha` bigint not null,
  `id_tipo_usuario` bigint not null
);

create table `tipo_usuario` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `descricao` varchar(255) not null
);

create table `perfil` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `descricao` varchar(255) not null
);

create table `pessoa_fisica` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `cpf` varchar(255) not null
);

create table `pessoa_juridica` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `cnpj` varchar(255) not null
);

create table `endereco` (
  `id` bigint primary key auto_increment,
  `rua` varchar(255) not null,
  `numero` bigint not null,
  `complemento` varchar(255),
  `bairro` varchar(255) not null,
  `cidade` varchar(255) not null,
  `estado` varchar(255) not null,
  `cep` varchar(255) not null,
  `latitude` varchar(255) not null,
  `longitude` varchar(255) not null,
  `criado_em` timestamp default (now()),
  `atualizado_em` timestamp
);

create table `email` (
  `id` bigint primary key auto_increment,
  `valor` varchar(255) not null,
  `criado_em` timestamp default (now()),
  `atualizado_em` timestamp,
  `validado` boolean not null
);

create table `senha` (
  `id` bigint primary key auto_increment,
  `valor` varchar(255) not null,
  `chave` varchar(255) not null,
  `criado_em` timestamp default (now()),
  `atualizado_em` timestamp
);

create table `auth_token` (
  `id` bigint primary key auto_increment,
  `token` varchar(255) unique not null,
  `criado_em` timestamp default (now()),
  `expira_em` timestamp not null,
  `id_usuario` bigint not null
);

create table `webservice_token` (
  `id` bigint primary key auto_increment,
  `token` varchar(255) unique not null,
  `criado_em` timestamp default (now()),
  `expira_em` timestamp,
  `ativo` boolean not null,
  `id_usuario` bigint not null
);

create table `evento` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `descricao` varchar(255) not null,
  `criado_em` timestamp default (now()),
  `atualizado_em` timestamp,
  `data_inicial` timestamp not null,
  `data_final` timestamp not null,
  `gratuito` boolean not null,
  `id_tipo_evento` bigint not null,
  `id_endereco` bigint not null,
  `id_usuario` bigint not null
);

create table `tipo_evento` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `descricao` varchar(255) not null
);

create table `avaliacao` (
  `id` bigint primary key auto_increment,
  `criado_em` timestamp default (now()),
  `nota` float not null default 0,
  `id_usuario` bigint not null,
  `id_infraestrutura_cicloviaria` bigint not null
);

create table `infraestrutura_cicloviaria` (
  `id` bigint primary key auto_increment,
  `nota_media` int not null,
  `criado_em` timestamp default (now())
);

create table `infraestrutura_cicloviaria_filho` (
  `id` bigint primary key auto_increment,
  `id_tipo_infraestrutura_cicloviaria` bigint not null,
  `id_infraestrutura_pai` bigint not null,
  `id_localizacao` bigint not null,
  `criado_em` timestamp default (now())
);

create table `tipo_infraestrutura_cicloviaria` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `descricao` varchar(255) not null
);

create table `problema` (
  `id` bigint primary key auto_increment,
  `descricao` varchar(255) not null,
  `foto` blob,
  `criado_em` timestamp default (now()),
  `ativo` boolean not null,
  `id_tipo_problema` bigint not null,
  `id_infraestrutura_cicloviaria` bigint not null
);

create table `tipo_problema` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `descricao` varchar(255) not null
);

create table `localizacao` (
  `id` bigint primary key auto_increment,
  `latitude` varchar(255) not null,
  `longitude` varchar(255) not null,
  `cep` varchar(255) not null,
  `criado_em` timestamp default (now()),
  `atualizado_em` timestamp,
  `id_tipo_localizacao` bigint not null
);

create table `tipo_localizacao` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `descricao` varchar(255) not null
);

create table `configuracao_api_externa` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) unique not null,
  `url` varchar(255) not null,
  `chave` varchar(255),
  `criado_em` timestamp default (now()),
  `atualizado_em` timestamp
);

alter table `usuario` add foreign key (`id_perfil`) references `perfil` (`id`);

alter table `usuario` add foreign key (`id_pessoa_fisica`) references `pessoa_fisica` (`id`);

alter table `usuario` add foreign key (`id_pessoa_juridica`) references `pessoa_juridica` (`id`);

alter table `usuario` add foreign key (`id_endereco`) references `endereco` (`id`);

alter table `usuario` add foreign key (`id_email`) references `email` (`id`);

alter table `usuario` add foreign key (`id_senha`) references `senha` (`id`);

alter table `usuario` add foreign key (`id_tipo_usuario`) references `tipo_usuario` (`id`);

alter table `auth_token` add foreign key (`id_usuario`) references `usuario` (`id`);

alter table `webservice_token` add foreign key (`id_usuario`) references `usuario` (`id`);

alter table `evento` add foreign key (`id_tipo_evento`) references `tipo_evento` (`id`);

alter table `evento` add foreign key (`id_endereco`) references `endereco` (`id`);

alter table `evento` add foreign key (`id_usuario`) references `usuario` (`id`);

alter table `avaliacao` add foreign key (`id_usuario`) references `usuario` (`id`);

alter table `avaliacao` add foreign key (`id_infraestrutura_cicloviaria`) references `infraestrutura_cicloviaria` (`id`);

alter table `infraestrutura_cicloviaria_filho` add foreign key (`id_tipo_infraestrutura_cicloviaria`) references `tipo_infraestrutura_cicloviaria` (`id`);

alter table `infraestrutura_cicloviaria_filho` add foreign key (`id_infraestrutura_pai`) references `infraestrutura_cicloviaria` (`id`);

alter table `infraestrutura_cicloviaria_filho` add foreign key (`id_localizacao`) references `localizacao` (`id`);

alter table `problema` add foreign key (`id_tipo_problema`) references `tipo_problema` (`id`);

alter table `problema` add foreign key (`id_infraestrutura_cicloviaria`) references `infraestrutura_cicloviaria` (`id`);

alter table `localizacao` add foreign key (`id_tipo_localizacao`) references `tipo_localizacao` (`id`);

-- inserts basicos
insert into `tipo_usuario` (nome, descricao) values('adm', 'administrador do sistema');
insert into `tipo_usuario` (nome, descricao) values('comum', 'usuário comum do sitema');

insert into `senha` (valor, chave) values('zU4imsbP44oT6iHX0pN+YRrRvuYVQaui93pxTndu9a6k', 'MMO64F5vxlLNRqw5pL42zLkEoYF5V5YBcN33GLpEcME=');

insert into `usuario` (nome_usuario, id_senha, id_tipo_usuario) values('adm', 1, 1);

insert into `webservice_token` (token, ativo, id_usuario) values('cCiTBU66i9l8EWrIVEHf', 1, 1);

insert into `perfil` (nome, descricao) values('INICIANTE', 'Ciclista iniciante');
insert into `perfil` (nome, descricao) values('INTERMEDIARIO', 'Ciclista intermediario');
insert into `perfil` (nome, descricao) values('AVANCADO', 'Ciclista avancado');
insert into `perfil` (nome, descricao) values('PROFISSIONAL', 'Ciclista profissional');

insert into `tipo_localizacao` (nome, descricao) values('LineString', 'Localizacao em formato de linha');
insert into `tipo_localizacao` (nome, descricao) values('Polygon', 'Localizacao em formato de poligono');

insert into `configuracao_api_externa` (nome, url) values('BRASIL_API', 'https://brasilapi.com.br/api');