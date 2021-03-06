/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

/* Foreign Keys must be dropped in the target to ensure that requires changes can be done*/

ALTER TABLE `invest`
    DROP FOREIGN KEY `invest_ibfk_1`  ,
    DROP FOREIGN KEY `invest_ibfk_2`  ;

ALTER TABLE `invest_node`
    DROP FOREIGN KEY `invest_node_ibfk_1`  ,
    DROP FOREIGN KEY `invest_node_ibfk_2`  ,
    DROP FOREIGN KEY `invest_node_ibfk_3`  ,
    DROP FOREIGN KEY `invest_node_ibfk_4`  ,
    DROP FOREIGN KEY `invest_node_ibfk_5`  ,
    DROP FOREIGN KEY `invest_node_ibfk_6`  ;

/* Create table in target */
CREATE TABLE IF NOT EXISTS `call`(
    `id` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `name` tinytext COLLATE utf8_general_ci NULL  ,
    `subtitle` tinytext COLLATE utf8_general_ci NULL  ,
    `lang` varchar(2) COLLATE utf8_general_ci NOT NULL  DEFAULT 'es' ,
    `status` int(1) NOT NULL  ,
    `translate` int(1) NOT NULL  DEFAULT 0 ,
    `owner` varchar(50) COLLATE utf8_general_ci NOT NULL  COMMENT 'entidad que convoca' ,
    `amount` int(6) NULL  COMMENT 'presupuesto' ,
    `created` date NULL  ,
    `updated` date NULL  ,
    `opened` date NULL  ,
    `published` date NULL  ,
    `success` date NULL  ,
    `closed` date NULL  ,
    `contract_name` varchar(255) COLLATE utf8_general_ci NULL  ,
    `contract_nif` varchar(10) COLLATE utf8_general_ci NULL  COMMENT 'Guardar sin espacios ni puntos ni guiones' ,
    `phone` varchar(20) COLLATE utf8_general_ci NULL  COMMENT 'guardar sin espacios ni puntos' ,
    `contract_email` varchar(255) COLLATE utf8_general_ci NULL  ,
    `address` tinytext COLLATE utf8_general_ci NULL  ,
    `zipcode` varchar(10) COLLATE utf8_general_ci NULL  ,
    `location` varchar(255) COLLATE utf8_general_ci NULL  ,
    `country` varchar(50) COLLATE utf8_general_ci NULL  ,
    `logo` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'Logo. Contiene nombre de archivo' ,
    `image` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'Imagen widget. Contiene nombre de archivo' ,
    `backimage` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'Imagen background. Contiene nombre de archivo' ,
    `description` longtext COLLATE utf8_general_ci NULL  ,
    `whom` text COLLATE utf8_general_ci NULL  ,
    `apply` text COLLATE utf8_general_ci NULL  ,
    `legal` longtext COLLATE utf8_general_ci NULL  ,
    `dossier` tinytext COLLATE utf8_general_ci NULL  ,
    `tweet` tinytext COLLATE utf8_general_ci NULL  ,
    `fbappid` tinytext COLLATE utf8_general_ci NULL  ,
    `call_location` varchar(256) COLLATE utf8_general_ci NULL  ,
    `resources` text COLLATE utf8_general_ci NULL  COMMENT 'Recursos de capital riego' ,
    `scope` int(1) NULL  ,
    `contract_entity` int(1) NOT NULL  DEFAULT 0 ,
    `contract_birthdate` date NULL  ,
    `entity_office` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'Cargo del responsable' ,
    `entity_name` varchar(255) COLLATE utf8_general_ci NULL  ,
    `entity_cif` varchar(10) COLLATE utf8_general_ci NULL  COMMENT 'Guardar sin espacios ni puntos ni guiones' ,
    `post_address` tinytext COLLATE utf8_general_ci NULL  ,
    `secondary_address` int(11) NOT NULL  DEFAULT 0 ,
    `post_zipcode` varchar(10) COLLATE utf8_general_ci NULL  ,
    `post_location` varchar(255) COLLATE utf8_general_ci NULL  ,
    `post_country` varchar(50) COLLATE utf8_general_ci NULL  ,
    `days` int(2) NULL  ,
    `maxdrop` int(6) NULL  COMMENT 'Riego maximo por aporte' ,
    `modemaxp` varchar(3) COLLATE utf8_general_ci NULL  DEFAULT 'imp' COMMENT 'Modalidad del máximo por proyecto: imp = importe, per = porcentaje' ,
    `maxproj` int(6) NULL  COMMENT 'Riego maximo por proyecto' ,
    `num_projects` int(10) unsigned NULL  COMMENT 'Número de proyectos publicados' ,
    `rest` int(10) unsigned NULL  COMMENT 'Importe riego disponible' ,
    `used` int(10) unsigned NULL  COMMENT 'Importe riego comprometido' ,
    `applied` int(10) unsigned NULL  COMMENT 'Número de proyectos aplicados' ,
    `running_projects` int(10) unsigned NULL  COMMENT 'Número de proyectos en campaña' ,
    `success_projects` int(10) unsigned NULL  COMMENT 'Número de proyectos exitosos' ,
    PRIMARY KEY (`id`) ,
    KEY `owner`(`owner`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Convocatorias';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `call_banner`(
    `id` bigint(20) unsigned NOT NULL  auto_increment ,
    `call` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `name` tinytext COLLATE utf8_general_ci NOT NULL  ,
    `url` tinytext COLLATE utf8_general_ci NULL  ,
    `image` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'Contiene nombre de archivo' ,
    `order` int(11) NOT NULL  DEFAULT 1 ,
    PRIMARY KEY (`id`) ,
    UNIQUE KEY `id`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Banners de convocatorias';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `call_banner_lang`(
    `id` int(20) NOT NULL  ,
    `lang` varchar(2) COLLATE utf8_general_ci NOT NULL  ,
    `name` tinytext COLLATE utf8_general_ci NULL  ,
    `pending` int(1) NULL  DEFAULT 0 COMMENT 'Debe revisarse la traducción' ,
    UNIQUE KEY `id_lang`(`id`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `call_category`(
    `call` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `category` int(12) NOT NULL  ,
    UNIQUE KEY `call_category`(`call`,`category`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Categorias de las convocatorias';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `call_conf`(
    `call` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `applied` int(4) NULL  COMMENT 'Para fijar numero de proyectos recibidos' ,
    `limit1` set('normal','minimum','unlimited','none') COLLATE utf8_general_ci NOT NULL  DEFAULT 'normal' COMMENT 'tipo limite riego primera ronda' ,
    `limit2` set('normal','minimum','unlimited','none') COLLATE utf8_general_ci NOT NULL  DEFAULT 'none' COMMENT 'tipo limite riego segunda ronda' ,
    `buzz_first` int(1) NOT NULL  DEFAULT 0 COMMENT 'Solo primer hashtag en el buzz' ,
    `buzz_own` int(1) NOT NULL  DEFAULT 1 COMMENT 'Tweets  propios en el buzz' ,
    `buzz_mention` int(1) NOT NULL  DEFAULT 1 COMMENT 'Menciones en el buzz' ,
    PRIMARY KEY (`call`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Configuración de convocatoria';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `call_icon`(
    `call` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `icon` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    UNIQUE KEY `call_icon`(`call`,`icon`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Tipos de retorno de las convocatorias';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `call_lang`(
    `id` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `lang` varchar(2) COLLATE utf8_general_ci NOT NULL  ,
    `name` tinytext COLLATE utf8_general_ci NULL  ,
    `description` longtext COLLATE utf8_general_ci NULL  ,
    `whom` text COLLATE utf8_general_ci NULL  ,
    `apply` text COLLATE utf8_general_ci NULL  ,
    `legal` longtext COLLATE utf8_general_ci NULL  ,
    `subtitle` text COLLATE utf8_general_ci NULL  ,
    `dossier` tinytext COLLATE utf8_general_ci NULL  ,
    `tweet` tinytext COLLATE utf8_general_ci NULL  ,
    `resources` text COLLATE utf8_general_ci NULL  COMMENT 'Recursos de capital riego' ,
    `pending` int(1) NULL  DEFAULT 0 COMMENT 'Debe revisarse la traducción' ,
    UNIQUE KEY `id_lang`(`id`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `call_post`(
    `call` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `post` int(20) NOT NULL  ,
    UNIQUE KEY `call_post`(`call`,`post`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Entradas de blog asignadas a convocatorias';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `call_project`(
    `call` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `project` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    UNIQUE KEY `call_project`(`call`,`project`) ,
    KEY `call_project_ibfk_2`(`project`) ,
    CONSTRAINT `call_project_ibfk_1`
    FOREIGN KEY (`call`) REFERENCES `call` (`id`) ON UPDATE CASCADE ,
    CONSTRAINT `call_project_ibfk_2`
    FOREIGN KEY (`project`) REFERENCES `project` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Proyectos asignados a convocatorias';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `call_sponsor`(
    `id` bigint(20) unsigned NOT NULL  auto_increment ,
    `call` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `name` tinytext COLLATE utf8_general_ci NOT NULL  ,
    `url` tinytext COLLATE utf8_general_ci NULL  ,
    `image` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'Contiene nombre de archivo' ,
    `order` int(11) NOT NULL  DEFAULT 1 ,
    PRIMARY KEY (`id`) ,
    UNIQUE KEY `id`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Patrocinadores de convocatorias';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `campaign`(
    `id` bigint(20) unsigned NOT NULL  auto_increment ,
    `node` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `call` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `active` int(1) NOT NULL  DEFAULT 0 ,
    `order` smallint(5) unsigned NOT NULL  DEFAULT 1 ,
    PRIMARY KEY (`id`) ,
    UNIQUE KEY `id`(`id`) ,
    UNIQUE KEY `call_node`(`node`,`call`) ,
    CONSTRAINT `campaign_ibfk_1`
    FOREIGN KEY (`node`) REFERENCES `node` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Convocatorias en portada';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `conf`(
    `key` varchar(255) COLLATE utf8_general_ci NOT NULL  COMMENT 'Clave' ,
    `value` varchar(255) COLLATE utf8_general_ci NOT NULL  COMMENT 'Valor'
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Para guardar pares para configuraciones, bloqueos etc';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `contract`(
    `project` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `number` int(11) NOT NULL  auto_increment ,
    `date` date NOT NULL  COMMENT 'dia anterior a la publicacion' ,
    `enddate` date NOT NULL  COMMENT 'finalización, un año despues de la fecha de contrato' ,
    `pdf` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'Archivo pdf contrato' ,
    `type` varchar(1) COLLATE utf8_general_ci NOT NULL  DEFAULT '0' COMMENT '0 = persona física; 1 = representante asociacion; 2 = apoderado entidad mercantil' ,
    `name` tinytext COLLATE utf8_general_ci NULL  ,
    `nif` varchar(10) COLLATE utf8_general_ci NULL  ,
    `office` tinytext COLLATE utf8_general_ci NULL  COMMENT 'Cargo en la asociación o empresa' ,
    `address` tinytext COLLATE utf8_general_ci NULL  ,
    `location` varchar(255) COLLATE utf8_general_ci NULL  ,
    `region` varchar(255) COLLATE utf8_general_ci NULL  ,
    `zipcode` varchar(8) COLLATE utf8_general_ci NULL  ,
    `country` varchar(50) COLLATE utf8_general_ci NULL  ,
    `entity_name` tinytext COLLATE utf8_general_ci NULL  ,
    `entity_cif` varchar(10) COLLATE utf8_general_ci NULL  ,
    `entity_address` tinytext COLLATE utf8_general_ci NULL  ,
    `entity_location` varchar(255) COLLATE utf8_general_ci NULL  ,
    `entity_region` varchar(255) COLLATE utf8_general_ci NULL  ,
    `entity_zipcode` varchar(8) COLLATE utf8_general_ci NULL  ,
    `entity_country` varchar(50) COLLATE utf8_general_ci NULL  ,
    `reg_name` tinytext COLLATE utf8_general_ci NULL  COMMENT 'Nombre y ciudad del registro en el que esta inscrita la entidad' ,
    `reg_date` date NULL  ,
    `reg_number` tinytext COLLATE utf8_general_ci NULL  COMMENT 'Número de registro' ,
    `reg_loc` tinytext COLLATE utf8_general_ci NULL  COMMENT 'NO SE USA (borrar)' ,
    `reg_id` tinytext COLLATE utf8_general_ci NULL  COMMENT 'Número de protocolo del notario' ,
    `reg_idname` tinytext COLLATE utf8_general_ci NULL  COMMENT 'Nombre del notario' ,
    `reg_idloc` tinytext COLLATE utf8_general_ci NULL  COMMENT 'Ciudad de actuación del notario' ,
    `project_name` tinytext COLLATE utf8_general_ci NULL  COMMENT 'Nombre del proyecto' ,
    `project_url` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'URL del proyecto' ,
    `project_owner` tinytext COLLATE utf8_general_ci NULL  COMMENT 'Nombre del impulsor' ,
    `project_user` tinytext COLLATE utf8_general_ci NULL  COMMENT 'Nombre del usuario autor del proyecto' ,
    `project_profile` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'URL del perfil del autor del proyecto' ,
    `project_description` text COLLATE utf8_general_ci NULL  COMMENT 'Breve descripción del proyecto' ,
    `project_invest` text COLLATE utf8_general_ci NULL  COMMENT 'objetivo del crowdfunding' ,
    `project_return` text COLLATE utf8_general_ci NULL  COMMENT 'retornos' ,
    `bank` tinytext COLLATE utf8_general_ci NULL  ,
    `bank_owner` tinytext COLLATE utf8_general_ci NULL  ,
    `paypal` tinytext COLLATE utf8_general_ci NULL  ,
    `paypal_owner` tinytext COLLATE utf8_general_ci NULL  ,
    `birthdate` date NULL  ,
    PRIMARY KEY (`project`) ,
    UNIQUE KEY `numero`(`number`) ,
    CONSTRAINT `contract_ibfk_1`
    FOREIGN KEY (`project`) REFERENCES `project` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Contratos';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `contract_status`(
    `contract` varchar(50) COLLATE utf8_general_ci NOT NULL  COMMENT 'Id del proyecto' ,
    `owner` int(1) NOT NULL  DEFAULT 0 COMMENT 'El impulsor ha dado por rellenados los datos' ,
    `owner_date` date NULL  COMMENT 'Fecha que se cambia el flag' ,
    `owner_user` varchar(50) COLLATE utf8_general_ci NULL  COMMENT 'Usuario que cambia el flag' ,
    `admin` int(1) NOT NULL  DEFAULT 0 COMMENT 'El admin ha comenzado a revisar los datos' ,
    `admin_date` date NULL  COMMENT 'Fecha que se cambia el flag' ,
    `admin_user` varchar(50) COLLATE utf8_general_ci NULL  COMMENT 'Usuario que cambia el flag' ,
    `ready` int(1) NOT NULL  DEFAULT 0 COMMENT 'Datos verificados y correctos' ,
    `ready_date` date NULL  COMMENT 'Fecha que se cambia el flag' ,
    `ready_user` varchar(50) COLLATE utf8_general_ci NULL  COMMENT 'Usuario que cambia el flag' ,
    `pdf` int(1) NOT NULL  COMMENT 'El impulsor ha descargado el pdf' ,
    `pdf_date` date NULL  COMMENT 'Fecha que se cambia el flag' ,
    `pdf_user` varchar(50) COLLATE utf8_general_ci NULL  COMMENT 'Usuario que cambia el flag' ,
    `recieved` int(1) NOT NULL  DEFAULT 0 COMMENT 'Se ha recibido el contrato firmado' ,
    `recieved_date` date NULL  COMMENT 'Fecha que se cambia el flag' ,
    `recieved_user` varchar(50) COLLATE utf8_general_ci NULL  COMMENT 'Usuario que cambia el flag' ,
    `payed` int(1) NOT NULL  DEFAULT 0 COMMENT 'Se ha realizado el pago al proyecto' ,
    `payed_date` date NULL  COMMENT 'Fecha que se cambia el flag' ,
    `payed_user` varchar(50) COLLATE utf8_general_ci NULL  COMMENT 'Usuario que cambia el flag' ,
    `prepay` int(1) NOT NULL  DEFAULT 0 COMMENT 'Ha habido pago avanzado' ,
    `prepay_date` date NULL  COMMENT 'Fecha que se cambia el flag' ,
    `prepay_user` varchar(50) COLLATE utf8_general_ci NULL  COMMENT 'Usuario que cambia el flag' ,
    `closed` int(1) NOT NULL  DEFAULT 0 COMMENT 'Contrato finiquitado' ,
    `closed_date` date NULL  COMMENT 'Fecha que se cambia el flag' ,
    `closed_user` varchar(50) COLLATE utf8_general_ci NULL  COMMENT 'Usuario que cambia el flag' ,
    PRIMARY KEY (`contract`) ,
    CONSTRAINT `contract_status_ibfk_1`
    FOREIGN KEY (`contract`) REFERENCES `contract` (`project`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Seguimiento de estado de contrato';


/* Alter table in target */
ALTER TABLE `cost`
    ADD COLUMN `order` int(10) unsigned   NOT NULL DEFAULT 1 after `until` ,
    DROP KEY `id` ,
    ADD KEY `order`(`order`) ;

/* Create table in target */
CREATE TABLE IF NOT EXISTS `donor`(
    `id` bigint(20) unsigned NOT NULL  auto_increment ,
    `user` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `amount` int(11) NOT NULL  ,
    `name` varchar(255) COLLATE utf8_general_ci NULL  ,
    `surname` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'Apellido' ,
    `surname2` char(255) COLLATE utf8_general_ci NULL  ,
    `nif` varchar(12) COLLATE utf8_general_ci NULL  ,
    `address` tinytext COLLATE utf8_general_ci NULL  ,
    `zipcode` varchar(10) COLLATE utf8_general_ci NULL  ,
    `location` varchar(255) COLLATE utf8_general_ci NULL  ,
    `region` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'Provincia' ,
    `country` varchar(50) COLLATE utf8_general_ci NULL  ,
    `countryname` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'Nombre del pais' ,
    `gender` char(1) COLLATE utf8_general_ci NULL  ,
    `birthyear` year(4) NULL  ,
    `numproj` int(2) NULL  DEFAULT 1 ,
    `year` varchar(4) COLLATE utf8_general_ci NOT NULL  ,
    `edited` int(1) NULL  DEFAULT 0 COMMENT 'Revisados por el usuario' ,
    `confirmed` int(1) NULL  DEFAULT 0 COMMENT 'Certificado generado' ,
    `pdf` varchar(255) COLLATE utf8_general_ci NULL  COMMENT 'nombre del archivo de certificado' ,
    `created` datetime NULL  ,
    `modified` datetime NOT NULL  ,
    PRIMARY KEY (`id`) ,
    KEY `user`(`user`) ,
    KEY `year`(`year`) ,
    CONSTRAINT `donor_ibfk_1`
    FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Datos fiscales donativo';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `donor_invest`(
    `donor_id` bigint(20) unsigned NOT NULL  ,
    `invest_id` bigint(20) unsigned NOT NULL  ,
    PRIMARY KEY (`donor_id`,`invest_id`) ,
    KEY `invest_id`(`invest_id`) ,
    CONSTRAINT `donor_invest_ibfk_1`
    FOREIGN KEY (`donor_id`) REFERENCES `donor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ,
    CONSTRAINT `donor_invest_ibfk_2`
    FOREIGN KEY (`invest_id`) REFERENCES `invest` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `donor_location`(
    `id` bigint(20) unsigned NOT NULL  ,
    `latitude` decimal(16,14) NOT NULL  ,
    `longitude` decimal(16,14) NOT NULL  ,
    `method` varchar(50) COLLATE utf8_general_ci NOT NULL  DEFAULT 'ip' ,
    `locable` tinyint(1) NOT NULL  DEFAULT 0 ,
    `city` varchar(255) COLLATE utf8_general_ci NOT NULL  ,
    `region` varchar(255) COLLATE utf8_general_ci NOT NULL  ,
    `country` varchar(150) COLLATE utf8_general_ci NOT NULL  ,
    `country_code` varchar(2) COLLATE utf8_general_ci NOT NULL  ,
    `info` varchar(255) COLLATE utf8_general_ci NULL  ,
    `modified` timestamp NOT NULL  DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP ,
    PRIMARY KEY (`id`) ,
    KEY `latitude`(`latitude`) ,
    KEY `longitude`(`longitude`) ,
    KEY `locable`(`locable`) ,
    CONSTRAINT `donor_location_ibfk_1`
    FOREIGN KEY (`id`) REFERENCES `donor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci';


/* Alter table in target */
ALTER TABLE `invest`
    CHANGE `project` `project` varchar(50)  COLLATE utf8_general_ci NULL after `user` ;

/* Create table in target */
CREATE TABLE IF NOT EXISTS `invest_location`(
    `id` bigint(20) unsigned NOT NULL  ,
    `latitude` decimal(16,14) NOT NULL  ,
    `longitude` decimal(16,14) NOT NULL  ,
    `method` varchar(50) COLLATE utf8_general_ci NOT NULL  DEFAULT 'ip' ,
    `locable` tinyint(1) NOT NULL  DEFAULT 0 ,
    `city` varchar(255) COLLATE utf8_general_ci NOT NULL  ,
    `region` varchar(255) COLLATE utf8_general_ci NOT NULL  ,
    `country` varchar(150) COLLATE utf8_general_ci NOT NULL  ,
    `country_code` varchar(2) COLLATE utf8_general_ci NOT NULL  ,
    `info` varchar(255) COLLATE utf8_general_ci NULL  ,
    `modified` timestamp NOT NULL  DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP ,
    PRIMARY KEY (`id`) ,
    KEY `latitude`(`latitude`) ,
    KEY `longitude`(`longitude`) ,
    KEY `locable`(`locable`) ,
    CONSTRAINT `invest_location_ibfk_1`
    FOREIGN KEY (`id`) REFERENCES `invest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci';


/* Alter table in target */
ALTER TABLE `invest_node`
    CHANGE `project_id` `project_id` varchar(50)  COLLATE utf8_general_ci NULL after `user_node` ,
    CHANGE `project_node` `project_node` varchar(50)  COLLATE utf8_general_ci NULL after `project_id` ;

/* Alter table in target */
ALTER TABLE `node`
    ADD COLUMN `home_img` varchar(255)  COLLATE utf8_general_ci NULL COMMENT 'Imagen para módulo canales en home' after `sponsors_limit` ;

/* Create table in target */
CREATE TABLE IF NOT EXISTS `open_tag`(
    `id` bigint(20) unsigned NOT NULL  auto_increment ,
    `name` tinytext COLLATE utf8_general_ci NULL  ,
    `description` text COLLATE utf8_general_ci NULL  ,
    `order` tinyint(3) unsigned NOT NULL  DEFAULT 1 ,
    `post` bigint(20) unsigned NULL  ,
    PRIMARY KEY (`id`) ,
    UNIQUE KEY `id`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Agrupacion de los proyectos';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `open_tag_lang`(
    `id` bigint(20) unsigned NOT NULL  ,
    `lang` varchar(2) COLLATE utf8_general_ci NOT NULL  ,
    `name` tinytext COLLATE utf8_general_ci NULL  ,
    `description` text COLLATE utf8_general_ci NULL  ,
    `pending` int(1) NULL  DEFAULT 0 COMMENT 'Debe revisarse la traducción' ,
    UNIQUE KEY `id_lang`(`id`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `patron`(
    `id` bigint(20) unsigned NOT NULL  auto_increment ,
    `node` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `project` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `user` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `title` tinytext COLLATE utf8_general_ci NULL  ,
    `description` text COLLATE utf8_general_ci NULL  ,
    `link` tinytext COLLATE utf8_general_ci NULL  ,
    `order` smallint(5) unsigned NOT NULL  DEFAULT 1 ,
    `active` int(1) NOT NULL  DEFAULT 0 ,
    PRIMARY KEY (`id`) ,
    UNIQUE KEY `user_project_node`(`node`,`project`,`user`) ,
    KEY `project`(`project`) ,
    CONSTRAINT `patron_ibfk_1`
    FOREIGN KEY (`node`) REFERENCES `node` (`id`) ON UPDATE CASCADE ,
    CONSTRAINT `patron_ibfk_2`
    FOREIGN KEY (`project`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Proyectos recomendados por padrinos';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `patron_lang`(
    `id` bigint(20) unsigned NOT NULL  ,
    `lang` varchar(2) COLLATE utf8_general_ci NOT NULL  ,
    `title` tinytext COLLATE utf8_general_ci NULL  ,
    `description` text COLLATE utf8_general_ci NULL  ,
    `pending` int(1) NULL  DEFAULT 0 COMMENT 'Debe revisarse la traducción' ,
    UNIQUE KEY `id_lang`(`id`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `patron_order`(
    `id` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `order` tinyint(3) unsigned NOT NULL  DEFAULT 1 ,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Orden de los padrinos';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `purpose`(
    `text` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `purpose` text COLLATE utf8_general_ci NOT NULL  ,
    `html` tinyint(1) NULL  COMMENT 'Si el texto lleva formato html' ,
    `group` varchar(50) COLLATE utf8_general_ci NOT NULL  DEFAULT 'general' COMMENT 'Agrupacion de uso' ,
    PRIMARY KEY (`text`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Explicación del propósito de los textos';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `purpose_copy`(
    `text` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `purpose` text COLLATE utf8_general_ci NOT NULL  ,
    `html` tinyint(1) NULL  COMMENT 'Si el texto lleva formato html' ,
    `group` varchar(50) COLLATE utf8_general_ci NOT NULL  DEFAULT 'general' COMMENT 'Agrupacion de uso' ,
    PRIMARY KEY (`text`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Explicación del propósito de los textos';


/* Create table in target */
CREATE TABLE IF NOT EXISTS `relief`(
    `id` bigint(20) unsigned NOT NULL  auto_increment ,
    `year` int(4) NOT NULL  ,
    `percentage` int(2) NOT NULL  ,
    `country` varchar(10) COLLATE utf8_general_ci NULL  ,
    `limit_amount` int(10) NOT NULL  ,
    `type` int(1) NOT NULL  ,
    PRIMARY KEY (`id`) ,
    UNIQUE KEY `id`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Desgravaciones fiscales';


/* Alter table in target */
ALTER TABLE `reward`
    DROP KEY `id` ,
    ADD KEY `order`(`order`) ;

/* Alter table in target */
ALTER TABLE `stories`
    ADD COLUMN `pool_image` varchar(255)  COLLATE utf8_general_ci NULL after `post` ,
    ADD COLUMN `pool` int(1)   NOT NULL DEFAULT 0 after `pool_image` ,
    ADD COLUMN `text_position` varchar(50)  COLLATE utf8_general_ci NULL after `pool` ;

/* Create table in target */
CREATE TABLE IF NOT EXISTS `user_call`(
    `user` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    `call` varchar(50) COLLATE utf8_general_ci NOT NULL  ,
    PRIMARY KEY (`user`,`call`)
) ENGINE=InnoDB DEFAULT CHARSET='utf8' COLLATE='utf8_general_ci' COMMENT='Asignacion de convocatorias a admines';


ALTER TABLE `relief` ADD UNIQUE INDEX (`year`, `country`, `limit_amount`, `type`);

/* The foreign keys that were dropped are now re-created*/

ALTER TABLE `invest`
    ADD CONSTRAINT `invest_ibfk_1`
    FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON UPDATE CASCADE ,
    ADD CONSTRAINT `invest_ibfk_2`
    FOREIGN KEY (`project`) REFERENCES `project` (`id`) ON UPDATE CASCADE ;

ALTER TABLE `invest_node`
    ADD CONSTRAINT `invest_node_ibfk_1`
    FOREIGN KEY (`user_node`) REFERENCES `node` (`id`) ON UPDATE CASCADE ,
    ADD CONSTRAINT `invest_node_ibfk_2`
    FOREIGN KEY (`project_node`) REFERENCES `node` (`id`) ON UPDATE CASCADE ,
    ADD CONSTRAINT `invest_node_ibfk_3`
    FOREIGN KEY (`invest_node`) REFERENCES `node` (`id`) ON UPDATE CASCADE ,
    ADD CONSTRAINT `invest_node_ibfk_4`
    FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ,
    ADD CONSTRAINT `invest_node_ibfk_5`
    FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ,
    ADD CONSTRAINT `invest_node_ibfk_6`
    FOREIGN KEY (`invest_id`) REFERENCES `invest` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
