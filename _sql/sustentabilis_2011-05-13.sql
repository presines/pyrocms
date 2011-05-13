# Sequel Pro dump
# Version 2492
# http://code.google.com/p/sequel-pro
#
# Host: 127.0.0.1 (MySQL 5.1.37)
# Database: sustentabilis
# Generation Time: 2011-05-13 02:38:47 -0500
# ************************************************************

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table blog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blog`;

CREATE TABLE `blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `category_id` int(11) NOT NULL,
  `attachment` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `intro` text COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `created_on` int(11) NOT NULL,
  `updated_on` int(11) NOT NULL DEFAULT '0',
  `comments_enabled` int(1) NOT NULL DEFAULT '1',
  `status` enum('draft','live') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'draft',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `category_id - normal` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Blog posts.';



# Dump of table blog_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blog_categories`;

CREATE TABLE `blog_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug - unique` (`slug`),
  UNIQUE KEY `title - unique` (`title`),
  KEY `slug - normal` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Blog Categories.';

LOCK TABLES `blog_categories` WRITE;
/*!40000 ALTER TABLE `blog_categories` DISABLE KEYS */;
INSERT INTO `blog_categories` (`id`,`slug`,`title`)
VALUES
	(1,'categoria-1','Categoria 1'),
	(2,'categoria-2','categoria 2');

/*!40000 ALTER TABLE `blog_categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `website` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `module` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `module_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `created_on` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `ip_address` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Comments by users or guests';



# Dump of table email_templates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `email_templates`;

CREATE TABLE `email_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `lang` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_default` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug_lang` (`slug`,`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Store dynamic email templates';

LOCK TABLES `email_templates` WRITE;
/*!40000 ALTER TABLE `email_templates` DISABLE KEYS */;
INSERT INTO `email_templates` (`id`,`slug`,`name`,`description`,`subject`,`body`,`lang`,`is_default`)
VALUES
	(1,'comments','Comment Notificiation','Email that is sent to admin when someone creates a comment','You have just received a comment from {pyro:name}','<h3>You have received a comment from {pyro:name}</h3><strong>IP Address: {pyro:sender_ip}</strong>\n<strong>Operating System: {pyro:sender_os}\n<strong>User Agent: {pyro:sender_agent}</strong>\n<div>{pyro:comment}</div>\n<div>View Comment:{pyro:redirect_url}</div>','en',1),
	(2,'contact','Contact Notification','Template for the contact form','{pyro:settings:site_name} :: {pyro:subject}','This message was sent via the contact form on with the following details:\n				<hr />\n				IP Address: {pyro:sender_ip}\n				OS {pyro:sender_os}\n				Agent {pyro:sender_agent}\n				<hr />\n				{pyro:message}\n\n				{pyro:contact_name},\n				{pyro:contact_company}','en',1);

/*!40000 ALTER TABLE `email_templates` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table file_folders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `file_folders`;

CREATE TABLE `file_folders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `date_added` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `file_folders` WRITE;
/*!40000 ALTER TABLE `file_folders` DISABLE KEYS */;
INSERT INTO `file_folders` (`id`,`parent_id`,`slug`,`name`,`date_added`)
VALUES
	(1,0,'galeria-principal','Galeria Principal',1305162737),
	(2,0,'products','products',1305170286),
	(3,0,'pdfs','pdfs',1305217165);

/*!40000 ALTER TABLE `file_folders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table files
# ------------------------------------------------------------

DROP TABLE IF EXISTS `files`;

CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folder_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '1',
  `type` enum('a','v','d','i','o') COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `mimetype` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `width` int(5) DEFAULT NULL,
  `height` int(5) DEFAULT NULL,
  `filesize` int(11) NOT NULL DEFAULT '0',
  `date_added` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` (`id`,`folder_id`,`user_id`,`type`,`name`,`filename`,`description`,`extension`,`mimetype`,`width`,`height`,`filesize`,`date_added`)
VALUES
	(1,1,1,'i','overview_hero3_20090303.jpg','overview_hero3_20090303.jpg','','.jpg','image/jpeg',984,521,24,1305162873),
	(2,1,1,'i','200718113311-4877.jpg','200718113311-4877.jpg','','.jpg','image/jpeg',2600,1127,602,1305162873),
	(3,1,1,'i','200808104421-10103.jpg','200808104421-10103.jpg','','.jpg','image/jpeg',4215,2002,3096,1305162874),
	(5,1,1,'i','1_front.jpg','1_front1.jpg','','.jpg','image/jpeg',336,224,69,1305170422);

/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table galleries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `galleries`;

CREATE TABLE `galleries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `thumbnail_id` int(11) DEFAULT NULL,
  `description` text,
  `updated_on` int(15) NOT NULL,
  `preview` varchar(255) DEFAULT NULL,
  `enable_comments` int(1) DEFAULT NULL,
  `published` int(1) DEFAULT NULL,
  `css` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `js` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `thumbnail_id` (`thumbnail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `galleries` WRITE;
/*!40000 ALTER TABLE `galleries` DISABLE KEYS */;
INSERT INTO `galleries` (`id`,`title`,`slug`,`folder_id`,`thumbnail_id`,`description`,`updated_on`,`preview`,`enable_comments`,`published`,`css`,`js`)
VALUES
	(1,'Galeria Principal','galeria-principal',1,1,'',1305162944,NULL,0,1,'','');

/*!40000 ALTER TABLE `galleries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gallery_images
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gallery_images`;

CREATE TABLE `gallery_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_id` int(11) NOT NULL,
  `gallery_id` int(11) NOT NULL,
  `order` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `gallery_id` (`gallery_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

LOCK TABLES `gallery_images` WRITE;
/*!40000 ALTER TABLE `gallery_images` DISABLE KEYS */;
INSERT INTO `gallery_images` (`id`,`file_id`,`gallery_id`,`order`)
VALUES
	(1,1,1,1),
	(2,2,1,2),
	(3,3,1,3),
	(5,5,1,5);

