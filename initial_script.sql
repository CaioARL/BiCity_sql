USE `BiCity`;

CREATE TABLE `Usuario` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `nome_usuario` varchar(255) UNIQUE NOT NULL,
  `criado_em` timestamp DEFAULT (now()),
  `id_perfil` integer,
  `id_pessoa_fisica` integer,
  `id_pessoa_juridica` integer,
  `id_endereco` integer,
  `id_email` integer,
  `id_senha` integer NOT NULL,
  `id_tipo_usuario` integer NOT NULL
);

CREATE TABLE `Tipo_Usuario` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL
);

CREATE TABLE `Perfil` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL
);

CREATE TABLE `Pessoa_Fisica` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `cpf` varchar(255) NOT NULL
);

CREATE TABLE `Pessoa_Juridica` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `cnpj` varchar(255) NOT NULL
);

CREATE TABLE `Endereco` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `rua` varchar(255) NOT NULL,
  `numero` varchar(255) NOT NULL,
  `complemento` varchar(255),
  `bairro` varchar(255) NOT NULL,
  `cidade` varchar(255) NOT NULL,
  `estado` varchar(255) NOT NULL,
  `cep` varchar(255) NOT NULL,
  `criado_em` timestamp DEFAULT (now()),
  `atualizado_em` timestamp
);

CREATE TABLE `Email` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `valor` varchar(255) NOT NULL,
  `criado_em` timestamp DEFAULT (now()),
  `atualizado_em` timestamp,
  `validado` boolean NOT NULL
);

CREATE TABLE `Senha` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `valor` varchar(255) NOT NULL,
  `chave` varchar(255) NOT NULL,
  `criado_em` timestamp DEFAULT (now()),
  `atualizado_em` timestamp
);

CREATE TABLE `Auth_Token` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `token` varchar(255) UNIQUE NOT NULL,
  `criado_em` timestamp DEFAULT (now()),
  `expira_em` timestamp NOT NULL,
  `validado` boolean NOT NULL,
  `id_usuario` int NOT NULL
);

CREATE TABLE `WebService_Token` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `token` varchar(255) UNIQUE NOT NULL,
  `criado_em` timestamp DEFAULT (now()),
  `expira_em` timestamp,
  `ativo` boolean NOT NULL,
  `id_usuario` int NOT NULL
);

CREATE TABLE `Evento` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `criado_em` timestamp DEFAULT (now()),
  `atualizado_em` timestamp,
  `data_inicial` timestamp NOT NULL,
  `data_final` timestamp NOT NULL,
  `gratuito` boolean NOT NULL,
  `id_tipo_evento` int NOT NULL,
  `id_localizacao` int NOT NULL,
  `id_usuario` int NOT NULL
);

CREATE TABLE `Tipo_Evento` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL
);

CREATE TABLE `Avaliacao` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `criado_em` timestamp DEFAULT (now()),
  `nota` int NOT NULL,
  `id_usuario` int NOT NULL
);

CREATE TABLE `Avaliacao_Infraestrutura_Cicloviaria` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `id_avaliacao` int NOT NULL,
  `id_infraestrutura_cicloviaria` int NOT NULL
);

CREATE TABLE `Infraestrutura_Cicloviaria` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `criado_em` timestamp DEFAULT (now()),
  `nota_media` int NOT NULL,
  `id_tipo_infraestrutura_cicloviaria` int NOT NULL,
  `id_localizacao` int NOT NULL
);

CREATE TABLE `Tipo_Infraestrutura_Cicloviaria` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL
);

CREATE TABLE `Problema` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  `criado_em` timestamp DEFAULT (now()),
  `valido` boolean NOT NULL,
  `ativo` boolean NOT NULL,
  `id_tipo_problema` int NOT NULL
);

CREATE TABLE `Problema_Infraestrutura_Cicloviaria` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `id_problema` int NOT NULL,
  `id_infraestrutura_cicloviaria` int NOT NULL
);

