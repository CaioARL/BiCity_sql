create database `bicity`;

use `bicity`;

create table `web_service_token` (
  `id` bigint primary key auto_increment,
  `valor` varchar(255) unique not null
);

create table `configuracao_api_externa` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) unique not null,
  `url` varchar(255) not null,
  `chave` varchar(255),
  `dt_atualizacao` timestamp default (now())
);

create table `usuario` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `nome_usuario` varchar(255) unique not null,
  `endereco` varchar(255) not null,
  `e-mail` varchar(255) not null,
  `senha` varchar(255) not null,
  `hash` varchar(255) not null,
  `dt_criacao` timestamp default (now()),
  `cpf` varchar(255),
  `cnpj` varchar(255),
  `id_nivel_habilidade` bigint not null
);

create table `nivel_habilidade` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `descricao` varchar(255) not null
);

create table `token` (
  `id` bigint primary key auto_increment,
  `valor` varchar(255) unique not null,
  `dt_criacao` timestamp default (now()),
  `dt_expiracao` timestamp not null,
  `email` varchar(255) not null
);

create table `evento` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `descricao` varchar(255) not null,
  `data` timestamp not null,
  `dt_atualizacao` timestamp,
  `endereco` varchar(255) not null,
  `id_tipo_evento` bigint not null
);

create table `tipo_evento` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `faixa_km` varchar(255) not null,
  `gratuito` boolean not null,
  `id_nivel_habilidade` bigint not null
);

create table `avaliacao_infraestrutura_cicloviaria` (
  `id` bigint primary key auto_increment,
  `id_usuario` bigint not null,
  `id_infraestrutura_cicloviaria` bigint not null,
  `nota` int not null,
  `comentario` varchar(255)
);

create table `infraestrutura_cicloviaria` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null, 
  `nota_media` int not null,
  `geometria` varchar(255) not null,
  `id_tipo_infraestrutura_cicloviaria` bigint not null
);

create table `tipo_infraestrutura_cicloviaria` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `descricao` varchar(255) not null
);

create table `trecho` (
  `id` bigint primary key auto_increment,
  `nome` varchar(255) not null,
  `latitude` varchar(255) not null,
  `longitude` varchar(255) not null,
  `id_infraestrutura_cicloviaria` bigint not null
);

create table `problema` (
  `id` bigint primary key auto_increment,
  `descricao` varchar(255) not null,
  `foto` blob,
  `dt_criacao` timestamp default (now()),
  `validado` boolean not null,
  `ativo` boolean not null
);

-- Constraints
alter table `usuario` add constraint `fk_nivel_habilidade` foreign key (`id_nivel_habilidade`) references `nivel_habilidade` (`id`);
alter table `evento` add constraint `fk_tipo_evento` foreign key (`id_tipo_evento`) references `tipo_evento` (`id`);
alter table `tipo_evento` add constraint `fk_nivel_habilidade_tipo_evento` foreign key (`id_nivel_habilidade`) references `nivel_habilidade` (`id`);
alter table `avaliacao_infraestrutura_cicloviaria` add constraint `fk_usuario_avaliacao` foreign key (`id_usuario`) references `usuario` (`id`);
alter table `avaliacao_infraestrutura_cicloviaria` add constraint `fk_infraestrutura_avaliacao` foreign key (`id_infraestrutura_cicloviaria`) references `infraestrutura_cicloviaria` (`id`);
alter table `infraestrutura_cicloviaria` add constraint `fk_tipo_infraestrutura_cicloviaria` foreign key (`id_tipo_infraestrutura_cicloviaria`) references `tipo_infraestrutura_cicloviaria` (`id`);
alter table `trecho` add constraint `fk_infraestrutura_cicloviaria` foreign key (`id_infraestrutura_cicloviaria`) references `infraestrutura_cicloviaria` (`id`);

-- inserts basicos
insert into `web_service_token` (valor) values('cCiTBU66i9l8EWrIVEHf');
insert into `configuracao_api_externa` (nome, url) values
('BRASIL_API', 'https://brasilapi.com.br/api'), 
('OPEN_STREET_MAP_API', 'https://nominatim.openstreetmap.org/search.php');
insert into  `nivel_habilidade` (nome, descricao) values('INICIANTE', 'Ciclista iniciante');
insert into `tipo_evento` (nome, faixa_km, gratuito, id_nivel_habilidade) values('teste', 20, true, 1);
insert into tipo_infraestrutura_cicloviaria (nome, descricao) values
 ('Ciclorrota', 'Trajeto sinalizado em vias compartilhadas para ciclistas, sem exclusividade ou segregação.'),
 ('Ciclofaixa', 'Faixa destinada às bicicletas, demarcada por sinalização no leito das vias urbanas, sem separação física.'),
 ('Ciclovia', 'Via exclusiva e segregada para uso de bicicletas, separada do tráfego de veículos e pedestres.'),
 ('Calçada compartilhada', 'Área destinada ao uso conjunto de pedestres, ciclistas e veículos, com prioridade geralmente definida por normas locais.')