/*!40000 ALTER TABLE `gallery_images` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `groups`;

CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Permission roles such as admins, moderators, staff, etc';

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` (`id`,`name`,`description`)
VALUES
	(1,'admin','Administrators'),
	(2,'user','Users');

/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table modules
# ------------------------------------------------------------

DROP TABLE IF EXISTS `modules`;

CREATE TABLE `modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `skip_xss` tinyint(1) NOT NULL,
  `is_frontend` tinyint(1) NOT NULL,
  `is_backend` tinyint(1) NOT NULL,
  `menu` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `installed` tinyint(1) NOT NULL,
  `is_core` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` (`id`,`name`,`slug`,`version`,`type`,`description`,`skip_xss`,`is_frontend`,`is_backend`,`menu`,`enabled`,`installed`,`is_core`)
VALUES
	(1,'a:7:{s:2:\"en\";s:4:\"Blog\";s:2:\"ar\";s:16:\"المدوّنة\";s:2:\"el\";s:18:\"Ιστολόγιο\";s:2:\"pt\";s:4:\"Blog\";s:2:\"he\";s:8:\"בלוג\";s:2:\"lt\";s:6:\"Blogas\";s:2:\"ru\";s:8:\"Блог\";}','blog','2.0',NULL,'a:17:{s:2:\"en\";s:18:\"Post blog entries.\";s:2:\"nl\";s:40:\"Post nieuwsartikelen en blog op uw site.\";s:2:\"es\";s:54:\"Escribe entradas para los artículos y blog (web log).\";s:2:\"fr\";s:46:\"Envoyez de nouveaux posts et messages de blog.\";s:2:\"de\";s:47:\"Veröffentliche neue Artikel und Blog-Einträge\";s:2:\"pl\";s:40:\"Postuj nowe artykuły oraz wpisy w blogu\";s:2:\"pt\";s:30:\"Escrever publicações de blog\";s:2:\"zh\";s:39:\"發表新聞訊息、部落格文章。\";s:2:\"it\";s:36:\"Pubblica notizie e post per il blog.\";s:2:\"ru\";s:49:\"Управление записями блога.\";s:2:\"ar\";s:48:\"أنشر المقالات على مدوّنتك.\";s:2:\"cs\";s:49:\"Publikujte nové články a příspěvky na blog.\";s:2:\"sl\";s:23:\"Objavite blog prispevke\";s:2:\"fi\";s:50:\"Kirjoita uutisartikkeleita tai blogi artikkeleita.\";s:2:\"el\";s:93:\"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.\";s:2:\"he\";s:19:\"ניהול בלוג\";s:2:\"lt\";s:40:\"Rašykite naujienas bei blog\'o įrašus.\";}',1,1,1,'content',1,1,1),
	(2,'a:17:{s:2:\"sl\";s:10:\"Komentarji\";s:2:\"en\";s:8:\"Comments\";s:2:\"pt\";s:12:\"Comentários\";s:2:\"nl\";s:8:\"Reacties\";s:2:\"es\";s:11:\"Comentarios\";s:2:\"fr\";s:12:\"Commentaires\";s:2:\"de\";s:10:\"Kommentare\";s:2:\"pl\";s:10:\"Komentarze\";s:2:\"zh\";s:6:\"回應\";s:2:\"it\";s:8:\"Commenti\";s:2:\"ru\";s:22:\"Комментарии\";s:2:\"ar\";s:18:\"التعليقات\";s:2:\"cs\";s:11:\"Komentáře\";s:2:\"fi\";s:9:\"Kommentit\";s:2:\"el\";s:12:\"Σχόλια\";s:2:\"he\";s:12:\"תגובות\";s:2:\"lt\";s:10:\"Komentarai\";}','comments','1.0',NULL,'a:17:{s:2:\"sl\";s:89:\"Uporabniki in obiskovalci lahko vnesejo komentarje na vsebino kot je blok, stra ali slike\";s:2:\"en\";s:76:\"Users and guests can write comments for content like blog, pages and photos.\";s:2:\"pt\";s:97:\"Usuários e convidados podem escrever comentários para quase tudo com suporte nativo ao captcha.\";s:2:\"nl\";s:52:\"Gebruikers en gasten kunnen reageren op bijna alles.\";s:2:\"es\";s:130:\"Los usuarios y visitantes pueden escribir comentarios en casi todo el contenido con el soporte de un sistema de captcha incluído.\";s:2:\"fr\";s:130:\"Les utilisateurs et les invités peuvent écrire des commentaires pour quasiment tout grâce au générateur de captcha intégré.\";s:2:\"de\";s:65:\"Benutzer und Gäste können für fast alles Kommentare schreiben.\";s:2:\"pl\";s:93:\"Użytkownicy i goście mogą dodawać komentarze z wbudowanym systemem zabezpieczeń captcha.\";s:2:\"zh\";s:75:\"用戶和訪客可以針對新聞、頁面與照片等內容發表回應。\";s:2:\"it\";s:85:\"Utenti e visitatori possono scrivere commenti ai contenuti quali blog, pagine e foto.\";s:2:\"ru\";s:187:\"Пользователи и гости могут добавлять комментарии к новостям, информационным страницам и фотографиям.\";s:2:\"ar\";s:152:\"يستطيع الأعضاء والزوّار كتابة التعليقات على المُحتوى كالأخبار، والصفحات والصّوَر.\";s:2:\"cs\";s:100:\"Uživatelé a hosté mohou psát komentáře k obsahu, např. neovinkám, stránkám a fotografiím.\";s:2:\"fi\";s:107:\"Käyttäjät ja vieraat voivat kirjoittaa kommentteja eri sisältöihin kuten uutisiin, sivuihin ja kuviin.\";s:2:\"el\";s:224:\"Οι χρήστες και οι επισκέπτες μπορούν να αφήνουν σχόλια για περιεχόμενο όπως το ιστολόγιο, τις σελίδες και τις φωτογραφίες.\";s:2:\"he\";s:94:\"משתמשי האתר יכולים לרשום תגובות למאמרים, תמונות וכו\";s:2:\"lt\";s:75:\"Vartotojai ir svečiai gali komentuoti jūsų naujienas, puslapius ar foto.\";}',0,0,1,'content',1,1,1),
	(3,'a:17:{s:2:\"sl\";s:7:\"Kontakt\";s:2:\"en\";s:7:\"Contact\";s:2:\"nl\";s:7:\"Contact\";s:2:\"pl\";s:7:\"Kontakt\";s:2:\"es\";s:8:\"Contacto\";s:2:\"fr\";s:7:\"Contact\";s:2:\"de\";s:7:\"Kontakt\";s:2:\"zh\";s:12:\"聯絡我們\";s:2:\"it\";s:10:\"Contattaci\";s:2:\"ru\";s:27:\"Обратная связь\";s:2:\"ar\";s:14:\"الإتصال\";s:2:\"pt\";s:7:\"Contato\";s:2:\"cs\";s:7:\"Kontakt\";s:2:\"fi\";s:13:\"Ota yhteyttä\";s:2:\"el\";s:22:\"Επικοινωνία\";s:2:\"he\";s:17:\"יצירת קשר\";s:2:\"lt\";s:18:\"Kontaktinė formą\";}','contact','0.6',NULL,'a:17:{s:2:\"sl\";s:113:\"Dodaj obrazec za kontakt da vam lahko obiskovalci pošljejo sporočilo brez da bi jim razkrili vaš email naslov.\";s:2:\"en\";s:112:\"Adds a form to your site that allows visitors to send emails to you without disclosing an email address to them.\";s:2:\"nl\";s:125:\"Voegt een formulier aan de site toe waarmee bezoekers een email kunnen sturen, zonder dat u ze een emailadres hoeft te tonen.\";s:2:\"pl\";s:126:\"Dodaje formularz kontaktowy do Twojej strony, który pozwala użytkownikom wysłanie maila za pomocą formularza kontaktowego.\";s:2:\"es\";s:156:\"Añade un formulario a tu sitio que permitirá a los visitantes enviarte correos electrónicos a ti sin darles tu dirección de correo directamente a ellos.\";s:2:\"fr\";s:122:\"Ajoute un formulaire à votre site qui permet aux visiteurs de vous envoyer un e-mail sans révéler votre adresse e-mail.\";s:2:\"de\";s:119:\"Fügt ein Formular hinzu, welches Besuchern erlaubt Emails zu schreiben, ohne die Kontakt Email-Adresse offen zu legen.\";s:2:\"zh\";s:147:\"為您的網站新增「聯絡我們」的功能，對訪客是較為清楚便捷的聯絡方式，也無須您將電子郵件公開在網站上。\";s:2:\"it\";s:119:\"Aggiunge un modulo al tuo sito che permette ai visitatori di inviarti email senza mostrare loro il tuo indirizzo email.\";s:2:\"ru\";s:234:\"Добавляет форму обратной связи на сайт, через которую посетители могут отправлять вам письма, при этом адрес Email остаётся скрыт.\";s:2:\"ar\";s:157:\"إضافة استمارة إلى موقعك تُمكّن الزوّار من مراسلتك دون علمهم بعنوان البريد الإلكتروني.\";s:2:\"pt\";s:139:\"Adiciona um formulário para o seu site permitir aos visitantes que enviem e-mails para voce sem divulgar um endereço de e-mail para eles.\";s:2:\"cs\";s:149:\"Přidá na web kontaktní formulář pro návštěvníky a uživatele, díky kterému vás mohou kontaktovat i bez znalosti vaší e-mailové adresy.\";s:2:\"fi\";s:128:\"Luo lomakkeen sivustollesi, josta kävijät voivat lähettää sähköpostia tietämättä vastaanottajan sähköpostiosoitetta.\";s:2:\"el\";s:273:\"Προσθέτει μια φόρμα στον ιστότοπό σας που επιτρέπει σε επισκέπτες να σας στέλνουν μηνύμα μέσω email χωρίς να τους αποκαλύπτεται η διεύθυνση του email σας.\";s:2:\"he\";s:155:\"מוסיף תופס יצירת קשר לאתר על מנת לא לחסוף כתובת דואר האלקטרוני של האתר למנועי פרסומות\";s:2:\"lt\";s:124:\"Prideda jūsų puslapyje formą leidžianti lankytojams siūsti jums el. laiškus neatskleidžiant jūsų el. pašto adreso.\";}',0,1,0,'0',1,1,1),
	(4,'a:16:{s:2:\"sl\";s:8:\"Datoteke\";s:2:\"en\";s:5:\"Files\";s:2:\"pt\";s:8:\"Arquivos\";s:2:\"de\";s:7:\"Dateien\";s:2:\"nl\";s:9:\"Bestanden\";s:2:\"fr\";s:8:\"Fichiers\";s:2:\"zh\";s:6:\"檔案\";s:2:\"it\";s:4:\"File\";s:2:\"ru\";s:10:\"Файлы\";s:2:\"ar\";s:16:\"الملفّات\";s:2:\"cs\";s:7:\"Soubory\";s:2:\"es\";s:8:\"Archivos\";s:2:\"fi\";s:9:\"Tiedostot\";s:2:\"el\";s:12:\"Αρχεία\";s:2:\"he\";s:10:\"קבצים\";s:2:\"lt\";s:6:\"Failai\";}','files','1.2',NULL,'a:16:{s:2:\"sl\";s:38:\"Uredi datoteke in mape na vaši strani\";s:2:\"en\";s:40:\"Manages files and folders for your site.\";s:2:\"pt\";s:53:\"Permite gerenciar facilmente os arquivos de seu site.\";s:2:\"de\";s:35:\"Verwalte Dateien und Verzeichnisse.\";s:2:\"nl\";s:42:\"Beheer bestanden en folders op uw website.\";s:2:\"fr\";s:46:\"Gérer les fichiers et dossiers de votre site.\";s:2:\"zh\";s:33:\"管理網站中的檔案與目錄\";s:2:\"it\";s:38:\"Gestisci file e cartelle del tuo sito.\";s:2:\"ru\";s:78:\"Управление файлами и папками вашего сайта.\";s:2:\"ar\";s:50:\"إدارة ملفات ومجلّدات موقعك.\";s:2:\"cs\";s:43:\"Spravujte soubory a složky na vašem webu.\";s:2:\"es\";s:43:\"Administra archivos y carpetas en tu sitio.\";s:2:\"fi\";s:43:\"Hallitse sivustosi tiedostoja ja kansioita.\";s:2:\"el\";s:100:\"Διαχειρίζεται αρχεία και φακέλους για το ιστότοπό σας.\";s:2:\"he\";s:47:\"ניהול תיקיות וקבצים שבאתר\";s:2:\"lt\";s:28:\"Katalogų ir bylų valdymas.\";}',0,0,1,'content',1,1,1),
	(5,'a:16:{s:2:\"sl\";s:7:\"Skupine\";s:2:\"en\";s:6:\"Groups\";s:2:\"pt\";s:6:\"Grupos\";s:2:\"de\";s:7:\"Gruppen\";s:2:\"nl\";s:7:\"Groepen\";s:2:\"fr\";s:7:\"Groupes\";s:2:\"zh\";s:6:\"群組\";s:2:\"it\";s:6:\"Gruppi\";s:2:\"ru\";s:12:\"Группы\";s:2:\"ar\";s:18:\"المجموعات\";s:2:\"cs\";s:7:\"Skupiny\";s:2:\"es\";s:6:\"Grupos\";s:2:\"fi\";s:7:\"Ryhmät\";s:2:\"el\";s:12:\"Ομάδες\";s:2:\"he\";s:12:\"קבוצות\";s:2:\"lt\";s:7:\"Grupės\";}','groups','1.0',NULL,'a:16:{s:2:\"sl\";s:64:\"Uporabniki so lahko razvrščeni v skupine za urejanje dovoljenj\";s:2:\"en\";s:54:\"Users can be placed into groups to manage permissions.\";s:2:\"pt\";s:72:\"Usuários podem ser inseridos em grupos para gerenciar suas permissões.\";s:2:\"de\";s:85:\"Benutzer können zu Gruppen zusammengefasst werden um diesen Zugriffsrechte zu geben.\";s:2:\"nl\";s:73:\"Gebruikers kunnen in groepen geplaatst worden om rechten te kunnen geven.\";s:2:\"fr\";s:82:\"Les utilisateurs peuvent appartenir à des groupes afin de gérer les permissions.\";s:2:\"zh\";s:45:\"用戶可以依群組分類並管理其權限\";s:2:\"it\";s:69:\"Gli utenti possono essere inseriti in gruppi per gestirne i permessi.\";s:2:\"ru\";s:134:\"Пользователей можно объединять в группы, для управления правами доступа.\";s:2:\"ar\";s:100:\"يمكن وضع المستخدمين في مجموعات لتسهيل إدارة صلاحياتهم.\";s:2:\"cs\";s:77:\"Uživatelé mohou být rozřazeni do skupin pro lepší správu oprávnění.\";s:2:\"es\";s:75:\"Los usuarios podrán ser colocados en grupos para administrar sus permisos.\";s:2:\"fi\";s:84:\"Käyttäjät voidaan liittää ryhmiin, jotta käyttöoikeuksia voidaan hallinnoida.\";s:2:\"el\";s:159:\"Οι χρήστες μπορούν να τοποθετηθούν σε ομάδες και να διαχειριστείτε τα δικαιώματά τους.\";s:2:\"he\";s:62:\"נותן אפשרות לאסוף משתמשים לקבוצות\";s:2:\"lt\";s:67:\"Vartotojai gali būti priskirti grupei tam, kad valdyti jų teises.\";}',0,0,1,'users',1,1,1),
	(6,'a:17:{s:2:\"sl\";s:6:\"Moduli\";s:2:\"en\";s:7:\"Modules\";s:2:\"nl\";s:7:\"Modules\";s:2:\"es\";s:8:\"Módulos\";s:2:\"fr\";s:7:\"Modules\";s:2:\"de\";s:6:\"Module\";s:2:\"pl\";s:7:\"Moduły\";s:2:\"pt\";s:8:\"Módulos\";s:2:\"zh\";s:6:\"模組\";s:2:\"it\";s:6:\"Moduli\";s:2:\"ru\";s:12:\"Модули\";s:2:\"ar\";s:14:\"الوحدات\";s:2:\"cs\";s:6:\"Moduly\";s:2:\"fi\";s:8:\"Moduulit\";s:2:\"el\";s:16:\"Πρόσθετα\";s:2:\"he\";s:14:\"מודולים\";s:2:\"lt\";s:8:\"Moduliai\";}','modules','1.0',NULL,'a:17:{s:2:\"sl\";s:65:\"Dovoljuje administratorjem pregled trenutno nameščenih modulov.\";s:2:\"en\";s:59:\"Allows admins to see a list of currently installed modules.\";s:2:\"nl\";s:79:\"Stelt admins in staat om een overzicht van geinstalleerde modules te genereren.\";s:2:\"es\";s:71:\"Permite a los administradores ver una lista de los módulos instalados.\";s:2:\"fr\";s:66:\"Permet aux administrateurs de voir la liste des modules installés\";s:2:\"de\";s:56:\"Zeigt Administratoren alle aktuell installierten Module.\";s:2:\"pl\";s:81:\"Umożliwiają administratorowi wgląd do listy obecnie zainstalowanych modułów.\";s:2:\"pt\";s:75:\"Permite aos administradores ver a lista dos módulos instalados atualmente.\";s:2:\"zh\";s:54:\"管理員可以檢視目前已經安裝模組的列表\";s:2:\"it\";s:83:\"Permette agli amministratori di vedere una lista dei moduli attualmente installati.\";s:2:\"ru\";s:83:\"Список модулей, которые установлены на сайте.\";s:2:\"ar\";s:91:\"تُمكّن المُدراء من معاينة جميع الوحدات المُثبّتة.\";s:2:\"cs\";s:68:\"Umožňuje administrátorům vidět seznam nainstalovaných modulů.\";s:2:\"fi\";s:60:\"Listaa järjestelmänvalvojalle käytössä olevat moduulit.\";s:2:\"el\";s:152:\"Επιτρέπει στους διαχειριστές να προβάλουν μια λίστα των εγκατεστημένων πρόσθετων.\";s:2:\"he\";s:160:\"נותן אופציה למנהל לראות רשימה של המודולים אשר מותקנים כעת באתר או להתקין מודולים נוספים\";s:2:\"lt\";s:75:\"Vartotojai ir svečiai gali komentuoti jūsų naujienas, puslapius ar foto.\";}',0,0,1,'0',1,1,1),
	(7,'a:17:{s:2:\"sl\";s:10:\"Navigacija\";s:2:\"en\";s:10:\"Navigation\";s:2:\"nl\";s:9:\"Navigatie\";s:2:\"es\";s:11:\"Navegación\";s:2:\"fr\";s:10:\"Navigation\";s:2:\"de\";s:10:\"Navigation\";s:2:\"pl\";s:9:\"Nawigacja\";s:2:\"pt\";s:11:\"Navegação\";s:2:\"zh\";s:9:\"導航列\";s:2:\"it\";s:11:\"Navigazione\";s:2:\"ru\";s:18:\"Навигация\";s:2:\"ar\";s:14:\"الروابط\";s:2:\"cs\";s:8:\"Navigace\";s:2:\"fi\";s:10:\"Navigointi\";s:2:\"el\";s:16:\"Πλοήγηση\";s:2:\"he\";s:10:\"ניווט\";s:2:\"lt\";s:10:\"Navigacija\";}','navigation','1.1',NULL,'a:17:{s:2:\"sl\";s:64:\"Uredi povezave v meniju in vse skupine povezav ki jim pripadajo.\";s:2:\"en\";s:78:\"Manage links on navigation menus and all the navigation groups they belong to.\";s:2:\"nl\";s:86:\"Beheer links op de navigatiemenu&apos;s en alle navigatiegroepen waar ze onder vallen.\";s:2:\"es\";s:102:\"Administra links en los menús de navegación y en todos los grupos de navegación al cual pertenecen.\";s:2:\"fr\";s:97:\"Gérer les liens du menu Navigation et tous les groupes de navigation auxquels ils appartiennent.\";s:2:\"de\";s:76:\"Verwalte Links in Navigationsmenüs und alle zugehörigen Navigationsgruppen\";s:2:\"pl\";s:95:\"Zarządzaj linkami w menu nawigacji oraz wszystkimi grupami nawigacji do których one należą.\";s:2:\"pt\";s:91:\"Gerenciar links do menu de navegação e todos os grupos de navegação pertencentes a ele.\";s:2:\"zh\";s:72:\"管理導航選單中的連結，以及它們所隸屬的導航群組。\";s:2:\"it\";s:97:\"Gestisci i collegamenti dei menu di navigazione e tutti i gruppi di navigazione da cui dipendono.\";s:2:\"ru\";s:136:\"Управление ссылками в меню навигации и группах, к которым они принадлежат.\";s:2:\"ar\";s:85:\"إدارة روابط وقوائم ومجموعات الروابط في الموقع.\";s:2:\"cs\";s:73:\"Správa odkazů v navigaci a všech souvisejících navigačních skupin.\";s:2:\"fi\";s:91:\"Hallitse linkkejä navigointi valikoissa ja kaikkia navigointi ryhmiä, joihin ne kuuluvat.\";s:2:\"el\";s:207:\"Διαχειριστείτε τους συνδέσμους στα μενού πλοήγησης και όλες τις ομάδες συνδέσμων πλοήγησης στις οποίες ανήκουν.\";s:2:\"he\";s:73:\"ניהול שלוחות תפריטי ניווט וקבוצות ניווט\";s:2:\"lt\";s:95:\"Tvarkyk nuorodas navigacijų menių ir visas navigacijų grupes kurioms tos nuorodos priklauso.\";}',0,0,1,'design',1,1,1),
	(8,'a:17:{s:2:\"sl\";s:6:\"Strani\";s:2:\"en\";s:5:\"Pages\";s:2:\"nl\";s:13:\"Pagina&apos;s\";s:2:\"es\";s:8:\"Páginas\";s:2:\"fr\";s:5:\"Pages\";s:2:\"de\";s:6:\"Seiten\";s:2:\"pl\";s:6:\"Strony\";s:2:\"pt\";s:8:\"Páginas\";s:2:\"zh\";s:6:\"頁面\";s:2:\"it\";s:6:\"Pagine\";s:2:\"ru\";s:16:\"Страницы\";s:2:\"ar\";s:14:\"الصفحات\";s:2:\"cs\";s:8:\"Stránky\";s:2:\"fi\";s:5:\"Sivut\";s:2:\"el\";s:14:\"Σελίδες\";s:2:\"he\";s:8:\"דפים\";s:2:\"lt\";s:9:\"Puslapiai\";}','pages','1.1',NULL,'a:17:{s:2:\"sl\";s:44:\"Dodaj stran s kakršno koli vsebino želite.\";s:2:\"en\";s:55:\"Add custom pages to the site with any content you want.\";s:2:\"nl\";s:70:\"Voeg aangepaste pagina&apos;s met willekeurige inhoud aan de site toe.\";s:2:\"pl\";s:53:\"Dodaj własne strony z dowolną treścią do witryny.\";s:2:\"es\";s:77:\"Agrega páginas customizadas al sitio con cualquier contenido que tu quieras.\";s:2:\"fr\";s:89:\"Permet d\'ajouter sur le site des pages personalisées avec le contenu que vous souhaitez.\";s:2:\"de\";s:49:\"Füge eigene Seiten mit anpassbaren Inhalt hinzu.\";s:2:\"pt\";s:82:\"Adicionar páginas personalizadas ao site com qualquer conteúdo que você queira.\";s:2:\"zh\";s:39:\"為您的網站新增自定的頁面。\";s:2:\"it\";s:73:\"Aggiungi pagine personalizzate al sito con qualsiesi contenuto tu voglia.\";s:2:\"ru\";s:134:\"Управление информационными страницами сайта, с произвольным содержимым.\";s:2:\"ar\";s:99:\"إضافة صفحات مُخصّصة إلى الموقع تحتوي أية مُحتوى تريده.\";s:2:\"cs\";s:74:\"Přidávejte vlastní stránky na web s jakýmkoliv obsahem budete chtít.\";s:2:\"fi\";s:47:\"Lisää mitä tahansa sisältöä sivustollesi.\";s:2:\"el\";s:134:\"Προσθέστε δικές σας σελίδες στον ιστότοπό σας με ό,τι περιεχόμενο θέλετε.\";s:2:\"he\";s:35:\"ניהול דפי תוכן האתר\";s:2:\"lt\";s:46:\"Pridėkite nuosavus puslapius betkokio turinio\";}',1,1,1,'content',1,1,1),
	(9,'a:17:{s:2:\"sl\";s:10:\"Dovoljenja\";s:2:\"en\";s:11:\"Permissions\";s:2:\"nl\";s:15:\"Toegangsrechten\";s:2:\"es\";s:8:\"Permisos\";s:2:\"fr\";s:11:\"Permissions\";s:2:\"de\";s:14:\"Zugriffsrechte\";s:2:\"pl\";s:11:\"Uprawnienia\";s:2:\"pt\";s:11:\"Permissões\";s:2:\"zh\";s:6:\"權限\";s:2:\"it\";s:8:\"Permessi\";s:2:\"ru\";s:25:\"Права доступа\";s:2:\"ar\";s:18:\"الصلاحيات\";s:2:\"cs\";s:12:\"Oprávnění\";s:2:\"fi\";s:16:\"Käyttöoikeudet\";s:2:\"el\";s:20:\"Δικαιώματα\";s:2:\"he\";s:12:\"הרשאות\";s:2:\"lt\";s:7:\"Teisės\";}','permissions','0.5',NULL,'a:17:{s:2:\"sl\";s:85:\"Uredite dovoljenja kateri tip uporabnika lahko vidi določena področja vaše strani.\";s:2:\"en\";s:68:\"Control what type of users can see certain sections within the site.\";s:2:\"nl\";s:71:\"Bepaal welke typen gebruikers toegang hebben tot gedeeltes van de site.\";s:2:\"pl\";s:79:\"Ustaw, którzy użytkownicy mogą mieć dostęp do odpowiednich sekcji witryny.\";s:2:\"es\";s:81:\"Controla que tipo de usuarios pueden ver secciones específicas dentro del sitio.\";s:2:\"fr\";s:104:\"Permet de définir les autorisations des groupes d\'utilisateurs pour afficher les différentes sections.\";s:2:\"de\";s:70:\"Regelt welche Art von Benutzer welche Sektion in der Seite sehen kann.\";s:2:\"pt\";s:68:\"Controle quais tipos de usuários podem ver certas seções no site.\";s:2:\"zh\";s:81:\"用來控制不同類別的用戶，設定其瀏覽特定網站內容的權限。\";s:2:\"it\";s:78:\"Controlla che tipo di utenti posssono accedere a determinate sezioni del sito.\";s:2:\"ru\";s:209:\"Управление правами доступа, ограничение доступа определённых групп пользователей к произвольным разделам сайта.\";s:2:\"ar\";s:127:\"التحكم بإعطاء الصلاحيات للمستخدمين للوصول إلى أقسام الموقع المختلفة.\";s:2:\"cs\";s:93:\"Spravujte oprávnění pro jednotlivé typy uživatelů a ke kterým sekcím mají přístup.\";s:2:\"fi\";s:72:\"Hallitse minkä tyyppisiin osioihin käyttäjät pääsevät sivustolla.\";s:2:\"el\";s:142:\"Ελέγξτε οι χρήστες ποιας ομάδας μπορούν να δούν ποιες περιοχές του ιστοτόπου.\";s:2:\"he\";s:75:\"ניהול הרשאות כניסה לאיזורים מסוימים באתר\";s:2:\"lt\";s:72:\"Kontroliuokite kokio tipo varotojai kokią dalį puslapio gali pasiekti.\";}',0,0,1,'users',1,1,1),
	(10,'a:14:{s:2:\"sl\";s:12:\"Preusmeritve\";s:2:\"nl\";s:12:\"Verwijzingen\";s:2:\"en\";s:9:\"Redirects\";s:2:\"es\";s:13:\"Redirecciones\";s:2:\"fr\";s:12:\"Redirections\";s:2:\"it\";s:11:\"Reindirizzi\";s:2:\"ru\";s:30:\"Перенаправления\";s:2:\"ar\";s:18:\"التوجيهات\";s:2:\"pt\";s:17:\"Redirecionamentos\";s:2:\"cs\";s:16:\"Přesměrování\";s:2:\"fi\";s:18:\"Uudelleenohjaukset\";s:2:\"el\";s:30:\"Ανακατευθύνσεις\";s:2:\"he\";s:12:\"הפניות\";s:2:\"lt\";s:14:\"Peradresavimai\";}','redirects','1.0',NULL,'a:14:{s:2:\"sl\";s:44:\"Preusmeritev iz enega URL naslova na drugega\";s:2:\"nl\";s:38:\"Verwijs vanaf een URL naar een andere.\";s:2:\"en\";s:33:\"Redirect from one URL to another.\";s:2:\"es\";s:34:\"Redireccionar desde una URL a otra\";s:2:\"fr\";s:34:\"Redirection d\'une URL à un autre.\";s:2:\"it\";s:35:\"Reindirizza da una URL ad un altra.\";s:2:\"ru\";s:78:\"Перенаправления с одного адреса на другой.\";s:2:\"ar\";s:47:\"التوجيه من رابط URL إلى آخر.\";s:2:\"pt\";s:39:\"Redirecionamento de uma URL para outra.\";s:2:\"cs\";s:43:\"Přesměrujte z jedné adresy URL na jinou.\";s:2:\"fi\";s:45:\"Uudelleenohjaa käyttäjän paikasta toiseen.\";s:2:\"el\";s:81:\"Ανακατευθείνετε μια διεύθυνση URL σε μια άλλη\";s:2:\"he\";s:43:\"הפניות מכתובת אחת לאחרת\";s:2:\"lt\";s:56:\"Peradresuokite puslapį iš vieno adreso (URL) į kitą.\";}',0,0,1,'utilities',1,1,1),
	(11,'a:17:{s:2:\"sl\";s:10:\"Nastavitve\";s:2:\"en\";s:8:\"Settings\";s:2:\"nl\";s:12:\"Instellingen\";s:2:\"es\";s:15:\"Configuraciones\";s:2:\"fr\";s:11:\"Paramètres\";s:2:\"de\";s:13:\"Einstellungen\";s:2:\"pl\";s:10:\"Ustawienia\";s:2:\"pt\";s:15:\"Configurações\";s:2:\"zh\";s:12:\"網站設定\";s:2:\"it\";s:12:\"Impostazioni\";s:2:\"ru\";s:18:\"Настройки\";s:2:\"cs\";s:10:\"Nastavení\";s:2:\"ar\";s:18:\"الإعدادات\";s:2:\"fi\";s:9:\"Asetukset\";s:2:\"el\";s:18:\"Ρυθμίσεις\";s:2:\"he\";s:12:\"הגדרות\";s:2:\"lt\";s:10:\"Nustatymai\";}','settings','0.6',NULL,'a:17:{s:2:\"sl\";s:98:\"Dovoljuje administratorjem posodobitev nastavitev kot je Ime strani, sporočil, email naslova itd.\";s:2:\"en\";s:89:\"Allows administrators to update settings like Site Name, messages and email address, etc.\";s:2:\"nl\";s:114:\"Maakt het administratoren en medewerkers mogelijk om websiteinstellingen zoals naam en beschrijving te veranderen.\";s:2:\"es\";s:131:\"Permite a los administradores y al personal configurar los detalles del sitio como el nombre del sitio y la descripción del mismo.\";s:2:\"fr\";s:105:\"Permet aux admistrateurs et au personnel de modifier les paramètres du site : nom du site et description\";s:2:\"de\";s:92:\"Erlaubt es Administratoren die Einstellungen der Seite wie Name und Beschreibung zu ändern.\";s:2:\"pl\";s:103:\"Umożliwia administratorom zmianę ustawień strony jak nazwa strony, opis, e-mail administratora, itd.\";s:2:\"pt\";s:120:\"Permite com que administradores e a equipe consigam trocar as configurações do website incluindo o nome e descrição.\";s:2:\"zh\";s:99:\"網站管理者可更新的重要網站設定。例如：網站名稱、訊息、電子郵件等。\";s:2:\"it\";s:109:\"Permette agli amministratori di aggiornare impostazioni quali Nome del Sito, messaggi e indirizzo email, etc.\";s:2:\"ru\";s:135:\"Управление настройками сайта - Имя сайта, сообщения, почтовые адреса и т.п.\";s:2:\"cs\";s:102:\"Umožňuje administrátorům měnit nastavení webu jako jeho jméno, zprávy a emailovou adresu apod.\";s:2:\"ar\";s:161:\"تمكن المدراء من تحديث الإعدادات كإسم الموقع، والرسائل وعناوين البريد الإلكتروني، .. إلخ.\";s:2:\"fi\";s:105:\"Mahdollistaa sivuston asetusten muokkaamisen, kuten sivuston nimen, viestit ja sähköpostiosoitteet yms.\";s:2:\"el\";s:230:\"Επιτρέπει στους διαχειριστές να τροποποιήσουν ρυθμίσεις όπως το Όνομα του Ιστοτόπου, τα μηνύματα και τις διευθύνσεις email, κ.α.\";s:2:\"he\";s:116:\"ניהול הגדרות שונות של האתר כגון: שם האתר, הודעות, כתובות דואר וכו\";s:2:\"lt\";s:104:\"Leidžia administratoriams keisti puslapio vavadinimą, žinutes, administratoriaus el. pašta ir kitą.\";}',0,0,1,'0',1,1,1),
	(12,'a:9:{s:2:\"sl\";s:14:\"Email predloge\";s:2:\"en\";s:15:\"Email Templates\";s:2:\"es\";s:19:\"Plantillas de email\";s:2:\"ar\";s:48:\"قوالب الرسائل الإلكترونية\";s:2:\"pt\";s:17:\"Modelos de e-mail\";s:2:\"el\";s:22:\"Δυναμικά email\";s:2:\"he\";s:12:\"תבניות\";s:2:\"lt\";s:22:\"El. laiškų šablonai\";s:2:\"ru\";s:25:\"Шаблоны почты\";}','templates','0.1',NULL,'a:9:{s:2:\"sl\";s:52:\"Ustvari, uredi in shrani spremenljive email predloge\";s:2:\"en\";s:46:\"Create, edit, and save dynamic email templates\";s:2:\"es\";s:54:\"Crear, editar y guardar plantillas de email dinámicas\";s:2:\"ar\";s:97:\"أنشئ، عدّل واحفظ قوالب البريد الإلكترني الديناميكية.\";s:2:\"pt\";s:51:\"Criar, editar e salvar modelos de e-mail dinâmicos\";s:2:\"el\";s:108:\"Δημιουργήστε, επεξεργαστείτε και αποθηκεύστε δυναμικά email.\";s:2:\"he\";s:54:\"ניהול של תבניות דואר אלקטרוני\";s:2:\"lt\";s:58:\"Kurk, tvarkyk ir saugok dinaminius el. laiškų šablonus.\";s:2:\"ru\";s:127:\"Создавайте, редактируйте и сохраняйте динамические почтовые шаблоны\";}',0,0,1,'design',1,1,1),
	(13,'a:17:{s:2:\"sl\";s:8:\"Predloge\";s:2:\"en\";s:6:\"Themes\";s:2:\"nl\";s:12:\"Thema&apos;s\";s:2:\"es\";s:5:\"Temas\";s:2:\"fr\";s:7:\"Thèmes\";s:2:\"de\";s:6:\"Themen\";s:2:\"pl\";s:6:\"Motywy\";s:2:\"pt\";s:5:\"Temas\";s:2:\"zh\";s:12:\"佈景主題\";s:2:\"it\";s:4:\"Temi\";s:2:\"ru\";s:8:\"Темы\";s:2:\"ar\";s:14:\"السّمات\";s:2:\"cs\";s:14:\"Motivy vzhledu\";s:2:\"fi\";s:6:\"Teemat\";s:2:\"el\";s:31:\"Θέματα Εμφάνισης\";s:2:\"he\";s:23:\"ערכות נושאים\";s:2:\"lt\";s:5:\"Temos\";}','themes','0.5',NULL,'a:17:{s:2:\"sl\";s:133:\"Dovoljuje adminom in osebju spremembo izgleda spletne strani, namestitev novega izgleda in urejanja le tega v bolj vizualnem pristopu\";s:2:\"en\";s:109:\"Allows admins and staff to change website theme, upload new themes and manage them in a more visual approach.\";s:2:\"nl\";s:153:\"Maakt het voor administratoren en medewerkers mogelijk om het thema van de website te wijzigen, nieuwe thema&apos;s te uploaden en ze visueel te beheren.\";s:2:\"es\";s:132:\"Permite a los administradores y miembros del personal cambiar el tema del sitio web, subir nuevos temas y manejar los ya existentes.\";s:2:\"fr\";s:144:\"Permet aux administrateurs et au personnel de modifier le thème du site, de charger de nouveaux thèmes et de le gérer de façon plus visuelle\";s:2:\"de\";s:121:\"Ermöglicht es dem Administrator das Seiten Thema auszuwählen, neue Themen hochzulanden oder diese visuell zu verwalten.\";s:2:\"pl\";s:100:\"Umożliwia administratorowi zmianę motywu strony, wgrywanie nowych motywów oraz zarządzanie nimi.\";s:2:\"pt\";s:125:\"Permite aos administradores e membros da equipe fazer upload de novos temas e gerenciá-los através de uma interface visual.\";s:2:\"zh\";s:108:\"讓管理者可以更改網站顯示風貌，以視覺化的操作上傳並管理這些網站佈景主題。\";s:2:\"it\";s:120:\"Permette ad amministratori e staff di cambiare il tema del sito, carica nuovi temi e gestiscili in um modo più visuale.\";s:2:\"ru\";s:102:\"Управление темами оформления сайта, загрузка новых тем.\";s:2:\"ar\";s:170:\"تمكّن الإدارة وأعضاء الموقع تغيير سِمة الموقع، وتحميل سمات جديدة وإدارتها بطريقة مرئية سلسة.\";s:2:\"cs\";s:106:\"Umožňuje administrátorům a dalším osobám měnit vzhled webu, nahrávat nové motivy a spravovat je.\";s:2:\"fi\";s:129:\"Mahdollistaa sivuston teeman vaihtamisen, uusien teemojen lataamisen ja niiden hallinnoinnin visuaalisella käyttöliittymällä.\";s:2:\"el\";s:222:\"Επιτρέπει στους διαχειριστές να αλλάξουν το θέμα προβολής του ιστοτόπου να ανεβάσουν νέα θέματα και να τα διαχειριστούν.\";s:2:\"he\";s:63:\"ניהול של ערכות נושאים שונות - עיצוב\";s:2:\"lt\";s:105:\"Leidžiama administratoriams ir personalui keisti puslapio temą, įkraunant naują temą ir valdyti ją.\";}',0,0,1,'design',1,1,1),
	(14,'a:17:{s:2:\"sl\";s:13:\"Spremenljivke\";s:2:\"en\";s:9:\"Variables\";s:2:\"nl\";s:10:\"Variabelen\";s:2:\"pl\";s:7:\"Zmienne\";s:2:\"es\";s:9:\"Variables\";s:2:\"fr\";s:9:\"Variables\";s:2:\"de\";s:9:\"Variablen\";s:2:\"pt\";s:10:\"Variáveis\";s:2:\"zh\";s:12:\"系統變數\";s:2:\"it\";s:9:\"Variabili\";s:2:\"ru\";s:20:\"Переменные\";s:2:\"ar\";s:20:\"المتغيّرات\";s:2:\"cs\";s:10:\"Proměnné\";s:2:\"fi\";s:9:\"Muuttujat\";s:2:\"el\";s:20:\"Μεταβλητές\";s:2:\"he\";s:12:\"משתנים\";s:2:\"lt\";s:10:\"Kintamieji\";}','variables','0.3.1',NULL,'a:17:{s:2:\"sl\";s:53:\"Urejanje globalnih spremenljivk za dostop od kjerkoli\";s:2:\"en\";s:50:\"Manage global variables to access from everywhere.\";s:2:\"nl\";s:54:\"Beheer globale variabelen die overal beschikbaar zijn.\";s:2:\"pl\";s:86:\"Zarządzaj globalnymi zmiennymi do których masz dostęp z każdego miejsca aplikacji.\";s:2:\"es\";s:50:\"Manage global variables to access from everywhere.\";s:2:\"fr\";s:50:\"Manage global variables to access from everywhere.\";s:2:\"de\";s:74:\"Verwaltet globale Variablen, auf die von überall zugegriffen werden kann.\";s:2:\"pt\";s:61:\"Gerencia as variáveis globais acessíveis de qualquer lugar.\";s:2:\"zh\";s:45:\"管理此網站內可存取的全局變數。\";s:2:\"it\";s:58:\"Gestisci le variabili globali per accedervi da ogni parte.\";s:2:\"ru\";s:136:\"Управление глобальными переменными, которые доступны в любом месте сайта.\";s:2:\"ar\";s:97:\"إدارة المُتغيّرات العامة لاستخدامها في أرجاء الموقع.\";s:2:\"cs\";s:56:\"Spravujte globální proměnné přístupné odkudkoliv.\";s:2:\"fi\";s:66:\"Hallitse globaali muuttujia, joihin pääsee käsiksi mistä vain.\";s:2:\"el\";s:129:\"Διαχείριση μεταβλητών που είναι προσβάσιμες από παντού στον ιστότοπο.\";s:2:\"he\";s:96:\"ניהול משתנים גלובליים אשר ניתנים להמרה בכל חלקי האתר\";s:2:\"lt\";s:64:\"Globalių kintamujų tvarkymas kurie yra pasiekiami iš bet kur.\";}',0,0,1,'content',1,1,1),
	(15,'a:14:{s:2:\"sl\";s:9:\"Vtičniki\";s:2:\"en\";s:7:\"Widgets\";s:2:\"es\";s:7:\"Widgets\";s:2:\"pt\";s:7:\"Widgets\";s:2:\"de\";s:7:\"Widgets\";s:2:\"nl\";s:7:\"Widgets\";s:2:\"fr\";s:7:\"Widgets\";s:2:\"zh\";s:9:\"小組件\";s:2:\"it\";s:7:\"Widgets\";s:2:\"ru\";s:14:\"Виджеты\";s:2:\"ar\";s:12:\"الودجت\";s:2:\"cs\";s:7:\"Widgety\";s:2:\"fi\";s:8:\"Widgetit\";s:2:\"lt\";s:11:\"Papildiniai\";}','widgets','1.0',NULL,'a:15:{s:2:\"sl\";s:61:\"Urejanje manjših delov blokov strani ti. Vtičniki (Widgets)\";s:2:\"en\";s:69:\"Manage small sections of self-contained logic in blocks or \"Widgets\".\";s:2:\"es\";s:75:\"Manejar pequeñas secciones de lógica autocontenida en bloques o \"Widgets\"\";s:2:\"pt\";s:77:\"Gerenciar pequenas seções de conteúdos em bloco conhecidos como \"Widgets\".\";s:2:\"de\";s:62:\"Verwaltet kleine, eigentständige Bereiche, genannt \"Widgets\".\";s:2:\"nl\";s:75:\"Beheer kleine onderdelen die zelfstandige logica bevatten, ofwel \"Widgets\".\";s:2:\"fr\";s:41:\"Gérer des mini application ou \"Widgets\".\";s:2:\"zh\";s:103:\"可將小段的程式碼透過小組件來管理。即所謂 \"Widgets\"，或稱為小工具、部件。\";s:2:\"it\";s:70:\"Gestisci piccole sezioni di logica a se stante in blocchi o \"Widgets\".\";s:2:\"ru\";s:91:\"Управление небольшими, самостоятельными блоками.\";s:2:\"ar\";s:138:\"إدارة أقسام صغيرة من البرمجيات في مساحات الموقع أو ما يُسمّى بالـ\"وِدْجِتْ\".\";s:2:\"cs\";s:56:\"Spravujte malé funkční části webu neboli \"Widgety\".\";s:2:\"fi\";s:83:\"Hallitse pieniä osioita, jotka sisältävät erillisiä lohkoja tai \"Widgettejä\".\";s:2:\"el\";s:149:\"Διαχείριση μικρών τμημάτων αυτόνομης προγραμματιστικής λογικής σε πεδία ή \"Widgets\".\";s:2:\"lt\";s:43:\"Nedidelių, savarankiškų blokų valdymas.\";}',0,0,1,'content',1,1,1),
	(16,'a:14:{s:2:\"sl\";s:8:\"Galerija\";s:2:\"en\";s:9:\"Galleries\";s:2:\"de\";s:8:\"Galerien\";s:2:\"nl\";s:10:\"Gallerijen\";s:2:\"fr\";s:8:\"Galeries\";s:2:\"zh\";s:6:\"畫廊\";s:2:\"it\";s:8:\"Gallerie\";s:2:\"ru\";s:14:\"Галереи\";s:2:\"ar\";s:23:\"معارض الصّور\";s:2:\"pt\";s:8:\"Galerias\";s:2:\"cs\";s:7:\"Galerie\";s:2:\"es\";s:9:\"Galerías\";s:2:\"fi\";s:9:\"Galleriat\";s:2:\"lt\";s:9:\"Galerijos\";}','galleries','1.1',NULL,'a:14:{s:2:\"sl\";s:83:\"Modul galerije je mogočen modul ki dovoljuje uporabnikom ustavrjanje galerije slik\";s:2:\"en\";s:81:\"The galleries module is a powerful module that lets users create image galleries.\";s:2:\"de\";s:55:\"Mit dem Galerie Modul kannst du Bildergalerien anlegen.\";s:2:\"nl\";s:96:\"De gallerij module is een krachtige module dat gebruikers in staat stelt gallerijen te plaatsen.\";s:2:\"fr\";s:79:\"Galerie est une puissante extension permettant de créer des galeries d\'images.\";s:2:\"zh\";s:84:\"這是一個功能完整的模組，可以讓用戶建立自己的相簿或畫廊。\";s:2:\"it\";s:96:\"Il modulo gallerie è un potente modulo che permette agli utenti di creare gallerie di immagini.\";s:2:\"ru\";s:175:\"Галереи - мощный модуль, который даёт пользователям возможность создавать галереи изображений.\";s:2:\"ar\";s:88:\"هذه الوحدة تمُكّنك من إنشاء معارض الصّور بسهولة.\";s:2:\"pt\";s:97:\"O módulo de galerias é um poderoso módulo que permite aos usuários criar galerias de imagens.\";s:2:\"cs\";s:59:\"Silný modul pro vytváření a správu galerií obrázků.\";s:2:\"es\";s:88:\"Galerías es un potente módulo que permite a los usuarios crear galerías de imágenes.\";s:2:\"fi\";s:59:\"Galleria moduuli antaa käyttäjien luoda kuva gallerioita.\";s:2:\"lt\";s:65:\"Galerijos modulis leidžia vartotojams kurti nuotraukų galerijas\";}',0,1,1,'content',1,1,0),
	(17,'a:17:{s:2:\"sl\";s:10:\"Uporabniki\";s:2:\"en\";s:5:\"Users\";s:2:\"nl\";s:10:\"Gebruikers\";s:2:\"pl\";s:12:\"Użytkownicy\";s:2:\"es\";s:8:\"Usuarios\";s:2:\"fr\";s:12:\"Utilisateurs\";s:2:\"de\";s:8:\"Benutzer\";s:2:\"pt\";s:9:\"Usuários\";s:2:\"zh\";s:6:\"用戶\";s:2:\"it\";s:6:\"Utenti\";s:2:\"ru\";s:24:\"Пользователи\";s:2:\"ar\";s:20:\"المستخدمون\";s:2:\"cs\";s:11:\"Uživatelé\";s:2:\"fi\";s:12:\"Käyttäjät\";s:2:\"el\";s:14:\"Χρήστες\";s:2:\"he\";s:14:\"משתמשים\";s:2:\"lt\";s:10:\"Vartotojai\";}','users','0.8',NULL,'a:17:{s:2:\"sl\";s:96:\"Dovoli uporabnikom za registracijo in prijavo na strani, urejanje le teh preko nadzorne plošče\";s:2:\"en\";s:81:\"Let users register and log in to the site, and manage them via the control panel.\";s:2:\"nl\";s:88:\"Laat gebruikers registreren en inloggen op de site, en beheer ze via het controlepaneel.\";s:2:\"pl\";s:87:\"Pozwól użytkownikom na logowanie się na stronie i zarządzaj nimi za pomocą panelu.\";s:2:\"es\";s:138:\"Permite el registro de nuevos usuarios quienes podrán loguearse en el sitio. Estos podrán controlarse desde el panel de administración.\";s:2:\"fr\";s:112:\"Permet aux utilisateurs de s\'enregistrer et de se connecter au site et de les gérer via le panneau de contrôle\";s:2:\"de\";s:108:\"Erlaube Benutzern das Registrieren und Einloggen auf der Seite und verwalte sie über die Admin-Oberfläche.\";s:2:\"pt\";s:125:\"Permite com que usuários se registrem e entrem no site e também que eles sejam gerenciáveis apartir do painel de controle.\";s:2:\"zh\";s:87:\"讓用戶可以註冊並登入網站，並且管理者可在控制台內進行管理。\";s:2:\"it\";s:95:\"Fai iscrivere de entrare nel sito gli utenti, e gestiscili attraverso il pannello di controllo.\";s:2:\"ru\";s:155:\"Управление зарегистрированными пользователями, активирование новых пользователей.\";s:2:\"ar\";s:133:\"تمكين المستخدمين من التسجيل والدخول إلى الموقع، وإدارتهم من لوحة التحكم.\";s:2:\"cs\";s:103:\"Umožňuje uživatelům se registrovat a přihlašovat a zároveň jejich správu v Kontrolním panelu.\";s:2:\"fi\";s:126:\"Antaa käyttäjien rekisteröityä ja kirjautua sisään sivustolle sekä mahdollistaa niiden muokkaamisen hallintapaneelista.\";s:2:\"el\";s:299:\"Παρέχει την δυνατότητα εγγραφής λογαριασμών χρηστών και σύνδεσης τους στους επισκέπτες του ιστοτόπου. Με αυτό το πρόσθετο μπορείτε επίσης να τους διαχειριστείτε.\";s:2:\"he\";s:62:\"ניהול משתמשים: רישום, הפעלה ומחיקה\";s:2:\"lt\";s:106:\"Leidžia vartotojams registruotis ir prisijungti prie puslapio, ir valdyti juos per administravimo panele.\";}',0,0,1,'0',1,1,1);

/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table navigation_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `navigation_groups`;

CREATE TABLE `navigation_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `abbrev` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Navigation groupings. Eg, header, sidebar, footer, etc';

LOCK TABLES `navigation_groups` WRITE;
/*!40000 ALTER TABLE `navigation_groups` DISABLE KEYS */;
INSERT INTO `navigation_groups` (`id`,`title`,`abbrev`)
VALUES
	(1,'Header','header'),
	(2,'Sidebar','sidebar'),
	(3,'Footer','footer');