CREATE TABLE `Tipo_Problema` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL
);

CREATE TABLE `Localizacao` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `cep` varchar(255) NOT NULL,
  `criado_em` timestamp DEFAULT (now()),
  `atualizado_em` timestamp,
  `id_tipo_localizacao` int NOT NULL
);

CREATE TABLE `Tipo_Localizacao` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL
);

ALTER TABLE `Usuario` ADD FOREIGN KEY (`id_perfil`) REFERENCES `Perfil` (`id`);

ALTER TABLE `Usuario` ADD FOREIGN KEY (`id_pessoa_fisica`) REFERENCES `Pessoa_Fisica` (`id`);

ALTER TABLE `Usuario` ADD FOREIGN KEY (`id_pessoa_juridica`) REFERENCES `Pessoa_Juridica` (`id`);

ALTER TABLE `Usuario` ADD FOREIGN KEY (`id_endereco`) REFERENCES `Endereco` (`id`);

ALTER TABLE `Usuario` ADD FOREIGN KEY (`id_email`) REFERENCES `Email` (`id`);

ALTER TABLE `Usuario` ADD FOREIGN KEY (`id_senha`) REFERENCES `Senha` (`id`);

ALTER TABLE `Usuario` ADD FOREIGN KEY (`id_tipo_usuario`) REFERENCES `Tipo_Usuario` (`id`);

ALTER TABLE `Auth_Token` ADD FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id`);

ALTER TABLE `WebService_Token` ADD FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id`);

ALTER TABLE `Evento` ADD FOREIGN KEY (`id_tipo_evento`) REFERENCES `Tipo_Evento` (`id`);

ALTER TABLE `Evento` ADD FOREIGN KEY (`id_localizacao`) REFERENCES `Localizacao` (`id`);

ALTER TABLE `Evento` ADD FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id`);

ALTER TABLE `Avaliacao` ADD FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id`);

ALTER TABLE `Avaliacao_Infraestrutura_Cicloviaria` ADD FOREIGN KEY (`id_avaliacao`) REFERENCES `Avaliacao` (`id`);

ALTER TABLE `Avaliacao_Infraestrutura_Cicloviaria` ADD FOREIGN KEY (`id_infraestrutura_cicloviaria`) REFERENCES `Infraestrutura_Cicloviaria` (`id`);

ALTER TABLE `Infraestrutura_Cicloviaria` ADD FOREIGN KEY (`id_tipo_infraestrutura_cicloviaria`) REFERENCES `Tipo_Infraestrutura_Cicloviaria` (`id`);

ALTER TABLE `Infraestrutura_Cicloviaria` ADD FOREIGN KEY (`id_localizacao`) REFERENCES `Localizacao` (`id`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_tipo_problema`) REFERENCES `Tipo_Problema` (`id`);

ALTER TABLE `Problema_Infraestrutura_Cicloviaria` ADD FOREIGN KEY (`id_problema`) REFERENCES `Problema` (`id`);

ALTER TABLE `Problema_Infraestrutura_Cicloviaria` ADD FOREIGN KEY (`id_infraestrutura_cicloviaria`) REFERENCES `Infraestrutura_Cicloviaria` (`id`);

ALTER TABLE `Localizacao` ADD FOREIGN KEY (`id_tipo_localizacao`) REFERENCES `Tipo_Localizacao` (`id`);

-- Inserts basicos
insert into `Tipo_Usuario` (nome, descricao) values('ADM', 'Administrador do sistema');

insert into `Senha` (valor, chave) values('zU4imsbP44oT6iHX0pN+YRrRvuYVQaui93pxTndu9a6k', 'MMO64F5vxlLNRqw5pL42zLkEoYF5V5YBcN33GLpEcME=');

insert into `Usuario` (nome_usuario, id_senha, id_tipo_usuario) values('adm', 1, 1);

insert into `WebService_Token` (token, ativo, id_usuario) values('cCiTBU66i9l8EWrIVEHf', 1, 1);