/*!40000 ALTER TABLE `navigation_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table navigation_links
# ------------------------------------------------------------

DROP TABLE IF EXISTS `navigation_links`;

CREATE TABLE `navigation_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `parent` int(11) NOT NULL DEFAULT '0',
  `link_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'uri',
  `page_id` int(11) NOT NULL DEFAULT '0',
  `module_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `uri` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `navigation_group_id` int(5) NOT NULL DEFAULT '0',
  `position` int(5) NOT NULL DEFAULT '0',
  `target` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `navigation_group_id - normal` (`navigation_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Links for site navigation';

LOCK TABLES `navigation_links` WRITE;
/*!40000 ALTER TABLE `navigation_links` DISABLE KEYS */;
INSERT INTO `navigation_links` (`id`,`title`,`parent`,`link_type`,`page_id`,`module_name`,`url`,`uri`,`navigation_group_id`,`position`,`target`,`class`)
VALUES
	(1,'Home',0,'page',1,'','','',1,0,NULL,''),
	(2,'Contacto',0,'page',3,'','','',1,3,'',''),
	(3,'Nosotros',0,'page',4,'','','',1,2,'',''),
	(4,'Productos',0,'uri',0,'','','divisiones',1,1,'','');

/*!40000 ALTER TABLE `navigation_links` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table page_layouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `page_layouts`;

CREATE TABLE `page_layouts` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `css` text COLLATE utf8_unicode_ci,
  `js` text COLLATE utf8_unicode_ci,
  `theme_layout` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'default',
  `updated_on` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Store shared page layouts & CSS';

LOCK TABLES `page_layouts` WRITE;
/*!40000 ALTER TABLE `page_layouts` DISABLE KEYS */;
INSERT INTO `page_layouts` (`id`,`title`,`body`,`css`,`js`,`theme_layout`,`updated_on`)
VALUES
	(1,'Default','<h2>{pyro:page:title}</h2>\n\n\n{pyro:page:body}','','','default',1305099999);

/*!40000 ALTER TABLE `page_layouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pages`;

CREATE TABLE `pages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `uri` text COLLATE utf8_unicode_ci,
  `parent_id` int(11) DEFAULT '0',
  `revision_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `layout_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `css` text COLLATE utf8_unicode_ci,
  `js` text COLLATE utf8_unicode_ci,
  `meta_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `meta_keywords` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `meta_description` text COLLATE utf8_unicode_ci,
  `rss_enabled` int(1) NOT NULL DEFAULT '0',
  `comments_enabled` int(1) NOT NULL DEFAULT '0',
  `status` enum('draft','live') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'draft',
  `created_on` int(11) NOT NULL DEFAULT '0',
  `updated_on` int(11) NOT NULL DEFAULT '0',
  `restricted_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_home` tinyint(1) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Unique` (`slug`,`parent_id`),
  KEY `slug` (`slug`),
  KEY `parent` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='User Editable Pages';

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` (`id`,`slug`,`title`,`uri`,`parent_id`,`revision_id`,`layout_id`,`css`,`js`,`meta_title`,`meta_keywords`,`meta_description`,`rss_enabled`,`comments_enabled`,`status`,`created_on`,`updated_on`,`restricted_to`,`is_home`,`order`)
VALUES
	(1,'home','Inicio','home',0,'17','1','','function init() {               \n        // options\n        var o = {\n          enableMouse: false,\n          childSizeFixed:true\n        };\n        // Setup galleries\n        $(\".myJac\").jac(o);  \n      }\n          \n      $(init); // on DOM ready','','','',0,0,'live',1305099999,1305187340,'',1,0),
	(2,'404','Page missing','404',0,'2','1',NULL,NULL,'','',NULL,0,0,'live',1305099999,1305099999,'',0,0),
	(3,'contact','ESTAMOS A SUS ORDENES','contact',0,'14','1','','','','','',0,0,'live',1305099999,1305181130,'',0,0),
	(4,'nosotros','Nosotros','nosotros',0,'5','1','/* CSS Document */\nul.nostabs {\n  margin: 0;\n  padding: 0;\n  float: left;\n  list-style: none;\n  height: 38px; /*--Set height of tabs--*/\n  border: none;\n  width: 100%;\n  top: 0px;\n}\nul.nostabs li {\n  float: left;\n  margin: 0;\n  padding: 0;\n  height: 35px; /*--Subtract 1px from the height of the unordered list--*/\n  line-height: 31px; /*--Vertically aligns the text within the tab--*/\n  border: none;\n  margin-right:3px;\n  margin-bottom: -3px; /*--Pull the list item down 1px--*/\n  overflow: hidden;\n  position: relative;\n  background: #181818;\n}\nul.nostabs li a {\n  text-decoration: none;\n  display: block;\n  font-size: 1.2em;\n  padding: 0 20px;\n  border: none;\n  outline: none;\n  height:100%\n}\nul.nostabs li a:hover {\n  background: #000;\n}\nhtml ul.nostabs li.active, html ul.nostabs li.active a:hover  { /*--Makes sure that the active tab does not listen to the hover properties--*/\n  background: #181818;\n  border-bottom: 3px solid #181818; /*--Makes the active tab look like it\'s connected with its content--*/\n}\n\n.tab_container {\n  border:  none;\n  overflow: hidden;\n  clear: both;\n  float: left; width: 100%;\n  background: #181818;\n}\n.tab_content {\n  padding: 20px;\n  font-size: 1.2em;\n}','$(document).ready(function() {\n          //When page loads...\n          $(\".tab_content\").hide(); //Hide all content\n          $(\"ul.nostabs li:first\").addClass(\"active\").show(); //Activate first tab\n          $(\".tab_content:first\").show(); //Show first tab content\n          //On Click Event\n          $(\"ul.nostabs li\").click(function() {\n            $(\"ul.nostabs li\").removeClass(\"active\"); //Remove any \"active\" class\n            $(this).addClass(\"active\"); //Add \"active\" class to selected tab\n            $(\".tab_content\").hide(); //Hide all tab content\n        \n            var activeTab = $(this).find(\"a\").attr(\"href\"); //Find the href attribute value to identify the active tab + content\n            $(activeTab).fadeIn(); //Fade in the active ID content\n            return false;\n          });\n        });','','','',0,0,'live',1305101112,1305101118,'',0,1305101112);

/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `permissions`;

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `module` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `roles` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Contains a list of modules that a group can access.';



# Dump of table product_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_categories`;

CREATE TABLE `product_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `slug` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `thumbnail_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `headerimg_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `featured` int(1) DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '999',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `slug - normal` (`slug`),
  KEY `title` (`title`),
  KEY `ordering` (`ordering`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Blog Categories.';

LOCK TABLES `product_categories` WRITE;
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
INSERT INTO `product_categories` (`id`,`parent_id`,`slug`,`title`,`thumbnail_path`,`headerimg_path`,`description`,`featured`,`ordering`,`created_on`,`updated_on`)
VALUES
	(6,0,'plantas-de-tratamiento-de-aguas-residuales','Plantas de Tratamiento de Aguas Residuales','ptar.jpg','ptar.jpg','<p><strong>NOTAS IMPORTANTES</strong></p>\n<ul>\n	<li>Lorem ipsum dolor sit amet, consectu</li>\n		<li>Lorem ipsum dolor sit amet, consectu</li>\n		<li>Lorem ipsum dolor sit amet, consectu</li>\n		<li>Lorem ipsum dolor sit amet, consectu</li>\n		<li>Lorem ipsum dolor sit amet, consectu</li>\n	</ul>',1,1,'0000-00-00 00:00:00','2011-05-12 21:53:03'),
	(7,0,'plantas-potabilizadoras','Plantas potabilizadoras','plantas-potabilizadoras.jpg','plantas-potabilizadoras.jpg',NULL,1,2,'0000-00-00 00:00:00','2011-05-12 02:09:27'),
	(8,0,'otros-equipos','Otros Equipos','otros.jpg','otros.jpg',NULL,1,3,'0000-00-00 00:00:00','2011-05-12 02:18:42'),
	(9,0,'servicios','Servicios','servicios.jpg','servicios.jpg',NULL,1,4,'0000-00-00 00:00:00','2011-05-12 21:35:38'),
	(10,6,'subcategoria','Subcategoria','servicios.jpg','servicios.jpg',NULL,1,1,'0000-00-00 00:00:00','2011-05-12 21:35:38');

/*!40000 ALTER TABLE `product_categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_images
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_images`;

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `mimetype` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `width` int(5) DEFAULT NULL,
  `height` int(5) DEFAULT NULL,
  `filesize` int(11) NOT NULL DEFAULT '0',
  `date_added` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` (`id`,`product_id`,`name`,`filename`,`description`,`extension`,`mimetype`,`width`,`height`,`filesize`,`date_added`)
VALUES
	(22,11,NULL,'ptar-paquete-1.jpg','','.jpg','image/jpeg',970,622,74,0),
	(23,11,'Vista seccionada','ptar-paquete-2.jpg','','.jpg','image/jpeg',975,602,66,0),
	(24,12,NULL,'hospitales-universidades.jpg',NULL,'.jpg','image/jpeg',948,633,57,0),
	(25,13,NULL,'hoteles-restaurantes.jpg',NULL,'.jpg','image/jpeg',962,642,98,0);

/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table products
# ------------------------------------------------------------

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_category_id` int(11) DEFAULT '0',
  `slug` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `thumbnail_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `body` text COLLATE utf8_unicode_ci,
  `ordering` int(11) NOT NULL DEFAULT '999',
  `status` enum('draft','live') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'live',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`product_category_id`),
  KEY `slug - normal` (`slug`),
  KEY `title` (`title`),
  KEY `ordering` (`ordering`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Blog Categories.';

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`,`product_category_id`,`slug`,`title`,`thumbnail_path`,`description`,`body`,`ordering`,`status`,`created_on`,`updated_on`)
VALUES
	(11,6,'ptar-tipo-paquete','Tipo paquete','ptar-paquete.jpg','(portátiles para pequeñas aplicaciones desde una hasta\r400 casas en un solo paquete o desde 1000 litros al día hasta 5 litros por segundo en un solo paquete)','<p>El diseño conceptual del tren de tratamiento de la planta de tratamiento de aguas residuales comprende un sistema de tratamiento de biodegradación por lodos activados en su modalidad de lodos activados en régimen de aireación extendida y nitrificación y denitrificación en una misma etapa. Los procesos unitarios que lo comprenden son: Rejilla de sólidos, sedimentador primario y trampa de grasas, Reactor aerobio, Clarificador, Desinfección, Filtración (opcional).</p>',1,'live','0000-00-00 00:00:00','2011-05-13 01:17:56'),
	(12,6,'ptar-hospitales-universidades','Instituciones como hospitales, universidades, bases militares, corporativos','hospitales-universidades.jpg',NULL,NULL,2,'live','0000-00-00 00:00:00','2011-05-13 01:18:00'),
	(13,6,'ptar-hoteles-restaurantes','Para hoteles y restaurantes','hoteles-restaurantes.jpg',NULL,NULL,3,'live','0000-00-00 00:00:00','2011-05-13 01:18:04');

/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table profiles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `profiles`;

CREATE TABLE `profiles` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `display_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `company` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en',
  `bio` text COLLATE utf8_unicode_ci,
  `dob` int(11) DEFAULT NULL,
  `gender` set('m','f','') COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_line1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_line2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_line3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `msn_handle` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `yim_handle` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `aim_handle` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gtalk_handle` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gravatar` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter_access_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter_access_token_secret` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_on` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` (`id`,`user_id`,`display_name`,`first_name`,`last_name`,`company`,`lang`,`bio`,`dob`,`gender`,`phone`,`mobile`,`address_line1`,`address_line2`,`address_line3`,`postcode`,`msn_handle`,`yim_handle`,`aim_handle`,`gtalk_handle`,`gravatar`,`website`,`twitter_access_token`,`twitter_access_token_secret`,`updated_on`)
VALUES
	(1,1,'Pablo Resines','Pablo','Resines','','en',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table redirects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `redirects`;

CREATE TABLE `redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `to` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `request` (`from`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table revisions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `revisions`;

CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  `table_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pages',
  `body` text COLLATE utf8_unicode_ci,
  `revision_date` int(11) NOT NULL,
  `author_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Owner ID` (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
INSERT INTO `revisions` (`id`,`owner_id`,`table_name`,`body`,`revision_date`,`author_id`)
VALUES
	(1,1,'pages','<p>Welcome to our homepage. We have not quite finished setting up our website yet, but please add us to your bookmarks and come back soon.</p>',1305099999,0),
	(2,2,'pages','<p>We cannot find the page you are looking for, please click <a title=\"Home\" href=\"{pyro:pages:url id=\'1\'}\">here</a> to go to the homepage.</p>',1305099999,0),
	(3,3,'pages','<p>To contact us please fill out the form below.</p> {pyro:contact:form}',1305099999,0),
	(4,4,'pages','<div class=\"ez-box\" id=\"fpimage\">\n	{pyro:theme:image file=&quot;nosotrosimage.jpg&quot; }</div>\n<div class=\"ez-box\" id=\"fptitle\">\n	{pyro:theme:image file=&quot;nosotrostitle.png&quot; alt=&quot;NOSOTROS SOMOS SUSTENTABILIS&quot;}</div>\n<div class=\"ez-wr\" id=\"fptext\">\n	<div class=\"ez-box\">\n		<ul class=\"nostabs\">\n			<li>\n				<a href=\"#nuestros_compromisos\">Nuestros Compromisos</a></li>\n			<li>\n				<a href=\"#Mision\">Misi&oacute;n</a></li>\n			<li>\n				<a href=\"#Vision\">Visi&oacute;n</a></li>\n			<li>\n				<a href=\"#Historia\">Historia</a></li>\n		</ul>\n		<div class=\"tab_container\">\n			<div class=\"tab_content\" id=\"nuestros_compromisos\">\n				<p>\n					Nuestra promesa: estar comprometidos con el medio ambiente y nuestro entorno.&nbsp; Buscar que todas nuestras actividades impacten positivamente a nuestros clientes, nuestros empleados, nuestros socios, nuestra comunidad y nuestro planeta.</p>\n				<p>\n					Para NUESTROS CLIENTES: ayudarlos a minimizar o eliminar el impacto que sus procesos puedan causar al medio ambiente, ayud&aacute;ndolos a hacerlos de una manera rentable. (sustentable?)</p>\n				<p>\n					Para NUESTROS EMPLEADOS: ante todo, cuidar su seguridad, buscando contribuir en su desarrollo personal y profesional, ofreci&eacute;ndoles un entorno de trabajo justo, seguro y amigable. Y contagiarlos para que nuestro compromiso sustentable, sea tambi&eacute;n el suyo.</p>\n				<p>\n					Para NUESTROS SOCIOS, maximizar sus utilidades, cumpliendo siempre con los principios de responsabilidad bajo los cuales fue fundada la empresa.</p>\n				<p>\n					Para LA COMUNIDAD, hacer negocios de una manera &eacute;tica, justa y responsable.</p>\n			</div>\n			<div class=\"tab_content\" id=\"Mision\">\n				Hacer del cuidado del medio ambiente un negocio rentable para nuestros clientes y para nosotros.</div>\n			<div class=\"tab_content\" id=\"Vision\">\n				<p>\n					Ser una empresa l&iacute;der en el mercado de ingenier&iacute;a ambiental y conservaci&oacute;n, que genere ingresos a trav&eacute;s de la explotaci&oacute;n sustentable de los recursos naturales y renovables, la prevenci&oacute;n y el control de la contaminaci&oacute;n.</p>\n			</div>\n			<div class=\"tab_content\" id=\"Historia\">\n				<p>\n					Sustentabilis nace en el a&ntilde;o 2001 bajo el nombre de Mir Ambiental con una fundada inquietud en detener y revertir el deterioro ambiental. Esto ayud&oacute; a estructurar las acciones de la empresa, comenzando con un cambio cultural y concluyendo con soluciones tangibles, es decir, soluciones integrales a favor del medio ambiente, como plantas de tratamiento de agua residual, y otros productos y servicios: cosechado de suelos con aguas pluviales, planes de manejo sustentable, estudios de impacto ambiental, techos verdes y energ&iacute;as limpias.</p>\n				<p>\n					Sustentabilis opera con una filosof&iacute;a basada en fundamentos sustentables, buscando un beneficio econ&oacute;mico, social y ambiental, con tecnolog&iacute;as apropiadas y con procesos de mejora continua bajo principios de confiabilidad, calidad y eficiencia.</p>\n			</div>\n		</div>\n	</div>\n</div>',1305101112,1),
	(5,4,'pages','<div class=\"ez-box\" id=\"fpimage\">\n	{pyro:theme:image file=&quot;nosotrosimage.jpg&quot; }</div>\n<div class=\"ez-box\" id=\"fptitle\">\n	{pyro:theme:image file=&quot;nosotrostitle.png&quot; alt=&quot;NOSOTROS SOMOS SUSTENTABILIS&quot;}</div>\n<div class=\"ez-wr\" id=\"fptext\">\n	<div class=\"ez-box\">\n		<ul class=\"nostabs\">\n			<li>\n				<a href=\"#nuestros_compromisos\">Nuestros Compromisos</a></li>\n			<li>\n				<a href=\"#Mision\">Misi&oacute;n</a></li>\n			<li>\n				<a href=\"#Vision\">Visi&oacute;n</a></li>\n			<li>\n				<a href=\"#Historia\">Historia</a></li>\n		</ul>\n		<div class=\"tab_container\">\n			<div class=\"tab_content\" id=\"nuestros_compromisos\">\n				<p>\n					Nuestra promesa: estar comprometidos con el medio ambiente y nuestro entorno.&nbsp; Buscar que todas nuestras actividades impacten positivamente a nuestros clientes, nuestros empleados, nuestros socios, nuestra comunidad y nuestro planeta.</p>\n				<p>\n					Para NUESTROS CLIENTES: ayudarlos a minimizar o eliminar el impacto que sus procesos puedan causar al medio ambiente, ayud&aacute;ndolos a hacerlos de una manera rentable. (sustentable?)</p>\n				<p>\n					Para NUESTROS EMPLEADOS: ante todo, cuidar su seguridad, buscando contribuir en su desarrollo personal y profesional, ofreci&eacute;ndoles un entorno de trabajo justo, seguro y amigable. Y contagiarlos para que nuestro compromiso sustentable, sea tambi&eacute;n el suyo.</p>\n				<p>\n					Para NUESTROS SOCIOS, maximizar sus utilidades, cumpliendo siempre con los principios de responsabilidad bajo los cuales fue fundada la empresa.</p>\n				<p>\n					Para LA COMUNIDAD, hacer negocios de una manera &eacute;tica, justa y responsable.</p>\n			</div>\n			<div class=\"tab_content\" id=\"Mision\">\n				Hacer del cuidado del medio ambiente un negocio rentable para nuestros clientes y para nosotros.</div>\n			<div class=\"tab_content\" id=\"Vision\">\n				<p>\n					Ser una empresa l&iacute;der en el mercado de ingenier&iacute;a ambiental y conservaci&oacute;n, que genere ingresos a trav&eacute;s de la explotaci&oacute;n sustentable de los recursos naturales y renovables, la prevenci&oacute;n y el control de la contaminaci&oacute;n.</p>\n			</div>\n			<div class=\"tab_content\" id=\"Historia\">\n				<p>\n					Sustentabilis nace en el a&ntilde;o 2001 bajo el nombre de Mir Ambiental con una fundada inquietud en detener y revertir el deterioro ambiental. Esto ayud&oacute; a estructurar las acciones de la empresa, comenzando con un cambio cultural y concluyendo con soluciones tangibles, es decir, soluciones integrales a favor del medio ambiente, como plantas de tratamiento de agua residual, y otros productos y servicios: cosechado de suelos con aguas pluviales, planes de manejo sustentable, estudios de impacto ambiental, techos verdes y energ&iacute;as limpias.</p>\n				<p>\n					Sustentabilis opera con una filosof&iacute;a basada en fundamentos sustentables, buscando un beneficio econ&oacute;mico, social y ambiental, con tecnolog&iacute;as apropiadas y con procesos de mejora continua bajo principios de confiabilidad, calidad y eficiencia.</p>\n			</div>\n		</div>\n	</div>\n</div>',1305101118,1),
	(6,1,'pages','<div class=\"ez-box\" id=\"fpimage\">\n	{pyro:theme:image file=&quot;fpimage.jpg&quot; }</div>\n<div class=\"ez-box\" id=\"fptitle\">\n	{pyro:theme:image file=&quot;fptitle.png&quot; alt=&quot;ESTO ES SUSTENTABILIS&quot;}</div>\n<div class=\"ez-wr\" id=\"fptext\">\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				En <span class=\"greentext\">SUSTENTABILIS</span>, el cuidado del medio ambiente es <span class=\"greentext\">nuestra forma de vida</span> y nuestro negocio. Sabemos que por la naturaleza de algunas operaciones, el cuidado del medio ambiente puede ser <span class=\"greentext\">un problema complejo.</span></p>\n		</div>\n	</div>\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				Por eso nos hemos propuesto ser una empresa que <span class=\"greentext\">solucione de manera integral</span> las necesidades ambientales del Pa&iacute;s.</p>\n		</div>\n	</div>\n	<div class=\"ez-last ez-oh\">\n		<div class=\"ez-box\">\n			<p>\n				Nuestra <span class=\"greentext\">misi&oacute;n</span> es hacer del cuidado del <span class=\"greentext\">medio</span> ambiente un negocio rentable para nuestros <span class=\"greentext\">clientes</span> y para <span class=\"greentext\">nosotros</span>.</p>\n		</div>\n	</div>\n</div>\n<div class=\"ez-box\" id=\"divisions\">\n	<div class=\"myJac\">\n		<ul>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divagua.jpg&quot; alt=&quot;Divisi&oacute;n Agua&quot; }</a></li>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divaire.jpg&quot; alt=&quot;Divisi&oacute;n Aire&quot; }</a></li>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divenergia.jpg&quot; }</a></li>\n		</ul>\n	</div>\n</div>',1305101198,1),
	(7,5,'pages','<div class=\"prods_divheader\">\n	<div class=\"prods_headerimg\">\n		{pyro:theme:image file=&quot;hdragua.jpg&quot; }</div>\n	<div class=\"prods_headerside\">\n		<div id=\"titlediv\">\n			{pyro:theme:image file=&quot;titledivagua2.png&quot; }</div>\n		<div id=\"descrdiv\">\n			<p>\n				<strong>NOTAS IMPORTANTES</strong></p>\n			<ul>\n				<li>\n					Lorem ipsum dolor sit amet, consectu</li>\n				<li>\n					Lorem ipsum dolor sit amet, consectu</li>\n				<li>\n					Lorem ipsum dolor sit amet, consectu</li>\n				<li>\n					Lorem ipsum dolor sit amet, consectu</li>\n				<li>\n					Lorem ipsum dolor sit amet, consectu</li>\n			</ul>\n			<p>\n				&nbsp;</p>\n		</div>\n	</div>\n</div>',1305101256,1),
	(8,3,'pages','<p>\n	To contact us please fill out the form below.</p>\n<p>\n	{pyro:contact:form}</p>',1305101477,1),
	(9,3,'pages','<p>\n	To contact us please fill out the form below.</p>\n<p>\n	{pyro:contact:form}</p>',1305101959,1),
	(10,3,'pages','<p>\n	To contact us please fill out the form below.</p>\n<p>\n	{pyro:contact:form}</p>',1305137059,1),
	(11,3,'pages','{pyro:theme:image file=\"title-contact.png\" alt=\"ESTAMOS A SUS ORDENES\" }\n<div>\n    <div id=\"adrres_mx\">\n        <h3 class=\"greentext\">México</h3>\n        <p>\n            <span class=\"greentext\">Dirección</span><br/>\n            Minería 302<br/> \n            Col. Industrial Las Palmas<br/>\n            Santa Catarina, N.L. México\n        </p>\n        <p>\n            <span class=\"greentext\">Teléfono</span><br/>\n            +001 (713) 518-1641\n        </p>\n        <p>\n            <span class=\"greentext\">Email</span><br/>\n            info@sustentabilis.com  \n        </p>\n    </div>\n    <div id=\"adrres_us\">\n        <h3 class=\"greentext\">USA</h3>\n        <p>\n            <span class=\"greentext\">Adress</span><br/>\n            12210 Thoreau Dr.<br/>\n            Montgomery, TX 77356<br/>\n            USA\n        </p>\n        <p>\n            <span class=\"greentext\">Phone</span><br/>\n            +52 (81) 4737-2222 \n        </p>\n        <p>\n            <span class=\"greentext\">Email</span><br/>\n            info@sustentabilis.com  \n        </p>\n    </div>\n    <div id=\"contact_form\">\n    {pyro:contact:form}\n    </div>',1305152139,1),
	(12,1,'pages','<div class=\"ez-box\" id=\"fpimage\">\n	{pyro:theme:image file=&quot;fpimage.jpg&quot; }</div>\n<div class=\"ez-box\" id=\"fptitle\">\n	<h2>Esto es sustentabilis</h2></div>\n<div class=\"ez-wr\" id=\"fptext\">\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				En <span class=\"greentext\">SUSTENTABILIS</span>, el cuidado del medio ambiente es <span class=\"greentext\">nuestra forma de vida</span> y nuestro negocio. Sabemos que por la naturaleza de algunas operaciones, el cuidado del medio ambiente puede ser <span class=\"greentext\">un problema complejo.</span></p>\n		</div>\n	</div>\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				Por eso nos hemos propuesto ser una empresa que <span class=\"greentext\">solucione de manera integral</span> las necesidades ambientales del Pa&iacute;s.</p>\n		</div>\n	</div>\n	<div class=\"ez-last ez-oh\">\n		<div class=\"ez-box\">\n			<p>\n				Nuestra <span class=\"greentext\">misi&oacute;n</span> es hacer del cuidado del <span class=\"greentext\">medio</span> ambiente un negocio rentable para nuestros <span class=\"greentext\">clientes</span> y para <span class=\"greentext\">nosotros</span>.</p>\n		</div>\n	</div>\n</div>\n<div class=\"ez-box\" id=\"divisions\">\n	<div class=\"myJac\">\n		<ul>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divagua.jpg&quot; alt=&quot;Divisi&oacute;n Agua&quot; }</a></li>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divaire.jpg&quot; alt=&quot;Divisi&oacute;n Aire&quot; }</a></li>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divenergia.jpg&quot; }</a></li>\n		</ul>\n	</div>\n</div>',1305180945,1),
	(13,1,'pages','<div class=\"ez-box\" id=\"fpimage\">\n	{pyro:theme:image file=&quot;fpimage.jpg&quot; }</div>\n<div class=\"ez-box\" id=\"fptitle\">\n	<h2>\n		Esto es sustentabilis</h2>\n</div>\n<div class=\"ez-wr\" id=\"fptext\">\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				En <span class=\"greentext\">SUSTENTABILIS</span>, el cuidado del medio ambiente es <span class=\"greentext\">nuestra forma de vida</span> y nuestro negocio. Sabemos que por la naturaleza de algunas operaciones, el cuidado del medio ambiente puede ser <span class=\"greentext\">un problema complejo.</span></p>\n		</div>\n	</div>\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				Por eso nos hemos propuesto ser una empresa que <span class=\"greentext\">solucione de manera integral</span> las necesidades ambientales del Pa&iacute;s.</p>\n		</div>\n	</div>\n	<div class=\"ez-last ez-oh\">\n		<div class=\"ez-box\">\n			<p>\n				Nuestra <span class=\"greentext\">misi&oacute;n</span> es hacer del cuidado del <span class=\"greentext\">medio</span> ambiente un negocio rentable para nuestros <span class=\"greentext\">clientes</span> y para <span class=\"greentext\">nosotros</span>.</p>\n		</div>\n	</div>\n</div>\n<div class=\"ez-box\" id=\"divisions\">\n	<div class=\"myJac\">\n		<ul>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divagua.jpg&quot; alt=&quot;Divisi&oacute;n Agua&quot; }</a></li>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divaire.jpg&quot; alt=&quot;Divisi&oacute;n Aire&quot; }</a></li>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divenergia.jpg&quot; }</a></li>\n		</ul>\n	</div>\n</div>',1305181097,1),
	(14,3,'pages','<p>\n	M&eacute;xico</p>\n<div>\n	<div id=\"adrres_mx\">\n		<p>\n			<span class=\"greentext\">Direcci&oacute;n</span><br />\n			Miner&iacute;a 302<br />\n			Col. Industrial Las Palmas<br />\n			Santa Catarina, N.L. M&eacute;xico</p>\n		<p>\n			<span class=\"greentext\">Tel&eacute;fono</span><br />\n			+001 (713) 518-1641</p>\n		<p>\n			<span class=\"greentext\">Email</span><br />\n			info@sustentabilis.com</p>\n	</div>\n	<div id=\"adrres_us\">\n		<h3 class=\"greentext\">\n			USA</h3>\n		<p>\n			<span class=\"greentext\">Adress</span><br />\n			12210 Thoreau Dr.<br />\n			Montgomery, TX 77356<br />\n			USA</p>\n		<p>\n			<span class=\"greentext\">Phone</span><br />\n			+52 (81) 4737-2222</p>\n		<p>\n			<span class=\"greentext\">Email</span><br />\n			info@sustentabilis.com</p>\n	</div>\n	<div id=\"contact_form\">\n		{pyro:contact:form}</div>\n</div>',1305181130,1),
	(15,1,'pages','<div class=\"ez-box\" id=\"fpimage\">\n	{pyro:theme:image file=&quot;fpimage.jpg&quot; }</div>\n<div class=\"ez-box\" id=\"fptitle\">\n	<h2>\n		Esto es sustentabilis</h2>\n</div>\n<div class=\"ez-wr\" id=\"fptext\">\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				En <span class=\"greentext\">SUSTENTABILIS</span>, el cuidado del medio ambiente es <span class=\"greentext\">nuestra forma de vida</span> y nuestro negocio. Sabemos que por la naturaleza de algunas operaciones, el cuidado del medio ambiente puede ser <span class=\"greentext\">un problema complejo.</span></p>\n		</div>\n	</div>\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				Por eso nos hemos propuesto ser una empresa que <span class=\"greentext\">solucione de manera integral</span> las necesidades ambientales del Pa&iacute;s.</p>\n		</div>\n	</div>\n	<div class=\"ez-last ez-oh\">\n		<div class=\"ez-box\">\n			<p>\n				Nuestra <span class=\"greentext\">misi&oacute;n</span> es hacer del cuidado del <span class=\"greentext\">medio</span> ambiente un negocio rentable para nuestros <span class=\"greentext\">clientes</span> y para <span class=\"greentext\">nosotros</span>.</p>\n		</div>\n	</div>\n</div>\n<div class=\"ez-box\" id=\"divisions\">\n	{pyro:Featuredproducts:links}\n</div>\n<div class=\"ez-box\" id=\"divisions-ant\">\n	<div class=\"myJac\">\n		<ul>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divagua.jpg&quot; alt=&quot;Divisi&oacute;n Agua&quot; }</a></li>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divaire.jpg&quot; alt=&quot;Divisi&oacute;n Aire&quot; }</a></li>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divenergia.jpg&quot; }</a></li>\n		</ul>\n	</div>\n</div>',1305186215,1),
	(16,1,'pages','<div class=\"ez-box\" id=\"fpimage\">\n	{pyro:theme:image file=&quot;fpimage.jpg&quot; }</div>\n<div class=\"ez-box\" id=\"fptitle\">\n	<h2>\n		Esto es sustentabilis</h2>\n</div>\n<div class=\"ez-wr\" id=\"fptext\">\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				En <span class=\"greentext\">SUSTENTABILIS</span>, el cuidado del medio ambiente es <span class=\"greentext\">nuestra forma de vida</span> y nuestro negocio. Sabemos que por la naturaleza de algunas operaciones, el cuidado del medio ambiente puede ser <span class=\"greentext\">un problema complejo.</span></p>\n		</div>\n	</div>\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				Por eso nos hemos propuesto ser una empresa que <span class=\"greentext\">solucione de manera integral</span> las necesidades ambientales del Pa&iacute;s.</p>\n		</div>\n	</div>\n	<div class=\"ez-last ez-oh\">\n		<div class=\"ez-box\">\n			<p>\n				Nuestra <span class=\"greentext\">misi&oacute;n</span> es hacer del cuidado del <span class=\"greentext\">medio</span> ambiente un negocio rentable para nuestros <span class=\"greentext\">clientes</span> y para <span class=\"greentext\">nosotros</span>.</p>\n		</div>\n	</div>\n</div>\n<div class=\"ez-box\" id=\"divisions\">\n	{pyro:featuredproducts:links}</div>\n<div class=\"ez-box\" id=\"divisions-ant\">\n	<div class=\"myJac\">\n		<ul>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divagua.jpg&quot; alt=&quot;Divisi&oacute;n Agua&quot; }</a></li>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divaire.jpg&quot; alt=&quot;Divisi&oacute;n Aire&quot; }</a></li>\n			<li>\n				<a class=\"divthumb\" href=\"#\">{pyro:theme:image file=&quot;divenergia.jpg&quot; }</a></li>\n		</ul>\n	</div>\n</div>',1305186348,1),
	(17,1,'pages','<div class=\"ez-box\" id=\"fpimage\">\n	{pyro:theme:image file=&quot;fpimage.jpg&quot; }</div>\n<div class=\"ez-box\" id=\"fptitle\">\n	<h2>\n		Esto es sustentabilis</h2>\n</div>\n<div class=\"ez-wr\" id=\"fptext\">\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				En <span class=\"greentext\">SUSTENTABILIS</span>, el cuidado del medio ambiente es <span class=\"greentext\">nuestra forma de vida</span> y nuestro negocio. Sabemos que por la naturaleza de algunas operaciones, el cuidado del medio ambiente puede ser <span class=\"greentext\">un problema complejo.</span></p>\n		</div>\n	</div>\n	<div class=\"ez-fl\">\n		<div class=\"ez-box\">\n			<p>\n				Por eso nos hemos propuesto ser una empresa que <span class=\"greentext\">solucione de manera integral</span> las necesidades ambientales del Pa&iacute;s.</p>\n		</div>\n	</div>\n	<div class=\"ez-last ez-oh\">\n		<div class=\"ez-box\">\n			<p>\n				Nuestra <span class=\"greentext\">misi&oacute;n</span> es hacer del cuidado del <span class=\"greentext\">medio</span> ambiente un negocio rentable para nuestros <span class=\"greentext\">clientes</span> y para <span class=\"greentext\">nosotros</span>.</p>\n		</div>\n	</div>\n</div>\n<div class=\"ez-box\" id=\"divisions\">\n	{pyro:featuredproducts:links}\n</div>\n</div>',1305187339,1);

/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table schema_version
# ------------------------------------------------------------

DROP TABLE IF EXISTS `schema_version`;

CREATE TABLE `schema_version` (
  `version` int(3) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `schema_version` WRITE;
/*!40000 ALTER TABLE `schema_version` DISABLE KEYS */;
INSERT INTO `schema_version` (`version`)
VALUES
	(24);

/*!40000 ALTER TABLE `schema_version` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `slug` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `type` set('text','textarea','password','select','select-multiple','radio','checkbox') COLLATE utf8_unicode_ci NOT NULL,
  `default` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `options` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_gui` tinyint(1) NOT NULL,
  `module` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `order` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`slug`),
  UNIQUE KEY `unique - slug` (`slug`),
  KEY `index - slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Stores all sorts of settings for the admin to change';

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`slug`,`title`,`description`,`type`,`default`,`value`,`options`,`is_required`,`is_gui`,`module`,`order`)
VALUES
	('activation_email','Activation Email','Send out an e-mail when a user signs up with an activation link. Disable this to let only admins activate accounts.','radio','1','','1=Enabled|0=Disabled',0,1,'users',963),
	('akismet_api_key','Akismet API Key','Akismet is a spam-blocker from the WordPress team. It keeps spam under control without forcing users to get past human-checking CAPTCHA forms.','text','','','',0,1,'integration',984),
	('comment_order','Comment Order','Sort order in which to display comments.','select','ASC','ASC','ASC=Oldest First|DESC=Newest First',1,1,'comments',966),
	('contact_email','Contact E-mail','All e-mails from users, guests and the site will go to this e-mail address.','text','dev@palmea.net','','',1,1,'email',983),
	('currency','Currency','The currency symbol for use on products, services, etc.','text','&pound;','$','',1,1,'',995),
	('dashboard_rss','Dashboard RSS Feed','Link to an RSS feed that will be displayed on the dashboard.','text','http://feeds.feedburner.com/pyrocms-installed','','',0,1,'',992),
	('dashboard_rss_count','Dashboard RSS Items','How many RSS items would you like to display on the dashboard ? ','text','5','5','',1,1,'',991),
	('date_format','Date Format','How should dates be displayed across the website and control panel? Using the <a target=\"_blank\" href=\"http://php.net/manual/en/function.date.php\">date format</a> from PHP - OR - Using the format of <a target=\"_blank\" href=\"http://php.net/manual/en/function.strftime.php\">strings formatted as date</a> from PHP.','text','Y-m-d','d-m-Y','',1,1,'',996),
	('default_theme','Default Theme','Select the theme you want users to see by default.','','default','sustentabilis','get_themes',1,0,'',0),
	('enable_comments','Enable Comments','Enable comments.','radio','1','0','1=Enabled|0=Disabled',0,1,'comments',968),
	('enable_profiles','Enable profiles','Allow users to add and edit profiles.','radio','1','','1=Enabled|0=Disabled',1,1,'users',965),
	('frontend_enabled','Site Status','Use this option to the user-facing part of the site on or off. Useful when you want to take the site down for maintenence','radio','1','','1=Open|0=Closed',1,1,'',990),
	('ga_email','Google Analytic E-mail','E-mail address used for Google Analytics, we need this to show the graph on the dashboard.','text','','','',0,1,'integration',986),
	('ga_password','Google Analytic Password','Google Analytics password. This is also needed this to show the graph on the dashboard.','password','','','',0,1,'integration',985),
	('ga_profile','Google Analytic Profile ID','Profile ID for this website in Google Analytics.','text','','','',0,1,'integration',987),
	('ga_tracking','Google Tracking Code','Enter your Google Analytic Tracking Code to activate Google Analytics view data capturing. E.g: UA-19483569-6','text','','','',0,1,'integration',988),
	('mail_protocol','Mail Protocol','Select desired email protocol.','select','mail','mail','mail=Mail|sendmail=Sendmail|smtp=SMTP',1,1,'email',980),
	('mail_sendmail_path','Sendmail Path','Path to server sendmail binary.','text','','','',0,1,'email',975),
	('mail_smtp_host','SMTP Host Name','The host name of your smtp server.','text','','','',0,1,'email',979),
	('mail_smtp_pass','SMTP Password','SMTP password.','password','','','',0,1,'email',978),
	('mail_smtp_port','SMTP Port','SMTP port number.','text','','','',0,1,'email',977),
	('mail_smtp_user','SMTP User Name','SMTP user name.','text','','','',0,1,'email',976),
	('meta_topic','Meta Topic','Two or three words describing this type of company/website.','text','Content Management','','',0,1,'',998),
	('moderate_comments','Moderate Comments','Force comments to be approved before they appear on the site.','select','0','','1=Enabled|0=Disabled',0,1,'comments',967),
	('records_per_page','Records Per Page','How many records should we show per page in the admin section?','select','25','','10=10|25=25|50=50|100=100',1,1,'',994),
	('require_lastname','Require last names?','For some situations, a last name may not be required. Do you want to force users to enter one or not?','radio','1','','1=Required|0=Optional',1,1,'users',964),
	('rss_feed_items','Feed item count','How many items should we show in RSS/blog feeds?','select','25','','10=10|25=25|50=50|100=100',1,1,'',993),
	('server_email','Server E-mail','All e-mails to users will come from this e-mail address.','text','admin@localhost','','',1,1,'email',981),
	('site_lang','Site Language','The native language of the website, used to choose templates of e-mail notifications, contact form, and other features that should not depend on the language of a user.','select','en','en','func:get_supported_lang',1,1,'',997),
	('site_name','Site Name','The name of the website for page titles and for use around the site.','text','Un-named Website','Sustentabilis','',1,1,'',1000),
	('site_slogan','Site Slogan','The slogan of the website for page titles and for use around the site.','text','','','',0,1,'',999),
	('twitter_blog','Twitter &amp; Blog integration.','Would you like to post links to new blog articles on Twitter?','radio','0','','1=Enabled|0=Disabled',0,1,'twitter',974),
	('twitter_cache','Cache time','How many minutes should your Tweets be stored?','text','300','','',0,1,'twitter',969),
	('twitter_consumer_key','Consumer Key','Twitter consumer key.','text','','','',0,1,'twitter',971),
	('twitter_consumer_key_secret','Consumer Key Secret','Twitter consumer key secret.','text','','','',0,1,'twitter',970),
	('twitter_feed_count','Feed Count','How many tweets should be returned to the Twitter feed block?','text','5','','',0,1,'twitter',972),
	('twitter_username','Username','Twitter username.','text','','','',0,1,'twitter',973),
	('unavailable_message','Unavailable Message','When the site is turned off or there is a major problem, this message will show to users.','textarea','Sorry, this website is currently unavailable.','','',0,1,'',989),
	('version','Version','','text','1.0','1.2.0-beta2','',0,0,'',0);

/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `salt` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `group_id` int(11) DEFAULT NULL,
  `ip_address` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` int(1) DEFAULT NULL,
  `activation_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_on` int(11) NOT NULL,
  `last_login` int(11) NOT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `forgotten_password_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Registered User Information';

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`email`,`password`,`salt`,`group_id`,`ip_address`,`active`,`activation_code`,`created_on`,`last_login`,`username`,`forgotten_password_code`,`remember_code`)
VALUES
	(1,'dev@palmea.net','f8b7bec025f264d3876bd3556229cc78f367a5bf','d56db',1,'',1,'',1305099997,1305100073,'admin',NULL,NULL);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table variables
# ------------------------------------------------------------

DROP TABLE IF EXISTS `variables`;

CREATE TABLE `variables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table widget_areas
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widget_areas`;

CREATE TABLE `widget_areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `widget_areas` WRITE;
/*!40000 ALTER TABLE `widget_areas` DISABLE KEYS */;
INSERT INTO `widget_areas` (`id`,`slug`,`title`)
VALUES
	(1,'sidebar','Sidebar');

/*!40000 ALTER TABLE `widget_areas` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table widget_instances
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widget_instances`;

CREATE TABLE `widget_instances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `widget_id` int(11) DEFAULT NULL,
  `widget_area_id` int(11) DEFAULT NULL,
  `options` text COLLATE utf8_unicode_ci NOT NULL,
  `order` int(10) NOT NULL DEFAULT '0',
  `created_on` int(11) NOT NULL DEFAULT '0',
  `updated_on` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `title` text COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `author` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `website` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `version` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;






/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
