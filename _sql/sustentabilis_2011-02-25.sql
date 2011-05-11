# Sequel Pro dump
# Version 2492
# http://code.google.com/p/sequel-pro
#
# Host: 127.0.0.1 (MySQL 5.1.37)
# Database: sustentabilis
# Generation Time: 2011-02-25 00:11:20 -0600
# ************************************************************

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table galleries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `galleries`;

CREATE TABLE `galleries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `thumbnail_id` int(11) DEFAULT NULL,
  `description` text,
  `parent` int(11) DEFAULT NULL,
  `updated_on` int(15) NOT NULL,
  `preview` varchar(255) DEFAULT NULL,
  `enable_comments` int(1) DEFAULT NULL,
  `published` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `thumbnail_id` (`thumbnail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table gallery_images
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gallery_images`;

CREATE TABLE `gallery_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gallery_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `extension` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT 'Untitled',
  `description` text,
  `uploaded_on` int(15) DEFAULT NULL,
  `updated_on` int(15) DEFAULT NULL,
  `order` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `gallery_id` (`gallery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` (`id`,`name`,`slug`,`version`,`type`,`description`,`skip_xss`,`is_frontend`,`is_backend`,`menu`,`enabled`,`installed`,`is_core`)
VALUES
	(1,'a:11:{s:2:\"en\";s:8:\"Comments\";s:2:\"pt\";s:12:\"Comentários\";s:2:\"nl\";s:8:\"Reacties\";s:2:\"es\";s:11:\"Comentarios\";s:2:\"fr\";s:12:\"Commentaires\";s:2:\"de\";s:10:\"Kommentare\";s:2:\"pl\";s:10:\"Komentarze\";s:2:\"zh\";s:6:\"回應\";s:2:\"it\";s:8:\"Commenti\";s:2:\"ru\";s:22:\"Комментарии\";s:2:\"ar\";s:16:\"العربيّة\";}','comments','1.0',NULL,'a:11:{s:2:\"en\";s:76:\"Users and guests can write comments for content like news, pages and photos.\";s:2:\"pt\";s:97:\"Usuários e convidados podem escrever comentários para quase tudo com suporte nativo ao captcha.\";s:2:\"nl\";s:52:\"Gebruikers en gasten kunnen reageren op bijna alles.\";s:2:\"es\";s:130:\"Los usuarios y visitantes pueden escribir comentarios en casi todo el contenido con el soporte de un sistema de captcha incluído.\";s:2:\"fr\";s:130:\"Les utilisateurs et les invités peuvent écrire des commentaires pour quasiment tout grâce au générateur de captcha intégré.\";s:2:\"de\";s:65:\"Benutzer und Gäste können für fast alles Kommentare schreiben.\";s:2:\"pl\";s:93:\"Użytkownicy i goście mogą dodawać komentarze z wbudowanym systemem zabezpieczeń captcha.\";s:2:\"zh\";s:75:\"用戶和訪客可以針對新聞、頁面與照片等內容發表回應。\";s:2:\"it\";s:85:\"Utenti e visitatori possono scrivere commenti ai contenuti quali news, pagine e foto.\";s:2:\"ru\";s:187:\"Пользователи и гости могут добавлять комментарии к новостям, информационным страницам и фотографиям.\";s:2:\"ar\";s:152:\"يستطيع الأعضاء والزوّار كتابة التعليقات على المُحتوى كالأخبار، والصفحات والصّوَر.\";}',0,0,1,'content',1,1,1),
	(2,'a:11:{s:2:\"en\";s:5:\"Files\";s:2:\"pt\";s:8:\"Arquivos\";s:2:\"de\";s:7:\"Dateien\";s:2:\"nl\";s:9:\"Bestanden\";s:2:\"fr\";s:8:\"Fichiers\";s:2:\"zh\";s:6:\"檔案\";s:2:\"it\";s:4:\"File\";s:2:\"ru\";s:10:\"Файлы\";s:2:\"ar\";s:16:\"الملفّات\";s:2:\"cs\";s:7:\"Soubory\";s:2:\"es\";s:8:\"Archivos\";}','files','1.0',NULL,'a:11:{s:2:\"en\";s:40:\"Manages files and folders for your site.\";s:2:\"pt\";s:53:\"Permite gerenciar facilmente os arquivos de seu site.\";s:2:\"de\";s:35:\"Verwalte Dateien und Verzeichnisse.\";s:2:\"nl\";s:42:\"Beheer bestanden en folders op uw website.\";s:2:\"fr\";s:46:\"Gérer les fichiers et dossiers de votre site.\";s:2:\"zh\";s:33:\"管理網站中的檔案與目錄\";s:2:\"it\";s:38:\"Gestisci file e cartelle del tuo sito.\";s:2:\"ru\";s:78:\"Управление файлами и папками вашего сайта.\";s:2:\"ar\";s:50:\"إدارة ملفات ومجلّدات موقعك.\";s:2:\"cs\";s:43:\"Spravujte soubory a složky na vašem webu.\";s:2:\"es\";s:43:\"Administra archivos y carpetas en tu sitio.\";}',0,0,1,'content',1,1,1),
	(3,'a:11:{s:2:\"en\";s:6:\"Groups\";s:2:\"pt\";s:6:\"Grupos\";s:2:\"de\";s:7:\"Gruppen\";s:2:\"nl\";s:7:\"Groepen\";s:2:\"fr\";s:7:\"Groupes\";s:2:\"zh\";s:6:\"群組\";s:2:\"it\";s:6:\"Gruppi\";s:2:\"ru\";s:12:\"Группы\";s:2:\"ar\";s:18:\"المجموعات\";s:2:\"cs\";s:7:\"Skupiny\";s:2:\"es\";s:6:\"Grupos\";}','groups','1.0',NULL,'a:11:{s:2:\"en\";s:54:\"Users can be placed into groups to manage permissions.\";s:2:\"pt\";s:72:\"Usuários podem ser inseridos em grupos para gerenciar suas permissões.\";s:2:\"de\";s:85:\"Benutzer können zu Gruppen zusammengefasst werden um diesen Zugriffsrechte zu geben.\";s:2:\"nl\";s:73:\"Gebruikers kunnen in groepen geplaatst worden om rechten te kunnen geven.\";s:2:\"fr\";s:82:\"Les utilisateurs peuvent appartenir à des groupes afin de gérer les permissions.\";s:2:\"zh\";s:45:\"用戶可以依群組分類並管理其權限\";s:2:\"it\";s:69:\"Gli utenti possono essere inseriti in gruppi per gestirne i permessi.\";s:2:\"ru\";s:134:\"Пользователей можно объединять в группы, для управления правами доступа.\";s:2:\"ar\";s:100:\"يمكن وضع المستخدمين في مجموعات لتسهيل إدارة صلاحياتهم.\";s:2:\"cs\";s:77:\"Uživatelé mohou být rozřazeni do skupin pro lepší správu oprávnění.\";s:2:\"es\";s:75:\"Los usuarios podrán ser colocados en grupos para administrar sus permisos.\";}',0,0,1,'users',1,1,1),
	(4,'a:12:{s:2:\"en\";s:7:\"Modules\";s:2:\"nl\";s:7:\"Modules\";s:2:\"es\";s:8:\"Módulos\";s:2:\"fr\";s:7:\"Modules\";s:2:\"de\";s:6:\"Module\";s:2:\"pl\";s:7:\"Moduły\";s:2:\"pt\";s:8:\"Módulos\";s:2:\"zh\";s:6:\"模組\";s:2:\"it\";s:6:\"Moduli\";s:2:\"ru\";s:12:\"Модули\";s:2:\"ar\";s:14:\"الوحدات\";s:2:\"cs\";s:6:\"Moduly\";}','modules','1.0',NULL,'a:12:{s:2:\"en\";s:59:\"Allows admins to see a list of currently installed modules.\";s:2:\"nl\";s:79:\"Stelt admins in staat om een overzicht van geinstalleerde modules te genereren.\";s:2:\"es\";s:71:\"Permite a los administradores ver una lista de los módulos instalados.\";s:2:\"fr\";s:66:\"Permet aux administrateurs de voir la liste des modules installés\";s:2:\"de\";s:56:\"Zeigt Administratoren alle aktuell installierten Module.\";s:2:\"pl\";s:81:\"Umożliwiają administratorowi wgląd do listy obecnie zainstalowanych modułów.\";s:2:\"pt\";s:75:\"Permite aos administradores ver a lista dos módulos instalados atualmente.\";s:2:\"zh\";s:54:\"管理員可以檢視目前已經安裝模組的列表\";s:2:\"it\";s:83:\"Permette agli amministratori di vedere una lista dei moduli attualmente installati.\";s:2:\"ru\";s:83:\"Список модулей, которые установлены на сайте.\";s:2:\"ar\";s:91:\"تُمكّن المُدراء من معاينة جميع الوحدات المُثبّتة.\";s:2:\"cs\";s:68:\"Umožňuje administrátorům vidět seznam nainstalovaných modulů.\";}',0,0,1,'0',1,1,1),
	(5,'a:12:{s:2:\"en\";s:10:\"Navigation\";s:2:\"nl\";s:9:\"Navigatie\";s:2:\"es\";s:11:\"Navegación\";s:2:\"fr\";s:10:\"Navigation\";s:2:\"de\";s:10:\"Navigation\";s:2:\"pl\";s:9:\"Nawigacja\";s:2:\"pt\";s:11:\"Navegação\";s:2:\"zh\";s:9:\"導航列\";s:2:\"it\";s:11:\"Navigazione\";s:2:\"ru\";s:18:\"Навигация\";s:2:\"ar\";s:14:\"الروابط\";s:2:\"cs\";s:8:\"Navigace\";}','navigation','1.0',NULL,'a:12:{s:2:\"en\";s:78:\"Manage links on navigation menus and all the navigation groups they belong to.\";s:2:\"nl\";s:86:\"Beheer links op de navigatiemenu&apos;s en alle navigatiegroepen waar ze onder vallen.\";s:2:\"es\";s:102:\"Administra links en los menús de navegación y en todos los grupos de navegación al cual pertenecen.\";s:2:\"fr\";s:97:\"Gérer les liens du menu Navigation et tous les groupes de navigation auxquels ils appartiennent.\";s:2:\"de\";s:76:\"Verwalte Links in Navigationsmenüs und alle zugehörigen Navigationsgruppen\";s:2:\"pl\";s:95:\"Zarządzaj linkami w menu nawigacji oraz wszystkimi grupami nawigacji do których one należą.\";s:2:\"pt\";s:91:\"Gerenciar links do menu de navegação e todos os grupos de navegação pertencentes a ele.\";s:2:\"zh\";s:72:\"管理導航選單中的連結，以及它們所隸屬的導航群組。\";s:2:\"it\";s:97:\"Gestisci i collegamenti dei menu di navigazione e tutti i gruppi di navigazione da cui dipendono.\";s:2:\"ru\";s:136:\"Управление ссылками в меню навигации и группах, к которым они принадлежат.\";s:2:\"ar\";s:85:\"إدارة روابط وقوائم ومجموعات الروابط في الموقع.\";s:2:\"cs\";s:73:\"Správa odkazů v navigaci a všech souvisejících navigačních skupin.\";}',0,0,1,'design',1,1,1),
	(6,'a:12:{s:2:\"en\";s:4:\"News\";s:2:\"nl\";s:6:\"Nieuws\";s:2:\"es\";s:10:\"Artículos\";s:2:\"fr\";s:11:\"Actualités\";s:2:\"de\";s:4:\"News\";s:2:\"pl\";s:12:\"Aktualności\";s:2:\"pt\";s:9:\"Novidades\";s:2:\"zh\";s:6:\"新聞\";s:2:\"it\";s:7:\"Notizie\";s:2:\"ru\";s:14:\"Новости\";s:2:\"ar\";s:14:\"الأخبار\";s:2:\"cs\";s:7:\"Novinky\";}','news','1.0',NULL,'a:12:{s:2:\"en\";s:36:\"Post news articles and blog entries.\";s:2:\"nl\";s:41:\"Post nieuwsartikelen en blogs op uw site.\";s:2:\"es\";s:55:\"Escribe entradas para los artículos y blogs (web log).\";s:2:\"fr\";s:49:\"Envoyez de nouveaux articles et messages de blog.\";s:2:\"de\";s:47:\"Veröffentliche neue Artikel und Blog-Einträge\";s:2:\"pl\";s:40:\"Postuj nowe artykuły oraz wpisy w blogu\";s:2:\"pt\";s:46:\"Escrever novos artigos e publicações de blog\";s:2:\"zh\";s:39:\"發表新聞訊息、部落格文章。\";s:2:\"it\";s:36:\"Pubblica notizie e post per il blog.\";s:2:\"ru\";s:90:\"Управление новостными статьями и записями блога.\";s:2:\"ar\";s:60:\"أنشر مقالات الأخبار والمُدوّنات.\";s:2:\"cs\";s:49:\"Publikujte nové články a příspěvky na blog.\";}',0,1,1,'content',1,1,1),
	(7,'a:12:{s:2:\"en\";s:5:\"Pages\";s:2:\"nl\";s:13:\"Pagina&apos;s\";s:2:\"es\";s:8:\"Páginas\";s:2:\"fr\";s:5:\"Pages\";s:2:\"de\";s:6:\"Seiten\";s:2:\"pl\";s:6:\"Strony\";s:2:\"pt\";s:8:\"Páginas\";s:2:\"zh\";s:6:\"頁面\";s:2:\"it\";s:6:\"Pagine\";s:2:\"ru\";s:16:\"Страницы\";s:2:\"ar\";s:14:\"الصفحات\";s:2:\"cs\";s:8:\"Stránky\";}','pages','1.0',NULL,'a:12:{s:2:\"en\";s:55:\"Add custom pages to the site with any content you want.\";s:2:\"nl\";s:70:\"Voeg aangepaste pagina&apos;s met willekeurige inhoud aan de site toe.\";s:2:\"pl\";s:53:\"Dodaj własne strony z dowolną treścią do witryny.\";s:2:\"es\";s:77:\"Agrega páginas customizadas al sitio con cualquier contenido que tu quieras.\";s:2:\"fr\";s:89:\"Permet d\'ajouter sur le site des pages personalisées avec le contenu que vous souhaitez.\";s:2:\"de\";s:49:\"Füge eigene Seiten mit anpassbaren Inhalt hinzu.\";s:2:\"pt\";s:82:\"Adicionar páginas personalizadas ao site com qualquer conteúdo que você queira.\";s:2:\"zh\";s:39:\"為您的網站新增自定的頁面。\";s:2:\"it\";s:73:\"Aggiungi pagine personalizzate al sito con qualsiesi contenuto tu voglia.\";s:2:\"ru\";s:134:\"Управление информационными страницами сайта, с произвольным содержимым.\";s:2:\"ar\";s:99:\"إضافة صفحات مُخصّصة إلى الموقع تحتوي أية مُحتوى تريده.\";s:2:\"cs\";s:74:\"Přidávejte vlastní stránky na web s jakýmkoliv obsahem budete chtít.\";}',0,1,1,'content',1,1,1),
	(8,'a:12:{s:2:\"en\";s:11:\"Permissions\";s:2:\"nl\";s:15:\"Toegangsrechten\";s:2:\"es\";s:8:\"Permisos\";s:2:\"fr\";s:11:\"Permissions\";s:2:\"de\";s:14:\"Zugriffsrechte\";s:2:\"pl\";s:11:\"Uprawnienia\";s:2:\"pt\";s:11:\"Permissões\";s:2:\"zh\";s:6:\"權限\";s:2:\"it\";s:8:\"Permessi\";s:2:\"ru\";s:25:\"Права доступа\";s:2:\"ar\";s:18:\"الصلاحيات\";s:2:\"cs\";s:12:\"Oprávnění\";}','permissions','0.5',NULL,'a:12:{s:2:\"en\";s:68:\"Control what type of users can see certain sections within the site.\";s:2:\"nl\";s:71:\"Bepaal welke typen gebruikers toegang hebben tot gedeeltes van de site.\";s:2:\"pl\";s:79:\"Ustaw, którzy użytkownicy mogą mieć dostęp do odpowiednich sekcji witryny.\";s:2:\"es\";s:81:\"Controla que tipo de usuarios pueden ver secciones específicas dentro del sitio.\";s:2:\"fr\";s:104:\"Permet de définir les autorisations des groupes d\'utilisateurs pour afficher les différentes sections.\";s:2:\"de\";s:70:\"Regelt welche Art von Benutzer welche Sektion in der Seite sehen kann.\";s:2:\"pt\";s:68:\"Controle quais tipos de usuários podem ver certas seções no site.\";s:2:\"zh\";s:81:\"用來控制不同類別的用戶，設定其瀏覽特定網站內容的權限。\";s:2:\"it\";s:78:\"Controlla che tipo di utenti posssono accedere a determinate sezioni del sito.\";s:2:\"ru\";s:209:\"Управление правами доступа, ограничение доступа определённых групп пользователей к произвольным разделам сайта.\";s:2:\"ar\";s:127:\"التحكم بإعطاء الصلاحيات للمستخدمين للوصول إلى أقسام الموقع المختلفة.\";s:2:\"cs\";s:93:\"Spravujte oprávnění pro jednotlivé typy uživatelů a ke kterým sekcím mají přístup.\";}',0,0,1,'users',1,1,1),
	(9,'a:8:{s:2:\"nl\";s:12:\"Verwijzingen\";s:2:\"en\";s:9:\"Redirects\";s:2:\"fr\";s:12:\"Redirections\";s:2:\"it\";s:11:\"Reindirizzi\";s:2:\"ru\";s:30:\"Перенаправления\";s:2:\"ar\";s:18:\"التوجيهات\";s:2:\"pt\";s:17:\"Redirecionamentos\";s:2:\"cs\";s:16:\"Přesměrování\";}','redirects','1.0',NULL,'a:8:{s:2:\"nl\";s:38:\"Verwijs vanaf een URL naar een andere.\";s:2:\"en\";s:33:\"Redirect from one URL to another.\";s:2:\"fr\";s:34:\"Redirection d\'une URL à un autre.\";s:2:\"it\";s:35:\"Reindirizza da una URL ad un altra.\";s:2:\"ru\";s:78:\"Перенаправления с одного адреса на другой.\";s:2:\"ar\";s:47:\"التوجيه من رابط URL إلى آخر.\";s:2:\"pt\";s:39:\"Redirecionamento de uma URL para outra.\";s:2:\"cs\";s:43:\"Přesměrujte z jedné adresy URL na jinou.\";}',0,0,1,'utilities',1,1,1),
	(10,'a:11:{s:2:\"en\";s:8:\"Settings\";s:2:\"nl\";s:12:\"Instellingen\";s:2:\"es\";s:15:\"Configuraciones\";s:2:\"fr\";s:11:\"Paramètres\";s:2:\"de\";s:13:\"Einstellungen\";s:2:\"pl\";s:10:\"Ustawienia\";s:2:\"pt\";s:15:\"Configurações\";s:2:\"zh\";s:12:\"網站設定\";s:2:\"it\";s:12:\"Impostazioni\";s:2:\"ru\";s:18:\"Настройки\";s:2:\"cs\";s:10:\"Nastavení\";}','settings','0.4',NULL,'a:11:{s:2:\"en\";s:89:\"Allows administrators to update settings like Site Name, messages and email address, etc.\";s:2:\"nl\";s:114:\"Maakt het administratoren en medewerkers mogelijk om websiteinstellingen zoals naam en beschrijving te veranderen.\";s:2:\"es\";s:131:\"Permite a los administradores y al personal configurar los detalles del sitio como el nombre del sitio y la descripción del mismo.\";s:2:\"fr\";s:105:\"Permet aux admistrateurs et au personnel de modifier les paramètres du site : nom du site et description\";s:2:\"de\";s:92:\"Erlaubt es Administratoren die Einstellungen der Seite wie Name und Beschreibung zu ändern.\";s:2:\"pl\";s:103:\"Umożliwia administratorom zmianę ustawień strony jak nazwa strony, opis, e-mail administratora, itd.\";s:2:\"pt\";s:120:\"Permite com que administradores e a equipe consigam trocar as configurações do website incluindo o nome e descrição.\";s:2:\"zh\";s:99:\"網站管理者可更新的重要網站設定。例如：網站名稱、訊息、電子郵件等。\";s:2:\"it\";s:109:\"Permette agli amministratori di aggiornare impostazioni quali Nome del Sito, messaggi e indirizzo email, etc.\";s:2:\"ru\";s:135:\"Управление настройками сайта - Имя сайта, сообщения, почтовые адреса и т.п.\";s:2:\"cs\";s:102:\"Umožňuje administrátorům měnit nastavení webu jako jeho jméno, zprávy a emailovou adresu apod.\";}',0,0,1,'0',1,1,1),
	(11,'a:12:{s:2:\"en\";s:6:\"Themes\";s:2:\"nl\";s:12:\"Thema&apos;s\";s:2:\"es\";s:5:\"Temas\";s:2:\"fr\";s:7:\"Thèmes\";s:2:\"de\";s:6:\"Themen\";s:2:\"pl\";s:6:\"Motywy\";s:2:\"pt\";s:5:\"Temas\";s:2:\"zh\";s:12:\"佈景主題\";s:2:\"it\";s:4:\"Temi\";s:2:\"ru\";s:8:\"Темы\";s:2:\"ar\";s:14:\"السّمات\";s:2:\"cs\";s:14:\"Motivy vzhledu\";}','themes','0.5',NULL,'a:12:{s:2:\"en\";s:109:\"Allows admins and staff to change website theme, upload new themes and manage them in a more visual approach.\";s:2:\"nl\";s:153:\"Maakt het voor administratoren en medewerkers mogelijk om het thema van de website te wijzigen, nieuwe thema&apos;s te uploaden en ze visueel te beheren.\";s:2:\"es\";s:132:\"Permite a los administradores y miembros del personal cambiar el tema del sitio web, subir nuevos temas y manejar los ya existentes.\";s:2:\"fr\";s:144:\"Permet aux administrateurs et au personnel de modifier le thème du site, de charger de nouveaux thèmes et de le gérer de façon plus visuelle\";s:2:\"de\";s:121:\"Ermöglicht es dem Administrator das Seiten Thema auszuwählen, neue Themen hochzulanden oder diese visuell zu verwalten.\";s:2:\"pl\";s:100:\"Umożliwia administratorowi zmianę motywu strony, wgrywanie nowych motywów oraz zarządzanie nimi.\";s:2:\"pt\";s:165:\"Permite com que administradores e membros da equipe configurem o tema de layout do website, fazer upload de novos temas e gerenciá-los em uma interface mais visual.\";s:2:\"zh\";s:108:\"讓管理者可以更改網站顯示風貌，以視覺化的操作上傳並管理這些網站佈景主題。\";s:2:\"it\";s:120:\"Permette ad amministratori e staff di cambiare il tema del sito, carica nuovi temi e gestiscili in um modo più visuale.\";s:2:\"ru\";s:102:\"Управление темами оформления сайта, загрузка новых тем.\";s:2:\"ar\";s:170:\"تمكّن الإدارة وأعضاء الموقع تغيير سِمة الموقع، وتحميل سمات جديدة وإدارتها بطريقة مرئية سلسة.\";s:2:\"cs\";s:106:\"Umožňuje administrátorům a dalším osobám měnit vzhled webu, nahrávat nové motivy a spravovat je.\";}',0,0,1,'design',1,1,1),
	(12,'a:12:{s:2:\"en\";s:9:\"Variables\";s:2:\"nl\";s:10:\"Variabelen\";s:2:\"pl\";s:7:\"Zmienne\";s:2:\"es\";s:9:\"Variables\";s:2:\"fr\";s:9:\"Variables\";s:2:\"de\";s:9:\"Variablen\";s:2:\"pt\";s:10:\"Variáveis\";s:2:\"zh\";s:12:\"系統變數\";s:2:\"it\";s:9:\"Variabili\";s:2:\"ru\";s:20:\"Переменные\";s:2:\"ar\";s:20:\"المتغيّرات\";s:2:\"cs\";s:10:\"Proměnné\";}','variables','0.3',NULL,'a:12:{s:2:\"en\";s:50:\"Manage global variables to access from everywhere.\";s:2:\"nl\";s:54:\"Beheer globale variabelen die overal beschikbaar zijn.\";s:2:\"pl\";s:86:\"Zarządzaj globalnymi zmiennymi do których masz dostęp z każdego miejsca aplikacji.\";s:2:\"es\";s:50:\"Manage global variables to access from everywhere.\";s:2:\"fr\";s:50:\"Manage global variables to access from everywhere.\";s:2:\"de\";s:74:\"Verwaltet globale Variablen, auf die von überall zugegriffen werden kann.\";s:2:\"pt\";s:61:\"Gerencia as variáveis globais acessíveis de qualquer lugar.\";s:2:\"zh\";s:45:\"管理此網站內可存取的全局變數。\";s:2:\"it\";s:58:\"Gestisci le variabili globali per accedervi da ogni parte.\";s:2:\"ru\";s:136:\"Управление глобальными переменными, которые доступны в любом месте сайта.\";s:2:\"ar\";s:97:\"إدارة المُتغيّرات العامة لاستخدامها في أرجاء الموقع.\";s:2:\"cs\";s:56:\"Spravujte globální proměnné přístupné odkudkoliv.\";}',0,0,1,'content',1,1,1),
	(13,'a:10:{s:2:\"en\";s:7:\"Widgets\";s:2:\"pt\";s:7:\"Widgets\";s:2:\"de\";s:7:\"Widgets\";s:2:\"nl\";s:7:\"Widgets\";s:2:\"fr\";s:7:\"Widgets\";s:2:\"zh\";s:9:\"小組件\";s:2:\"it\";s:7:\"Widgets\";s:2:\"ru\";s:14:\"Виджеты\";s:2:\"ar\";s:12:\"الودجت\";s:2:\"cs\";s:7:\"Widgety\";}','widgets','1.0',NULL,'a:10:{s:2:\"en\";s:69:\"Manage small sections of self-contained logic in blocks or \"Widgets\".\";s:2:\"pt\";s:77:\"Gerenciar pequenas seções de conteúdos em bloco conhecidos como \"Widgets\".\";s:2:\"de\";s:62:\"Verwaltet kleine, eigentständige Bereiche, genannt \"Widgets\".\";s:2:\"nl\";s:75:\"Beheer kleine onderdelen die zelfstandige logica bevatten, ofwel \"Widgets\".\";s:2:\"fr\";s:41:\"Gérer des mini application ou \"Widgets\".\";s:2:\"zh\";s:103:\"可將小段的程式碼透過小組件來管理。即所謂 \"Widgets\"，或稱為小工具、部件。\";s:2:\"it\";s:70:\"Gestisci piccole sezioni di logica a se stante in blocchi o \"Widgets\".\";s:2:\"ru\";s:91:\"Управление небольшими, самостоятельными блоками.\";s:2:\"ar\";s:138:\"إدارة أقسام صغيرة من البرمجيات في مساحات الموقع أو ما يُسمّى بالـ\"وِدْجِتْ\".\";s:2:\"cs\";s:56:\"Spravujte malé funkční části webu neboli \"Widgety\".\";}',0,0,1,'content',1,1,1),
	(14,'a:12:{s:2:\"en\";s:7:\"Contact\";s:2:\"nl\";s:7:\"Contact\";s:2:\"pl\";s:7:\"Kontakt\";s:2:\"es\";s:8:\"Contacto\";s:2:\"fr\";s:7:\"Contact\";s:2:\"de\";s:7:\"Kontakt\";s:2:\"zh\";s:12:\"聯絡我們\";s:2:\"it\";s:10:\"Contattaci\";s:2:\"ru\";s:27:\"Обратная связь\";s:2:\"ar\";s:14:\"الإتصال\";s:2:\"pt\";s:7:\"Contato\";s:2:\"cs\";s:7:\"Kontakt\";}','contact','0.6',NULL,'a:12:{s:2:\"en\";s:112:\"Adds a form to your site that allows visitors to send emails to you without disclosing an email address to them.\";s:2:\"nl\";s:125:\"Voegt een formulier aan de site toe waarmee bezoekers een email kunnen sturen, zonder dat u ze een emailadres hoeft te tonen.\";s:2:\"pl\";s:126:\"Dodaje formularz kontaktowy do Twojej strony, który pozwala użytkownikom wysłanie maila za pomocą formularza kontaktowego.\";s:2:\"es\";s:156:\"Añade un formulario a tu sitio que permitirá a los visitantes enviarte correos electrónicos a ti sin darles tu dirección de correo directamente a ellos.\";s:2:\"fr\";s:122:\"Ajoute un formulaire à votre site qui permet aux visiteurs de vous envoyer un e-mail sans révéler votre adresse e-mail.\";s:2:\"de\";s:119:\"Fügt ein Formular hinzu, welches Besuchern erlaubt Emails zu schreiben, ohne die Kontakt Email-Adresse offen zu legen.\";s:2:\"zh\";s:147:\"為您的網站新增「聯絡我們」的功能，對訪客是較為清楚便捷的聯絡方式，也無須您將電子郵件公開在網站上。\";s:2:\"it\";s:119:\"Aggiunge un modulo al tuo sito che permette ai visitatori di inviarti email senza mostrare loro il tuo indirizzo email.\";s:2:\"ru\";s:234:\"Добавляет форму обратной связи на сайт, через которую посетители могут отправлять вам письма, при этом адрес Email остаётся скрыт.\";s:2:\"ar\";s:157:\"إضافة استمارة إلى موقعك تُمكّن الزوّار من مراسلتك دون علمهم بعنوان البريد الإلكتروني.\";s:2:\"pt\";s:139:\"Adiciona um formulário para o seu site permitir aos visitantes que enviem e-mails para voce sem divulgar um endereço de e-mail para eles.\";s:2:\"cs\";s:149:\"Přidá na web kontaktní formulář pro návštěvníky a uživatele, díky kterému vás mohou kontaktovat i bez znalosti vaší e-mailové adresy.\";}',0,1,0,'0',1,1,0),
	(15,'a:11:{s:2:\"en\";s:9:\"Galleries\";s:2:\"de\";s:8:\"Galerien\";s:2:\"nl\";s:10:\"Gallerijen\";s:2:\"fr\";s:8:\"Galeries\";s:2:\"zh\";s:6:\"畫廊\";s:2:\"it\";s:8:\"Gallerie\";s:2:\"ru\";s:14:\"Галереи\";s:2:\"ar\";s:23:\"معارض الصّور\";s:2:\"pt\";s:8:\"Galerias\";s:2:\"cs\";s:7:\"Galerie\";s:2:\"es\";s:9:\"Galerías\";}','galleries','1.0',NULL,'a:11:{s:2:\"en\";s:81:\"The galleries module is a powerful module that lets users create image galleries.\";s:2:\"de\";s:55:\"Mit dem Galerie Modul kannst du Bildergalerien anlegen.\";s:2:\"nl\";s:96:\"De gallerij module is een krachtige module dat gebruikers in staat stelt gallerijen te plaatsen.\";s:2:\"fr\";s:79:\"Galerie est une puissante extension permettant de créer des galeries d\'images.\";s:2:\"zh\";s:84:\"這是一個功能完整的模組，可以讓用戶建立自己的相簿或畫廊。\";s:2:\"it\";s:96:\"Il modulo gallerie è un potente modulo che permette agli utenti di creare gallerie di immagini.\";s:2:\"ru\";s:175:\"Галереи - мощный модуль, который даёт пользователям возможность создавать галереи изображений.\";s:2:\"ar\";s:88:\"هذه الوحدة تمُكّنك من إنشاء معارض الصّور بسهولة.\";s:2:\"pt\";s:97:\"O módulo de galerias é um poderoso módulo que permite aos usuários criar galerias de imagens.\";s:2:\"cs\";s:59:\"Silný modul pro vytváření a správu galerií obrázků.\";s:2:\"es\";s:88:\"Galerías es un potente módulo que permite a los usuarios crear galerías de imágenes.\";}',0,1,1,'content',1,1,0),
	(16,'a:12:{s:2:\"en\";s:5:\"Users\";s:2:\"nl\";s:10:\"Gebruikers\";s:2:\"pl\";s:12:\"Użytkownicy\";s:2:\"es\";s:8:\"Usuarios\";s:2:\"fr\";s:12:\"Utilisateurs\";s:2:\"de\";s:8:\"Benutzer\";s:2:\"pt\";s:9:\"Usuários\";s:2:\"zh\";s:6:\"用戶\";s:2:\"it\";s:6:\"Utenti\";s:2:\"ru\";s:24:\"Пользователи\";s:2:\"ar\";s:20:\"المستخدمون\";s:2:\"cs\";s:11:\"Uživatelé\";}','users','0.8',NULL,'a:12:{s:2:\"en\";s:81:\"Let users register and log in to the site, and manage them via the control panel.\";s:2:\"nl\";s:88:\"Laat gebruikers registreren en inloggen op de site, en beheer ze via het controlepaneel.\";s:2:\"pl\";s:87:\"Pozwól użytkownikom na logowanie się na stronie i zarządzaj nimi za pomocą panelu.\";s:2:\"es\";s:138:\"Permite el registro de nuevos usuarios quienes podrán loguearse en el sitio. Estos podrán controlarse desde el panel de administración.\";s:2:\"fr\";s:112:\"Permet aux utilisateurs de s\'enregistrer et de se connecter au site et de les gérer via le panneau de contrôle\";s:2:\"de\";s:108:\"Erlaube Benutzern das Registrieren und Einloggen auf der Seite und verwalte sie über die Admin-Oberfläche.\";s:2:\"pt\";s:125:\"Permite com que usuários se registrem e entrem no site e também que eles sejam gerenciáveis apartir do painel de controle.\";s:2:\"zh\";s:87:\"讓用戶可以註冊並登入網站，並且管理者可在控制台內進行管理。\";s:2:\"it\";s:95:\"Fai iscrivere de entrare nel sito gli utenti, e gestiscili attraverso il pannello di controllo.\";s:2:\"ru\";s:155:\"Управление зарегистрированными пользователями, активирование новых пользователей.\";s:2:\"ar\";s:133:\"تمكين المستخدمين من التسجيل والدخول إلى الموقع، وإدارتهم من لوحة التحكم.\";s:2:\"cs\";s:103:\"Umožňuje uživatelům se registrovat a přihlašovat a zároveň jejich správu v Kontrolním panelu.\";}',0,0,1,'0',1,1,1),
	(17,'a:12:{s:2:\"en\";s:7:\"Contact\";s:2:\"nl\";s:7:\"Contact\";s:2:\"pl\";s:7:\"Kontakt\";s:2:\"es\";s:8:\"Contacto\";s:2:\"fr\";s:7:\"Contact\";s:2:\"de\";s:7:\"Kontakt\";s:2:\"zh\";s:12:\"聯絡我們\";s:2:\"it\";s:10:\"Contattaci\";s:2:\"ru\";s:27:\"Обратная связь\";s:2:\"ar\";s:14:\"الإتصال\";s:2:\"pt\";s:7:\"Contato\";s:2:\"cs\";s:7:\"Kontakt\";}','nosotros','0.6',NULL,'a:12:{s:2:\"en\";s:112:\"Adds a form to your site that allows visitors to send emails to you without disclosing an email address to them.\";s:2:\"nl\";s:125:\"Voegt een formulier aan de site toe waarmee bezoekers een email kunnen sturen, zonder dat u ze een emailadres hoeft te tonen.\";s:2:\"pl\";s:126:\"Dodaje formularz kontaktowy do Twojej strony, który pozwala użytkownikom wysłanie maila za pomocą formularza kontaktowego.\";s:2:\"es\";s:156:\"Añade un formulario a tu sitio que permitirá a los visitantes enviarte correos electrónicos a ti sin darles tu dirección de correo directamente a ellos.\";s:2:\"fr\";s:122:\"Ajoute un formulaire à votre site qui permet aux visiteurs de vous envoyer un e-mail sans révéler votre adresse e-mail.\";s:2:\"de\";s:119:\"Fügt ein Formular hinzu, welches Besuchern erlaubt Emails zu schreiben, ohne die Kontakt Email-Adresse offen zu legen.\";s:2:\"zh\";s:147:\"為您的網站新增「聯絡我們」的功能，對訪客是較為清楚便捷的聯絡方式，也無須您將電子郵件公開在網站上。\";s:2:\"it\";s:119:\"Aggiunge un modulo al tuo sito che permette ai visitatori di inviarti email senza mostrare loro il tuo indirizzo email.\";s:2:\"ru\";s:234:\"Добавляет форму обратной связи на сайт, через которую посетители могут отправлять вам письма, при этом адрес Email остаётся скрыт.\";s:2:\"ar\";s:157:\"إضافة استمارة إلى موقعك تُمكّن الزوّار من مراسلتك دون علمهم بعنوان البريد الإلكتروني.\";s:2:\"pt\";s:139:\"Adiciona um formulário para o seu site permitir aos visitantes que enviem e-mails para voce sem divulgar um endereço de e-mail para eles.\";s:2:\"cs\";s:149:\"Přidá na web kontaktní formulář pro návštěvníky a uživatele, díky kterému vás mohou kontaktovat i bez znalosti vaší e-mailové adresy.\";}',0,1,0,'0',0,0,0);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Links for site navigation';

LOCK TABLES `navigation_links` WRITE;
/*!40000 ALTER TABLE `navigation_links` DISABLE KEYS */;
INSERT INTO `navigation_links` (`id`,`title`,`link_type`,`page_id`,`module_name`,`url`,`uri`,`navigation_group_id`,`position`,`target`,`class`)
VALUES
	(1,'Inicio','page',1,'','','',1,1,'',''),
	(2,'Divisiones','module',0,'divisiones','','#',1,2,'',''),
	(3,'Nosotros','page',3,'','','',1,3,'',''),
	(4,'Contacto','module',0,'contact','','',1,4,'','');

/*!40000 ALTER TABLE `navigation_links` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table news
# ------------------------------------------------------------

DROP TABLE IF EXISTS `news`;

CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `category_id` int(11) NOT NULL,
  `attachment` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `intro` text COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `created_on` int(11) NOT NULL,
  `updated_on` int(11) NOT NULL DEFAULT '0',
  `status` enum('draft','live') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'draft',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `category_id - normal` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='News articles or blog posts.';



# Dump of table news_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `news_categories`;

CREATE TABLE `news_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug - unique` (`slug`),
  UNIQUE KEY `title - unique` (`title`),
  KEY `slug - normal` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='News Categories';



# Dump of table page_layouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `page_layouts`;

CREATE TABLE `page_layouts` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `css` text COLLATE utf8_unicode_ci NOT NULL,
  `theme_layout` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'default',
  `updated_on` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Store shared page layouts & CSS';

LOCK TABLES `page_layouts` WRITE;
/*!40000 ALTER TABLE `page_layouts` DISABLE KEYS */;
INSERT INTO `page_layouts` (`id`,`title`,`body`,`css`,`theme_layout`,`updated_on`)
VALUES
	(1,'Default','<h2>{pyro:page:title}</h2>\n\n\n{pyro:page:body}','','default',1298447730);

/*!40000 ALTER TABLE `page_layouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pages`;

CREATE TABLE `pages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `Unique` (`slug`,`parent_id`),
  KEY `slug` (`slug`),
  KEY `parent` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='User Editable Pages';

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` (`id`,`slug`,`title`,`parent_id`,`revision_id`,`layout_id`,`css`,`js`,`meta_title`,`meta_keywords`,`meta_description`,`rss_enabled`,`comments_enabled`,`status`,`created_on`,`updated_on`)
VALUES
	(1,'home','Inicio',0,'7','1','','function init() {               \n        // options\n        var o = {\n          enableMouse: false,\n          childSizeFixed:true\n        };\n        // Setup galleries\n        $(\".myJac\").jac(o);  \n      }\n          \n      $(init); // on DOM ready','','','',0,0,'draft',1298609574,1298609574),
	(2,'404','Page missing',0,'1','1',NULL,NULL,'','',NULL,0,0,'live',1298447730,1298447730),
	(3,'nosotros','Nosotros',0,'6','1','/* CSS Document */\nul.nostabs {\n  margin: 0;\n  padding: 0;\n  float: left;\n  list-style: none;\n  height: 38px; /*--Set height of tabs--*/\n  border: none;\n  width: 100%;\n  top: 0px;\n}\nul.nostabs li {\n  float: left;\n  margin: 0;\n  padding: 0;\n  height: 35px; /*--Subtract 1px from the height of the unordered list--*/\n  line-height: 31px; /*--Vertically aligns the text within the tab--*/\n  border: none;\n  margin-right:3px;\n  margin-bottom: -3px; /*--Pull the list item down 1px--*/\n  overflow: hidden;\n  position: relative;\n  background: #181818;\n}\nul.nostabs li a {\n  text-decoration: none;\n  display: block;\n  font-size: 1.2em;\n  padding: 0 20px;\n  border: none;\n  outline: none;\n  height:100%\n}\nul.nostabs li a:hover {\n  background: #000;\n}\nhtml ul.nostabs li.active, html ul.nostabs li.active a:hover  { /*--Makes sure that the active tab does not listen to the hover properties--*/\n  background: #181818;\n  border-bottom: 3px solid #181818; /*--Makes the active tab look like it\'s connected with its content--*/\n}\n\n.tab_container {\n  border:  none;\n  overflow: hidden;\n  clear: both;\n  float: left; width: 100%;\n  background: #181818;\n}\n.tab_content {\n  padding: 20px;\n  font-size: 1.2em;\n}','$(document).ready(function() {\n          //When page loads...\n          $(\".tab_content\").hide(); //Hide all content\n          $(\"ul.nostabs li:first\").addClass(\"active\").show(); //Activate first tab\n          $(\".tab_content:first\").show(); //Show first tab content\n          //On Click Event\n          $(\"ul.nostabs li\").click(function() {\n            $(\"ul.nostabs li\").removeClass(\"active\"); //Remove any \"active\" class\n            $(this).addClass(\"active\"); //Add \"active\" class to selected tab\n            $(\".tab_content\").hide(); //Hide all tab content\n        \n            var activeTab = $(this).find(\"a\").attr(\"href\"); //Find the href attribute value to identify the active tab + content\n            $(activeTab).fadeIn(); //Fade in the active ID content\n            return false;\n          });\n        });','','','',0,0,'live',1298608213,1298608660);

/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pages_lookup
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pages_lookup`;

CREATE TABLE `pages_lookup` (
  `id` int(11) NOT NULL,
  `path` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Lookup table for page IDs and page paths.';

LOCK TABLES `pages_lookup` WRITE;
/*!40000 ALTER TABLE `pages_lookup` DISABLE KEYS */;
INSERT INTO `pages_lookup` (`id`,`path`)
VALUES
	(1,'home'),
	(3,'nosotros');

/*!40000 ALTER TABLE `pages_lookup` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `permissions`;

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `module` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Contains a list of modules that a group can access.';



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
	(1,1,'Pablo Pablo','Pablo','Resines','','en',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
INSERT INTO `revisions` (`id`,`owner_id`,`table_name`,`body`,`revision_date`,`author_id`)
VALUES
	(1,1,'pages','Welcome to our homepage. We have not quite finished setting up our website yet, but please add us to your bookmarks and come back soon.',1298447730,0),
	(2,2,'pages','<p>We cannot find the page you are looking for, please click <a title=\"Home\" href=\"{page_url(1)}\">here</a> to go to the homepage.</p>',1298447730,0),
	(3,3,'pages','<ul class=\"nostabs\">\n                <li><a href=\"#nuestros_compromisos\">Nuestros Compromisos</a></li>\n                <li><a href=\"#Mision\">Misión</a></li>\n                <li><a href=\"#Vision\">Visión</a></li>\n                <li><a href=\"#Historia\">Historia</a></li>\n            </ul>\n            <div class=\"tab_container\">\n                <div id=\"nuestros_compromisos\" class=\"tab_content\">\n      <p>Nuestra promesa: estar comprometidos con el medio ambiente y nuestro entorno.  Buscar que todas nuestras actividades impacten positivamente a nuestros clientes, nuestros empleados, nuestros socios, nuestra comunidad y nuestro planeta. </p>\n                      <p>Para NUESTROS CLIENTES: ayudarlos a minimizar o eliminar el impacto que sus procesos puedan causar al medio ambiente, ayudándolos a hacerlos de una manera rentable. (sustentable?)</p>\n                      <p>Para NUESTROS EMPLEADOS: ante todo, cuidar su seguridad, buscando contribuir en su desarrollo personal y profesional, ofreciéndoles un entorno de trabajo justo, seguro y amigable. Y contagiarlos para que nuestro compromiso sustentable, sea también el suyo.</p>\n                      <p>Para NUESTROS SOCIOS, maximizar sus utilidades, cumpliendo siempre con los principios de responsabilidad bajo los cuales fue fundada la empresa.</p>\n                      <p>Para LA COMUNIDAD, hacer negocios de una manera ética, justa y responsable.</p>\n    </div>\n                <div id=\"Mision\" class=\"tab_content\">Hacer del cuidado del medio ambiente un negocio rentable para nuestros clientes y para nosotros.</div>\n                <div id=\"Vision\" class=\"tab_content\">\n                  <p>Ser una empresa líder en el mercado de ingeniería ambiental y conservación, que genere ingresos a través de la explotación sustentable de los recursos naturales y renovables, la prevención y el control de la contaminación.</p>\n                </div>\n                <div id=\"Historia\" class=\"tab_content\">\n     <p>Sustentabilis nace en el año 2001 bajo el nombre de Mir Ambiental con una fundada inquietud en detener y revertir el deterioro ambiental. Esto ayudó a estructurar las acciones de la empresa, comenzando con un cambio cultural y concluyendo con soluciones tangibles, es decir, soluciones integrales a favor del medio ambiente, como plantas de tratamiento de agua residual, y otros productos y servicios: cosechado de suelos con aguas pluviales, planes de manejo sustentable, estudios de impacto ambiental, techos verdes y energías limpias.</p>\n     <p>Sustentabilis opera con una filosofía basada en fundamentos sustentables, buscando un beneficio económico, social y ambiental, con tecnologías apropiadas y con procesos de mejora continua bajo principios de confiabilidad, calidad y eficiencia.</p>\n                </div>\n            </div>',1298608213,1),
	(4,3,'pages','<div class=\"ez-box\" id=\"fpimage\">\n        <img src=\"images/nosotrosimage.jpg\" />\n      </div>\n      <div class=\"ez-box\" id=\"fptitle\"><img src=\"images/nosotrostitle.png\" alt=\"NOSOTROS SOMOS SUSTENTABILIS\" /></div>\n      <div class=\"ez-wr\" id=\"fptext\">\n       <div class=\"ez-box\">\n            <ul class=\"nostabs\">\n                <li><a href=\"#nuestros_compromisos\">Nuestros Compromisos</a></li>\n                <li><a href=\"#Mision\">Misión</a></li>\n                <li><a href=\"#Vision\">Visión</a></li>\n                <li><a href=\"#Historia\">Historia</a></li>\n            </ul>\n            <div class=\"tab_container\">\n                <div id=\"nuestros_compromisos\" class=\"tab_content\">\n      <p>Nuestra promesa: estar comprometidos con el medio ambiente y nuestro entorno.  Buscar que todas nuestras actividades impacten positivamente a nuestros clientes, nuestros empleados, nuestros socios, nuestra comunidad y nuestro planeta. </p>\n                      <p>Para NUESTROS CLIENTES: ayudarlos a minimizar o eliminar el impacto que sus procesos puedan causar al medio ambiente, ayudándolos a hacerlos de una manera rentable. (sustentable?)</p>\n                      <p>Para NUESTROS EMPLEADOS: ante todo, cuidar su seguridad, buscando contribuir en su desarrollo personal y profesional, ofreciéndoles un entorno de trabajo justo, seguro y amigable. Y contagiarlos para que nuestro compromiso sustentable, sea también el suyo.</p>\n                      <p>Para NUESTROS SOCIOS, maximizar sus utilidades, cumpliendo siempre con los principios de responsabilidad bajo los cuales fue fundada la empresa.</p>\n                      <p>Para LA COMUNIDAD, hacer negocios de una manera ética, justa y responsable.</p>\n    </div>\n                <div id=\"Mision\" class=\"tab_content\">Hacer del cuidado del medio ambiente un negocio rentable para nuestros clientes y para nosotros.</div>\n                <div id=\"Vision\" class=\"tab_content\">\n                  <p>Ser una empresa líder en el mercado de ingeniería ambiental y conservación, que genere ingresos a través de la explotación sustentable de los recursos naturales y renovables, la prevención y el control de la contaminación.</p>\n                </div>\n                <div id=\"Historia\" class=\"tab_content\">\n     <p>Sustentabilis nace en el año 2001 bajo el nombre de Mir Ambiental con una fundada inquietud en detener y revertir el deterioro ambiental. Esto ayudó a estructurar las acciones de la empresa, comenzando con un cambio cultural y concluyendo con soluciones tangibles, es decir, soluciones integrales a favor del medio ambiente, como plantas de tratamiento de agua residual, y otros productos y servicios: cosechado de suelos con aguas pluviales, planes de manejo sustentable, estudios de impacto ambiental, techos verdes y energías limpias.</p>\n     <p>Sustentabilis opera con una filosofía basada en fundamentos sustentables, buscando un beneficio económico, social y ambiental, con tecnologías apropiadas y con procesos de mejora continua bajo principios de confiabilidad, calidad y eficiencia.</p>\n                </div>\n            </div>\n        </div>\n      </div>',1298608292,1),
	(5,3,'pages','<div class=\"ez-box\" id=\"fpimage\">\n {pyro:theme:image file=\"nosotrosimage.jpg\" }</div>\n<div class=\"ez-box\" id=\"fptitle\">\n {pyro:theme:image file=\"nosotrostitle.png\" alt=\"NOSOTROS SOMOS SUSTENTABILIS\"}</div>\n<div class=\"ez-wr\" id=\"fptext\">\n <div class=\"ez-box\">\n  <ul class=\"nostabs\">\n   <li>\n    <a href=\"#nuestros_compromisos\">Nuestros Compromisos</a></li>\n   <li>\n    <a href=\"#Mision\">Misi&oacute;n</a></li>\n   <li>\n    <a href=\"#Vision\">Visi&oacute;n</a></li>\n   <li>\n    <a href=\"#Historia\">Historia</a></li>\n  </ul>\n  <div class=\"tab_container\">\n   <div class=\"tab_content\" id=\"nuestros_compromisos\">\n    <p>\n     Nuestra promesa: estar comprometidos con el medio ambiente y nuestro entorno.&nbsp; Buscar que todas nuestras actividades impacten positivamente a nuestros clientes, nuestros empleados, nuestros socios, nuestra comunidad y nuestro planeta.</p>\n    <p>\n     Para NUESTROS CLIENTES: ayudarlos a minimizar o eliminar el impacto que sus procesos puedan causar al medio ambiente, ayud&aacute;ndolos a hacerlos de una manera rentable. (sustentable?)</p>\n    <p>\n     Para NUESTROS EMPLEADOS: ante todo, cuidar su seguridad, buscando contribuir en su desarrollo personal y profesional, ofreci&eacute;ndoles un entorno de trabajo justo, seguro y amigable. Y contagiarlos para que nuestro compromiso sustentable, sea tambi&eacute;n el suyo.</p>\n    <p>\n     Para NUESTROS SOCIOS, maximizar sus utilidades, cumpliendo siempre con los principios de responsabilidad bajo los cuales fue fundada la empresa.</p>\n    <p>\n     Para LA COMUNIDAD, hacer negocios de una manera &eacute;tica, justa y responsable.</p>\n   </div>\n   <div class=\"tab_content\" id=\"Mision\">\n    Hacer del cuidado del medio ambiente un negocio rentable para nuestros clientes y para nosotros.</div>\n   <div class=\"tab_content\" id=\"Vision\">\n    <p>\n     Ser una empresa l&iacute;der en el mercado de ingenier&iacute;a ambiental y conservaci&oacute;n, que genere ingresos a trav&eacute;s de la explotaci&oacute;n sustentable de los recursos naturales y renovables, la prevenci&oacute;n y el control de la contaminaci&oacute;n.</p>\n   </div>\n   <div class=\"tab_content\" id=\"Historia\">\n    <p>\n     Sustentabilis nace en el a&ntilde;o 2001 bajo el nombre de Mir Ambiental con una fundada inquietud en detener y revertir el deterioro ambiental. Esto ayud&oacute; a estructurar las acciones de la empresa, comenzando con un cambio cultural y concluyendo con soluciones tangibles, es decir, soluciones integrales a favor del medio ambiente, como plantas de tratamiento de agua residual, y otros productos y servicios: cosechado de suelos con aguas pluviales, planes de manejo sustentable, estudios de impacto ambiental, techos verdes y energ&iacute;as limpias.</p>\n    <p>\n     Sustentabilis opera con una filosof&iacute;a basada en fundamentos sustentables, buscando un beneficio econ&oacute;mico, social y ambiental, con tecnolog&iacute;as apropiadas y con procesos de mejora continua bajo principios de confiabilidad, calidad y eficiencia.</p>\n   </div>\n  </div>\n </div>\n</div>',1298608373,1),
	(6,3,'pages','<div class=\"ez-box\" id=\"fpimage\">\n {pyro:theme:image file=&quot;nosotrosimage.jpg&quot; }</div>\n<div class=\"ez-box\" id=\"fptitle\">\n {pyro:theme:image file=&quot;nosotrostitle.png&quot; alt=&quot;NOSOTROS SOMOS SUSTENTABILIS&quot;}</div>\n<div class=\"ez-wr\" id=\"fptext\">\n <div class=\"ez-box\">\n  <ul class=\"nostabs\">\n   <li>\n    <a href=\"#nuestros_compromisos\">Nuestros Compromisos</a></li>\n   <li>\n    <a href=\"#Mision\">Misi&oacute;n</a></li>\n   <li>\n    <a href=\"#Vision\">Visi&oacute;n</a></li>\n   <li>\n    <a href=\"#Historia\">Historia</a></li>\n  </ul>\n  <div class=\"tab_container\">\n   <div class=\"tab_content\" id=\"nuestros_compromisos\">\n    <p>\n     Nuestra promesa: estar comprometidos con el medio ambiente y nuestro entorno.&nbsp; Buscar que todas nuestras actividades impacten positivamente a nuestros clientes, nuestros empleados, nuestros socios, nuestra comunidad y nuestro planeta.</p>\n    <p>\n     Para NUESTROS CLIENTES: ayudarlos a minimizar o eliminar el impacto que sus procesos puedan causar al medio ambiente, ayud&aacute;ndolos a hacerlos de una manera rentable. (sustentable?)</p>\n    <p>\n     Para NUESTROS EMPLEADOS: ante todo, cuidar su seguridad, buscando contribuir en su desarrollo personal y profesional, ofreci&eacute;ndoles un entorno de trabajo justo, seguro y amigable. Y contagiarlos para que nuestro compromiso sustentable, sea tambi&eacute;n el suyo.</p>\n    <p>\n     Para NUESTROS SOCIOS, maximizar sus utilidades, cumpliendo siempre con los principios de responsabilidad bajo los cuales fue fundada la empresa.</p>\n    <p>\n     Para LA COMUNIDAD, hacer negocios de una manera &eacute;tica, justa y responsable.</p>\n   </div>\n   <div class=\"tab_content\" id=\"Mision\">\n    Hacer del cuidado del medio ambiente un negocio rentable para nuestros clientes y para nosotros.</div>\n   <div class=\"tab_content\" id=\"Vision\">\n    <p>\n     Ser una empresa l&iacute;der en el mercado de ingenier&iacute;a ambiental y conservaci&oacute;n, que genere ingresos a trav&eacute;s de la explotaci&oacute;n sustentable de los recursos naturales y renovables, la prevenci&oacute;n y el control de la contaminaci&oacute;n.</p>\n   </div>\n   <div class=\"tab_content\" id=\"Historia\">\n    <p>\n     Sustentabilis nace en el a&ntilde;o 2001 bajo el nombre de Mir Ambiental con una fundada inquietud en detener y revertir el deterioro ambiental. Esto ayud&oacute; a estructurar las acciones de la empresa, comenzando con un cambio cultural y concluyendo con soluciones tangibles, es decir, soluciones integrales a favor del medio ambiente, como plantas de tratamiento de agua residual, y otros productos y servicios: cosechado de suelos con aguas pluviales, planes de manejo sustentable, estudios de impacto ambiental, techos verdes y energ&iacute;as limpias.</p>\n    <p>\n     Sustentabilis opera con una filosof&iacute;a basada en fundamentos sustentables, buscando un beneficio econ&oacute;mico, social y ambiental, con tecnolog&iacute;as apropiadas y con procesos de mejora continua bajo principios de confiabilidad, calidad y eficiencia.</p>\n   </div>\n  </div>\n </div>\n</div>',1298608660,1),
	(7,4,'pages','<div class=\"ez-box\" id=\"fpimage\">\n        {pyro:theme:image file=\"fpimage.jpg\" }\n      </div>\n      <div class=\"ez-box\" id=\"fptitle\">{pyro:theme:image file=\"fptitle.png\" alt=\"ESTO ES SUSTENTABILIS\"}</div>\n        <div class=\"ez-wr\" id=\"fptext\">\n          <div class=\"ez-fl\">\n            <div class=\"ez-box\"><p>En <span class=\"greentext\">SUSTENTABILIS</span>, el cuidado del medio ambiente es <span class=\"greentext\">nuestra forma de vida</span> y nuestro negocio. Sabemos que por la naturaleza de algunas operaciones, el cuidado del medio ambiente puede ser <span class=\"greentext\">un problema complejo.</span></p></div>\n          </div>\n          <div class=\"ez-fl\">\n            <div class=\"ez-box\"><p>Por eso nos hemos propuesto ser una empresa que <span class=\"greentext\">solucione de manera integral</span> las necesidades ambientales del País.</p></div>\n          </div>\n          <div class=\"ez-last ez-oh\">\n            <div class=\"ez-box\">\n              <p>Nuestra <span class=\"greentext\">misión</span> es hacer del cuidado del <span class=\"greentext\">medio</span> ambiente un negocio rentable para nuestros <span class=\"greentext\">clientes</span> y para <span class=\"greentext\">nosotros</span>.</p><br /></div>\n          </div>\n        </div>\n      <div class=\"ez-box\" id=\"divisions\">\n        <div class=\"myJac\">\n            <ul>\n                <li><a href=\"#\" class=\"divthumb\">{pyro:theme:image file=\"divagua.jpg\" alt=\"División Agua\" }</a></li>\n                <li><a href=\"#\" class=\"divthumb\">{pyro:theme:image file=\"divaire.jpg\" alt=\"División Aire\" }</a></li>\n                <li><a href=\"#\" class=\"divthumb\">{pyro:theme:image file=\"divenergia.jpg\" }</a></li>\n            </ul>\n        </div>',1298609574,1),
	(8,5,'pages','<p>\n x</p>',1298612040,1);

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
	(4);

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
  PRIMARY KEY (`slug`),
  UNIQUE KEY `unique - slug` (`slug`),
  KEY `index - slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Stores all sorts of settings for the admin to change';

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`slug`,`title`,`description`,`type`,`default`,`value`,`options`,`is_required`,`is_gui`,`module`)
VALUES
	('activation_email','Activation Email','Send out an e-mail when a user signs up with an activation link. Disable this to let only admins activate accounts.','radio','1','1','1=Enabled|0=Disabled',0,1,''),
	('akismet_api_key','Akismet API Key','Akismet is a spam-blocker from the WordPress team. It keeps spam under control without forcing users to get past human-checking CAPTCHA forms.','text','','','',0,1,'integration'),
	('comment_order','Comment Order','Sort order in which to display comments.','select','ASC','ASC','ASC=Oldest First|DESC=Newest First',1,1,'comments'),
	('contact_email','Contact E-mail','All e-mails from users, guests and the site will go to this e-mail address.','text','dev@palmea.net','dev@palmea.net','',1,1,''),
	('currency','Currency','The currency symbol for use on products, services, etc.','text','&pound;','$','',1,1,''),
	('dashboard_rss','Dashboard RSS Feed','Link to an RSS feed that will be displayed on the dashboard.','text','http://feeds.feedburner.com/pyrocms-installed','http://feeds.feedburner.com/pyrocms-installed','',0,1,''),
	('dashboard_rss_count','Dashboard RSS Items','How many RSS items would you like to display on the dashboard ? ','text','5','5','',1,1,''),
	('date_format','Date Format','How should dates be displayed accross the website and control panel? Using PHP date format.','text','Y-m-d','d-m-Y','',1,1,''),
	('default_theme','Default Theme','Select the theme you want users to see by default.','','default','sustentabilis','get_themes',1,0,''),
	('enable_profiles','Enable profiles','Allow users to add and edit profiles.','radio','1','0','1=Enabled|0=Disabled',1,1,'users'),
	('frontend_enabled','Site Status','Use this option to the user-facing part of the site on or off. Useful when you want to take the site down for maintenence','radio','1','1','1=Open|0=Closed',1,1,''),
	('ga_email','Google Analytic E-mail','E-mail address used for Google Analytics, we need this to show the graph on the dashboard.','text','','','',0,1,'integration'),
	('ga_password','Google Analytic Password','Google Analytics password. This is also needed this to show the graph on the dashboard.','password','','','',0,1,'integration'),
	('ga_profile','Google Analytic Profile ID','Profile ID for this website in Google Analytics.','text','','','',0,1,'integration'),
	('ga_tracking','Google Tracking Code','Enter your Google Analytic Tracking Code to activate Google Analytics view data capturing. E.g: UA-19483569-6','text','','','',0,1,'integration'),
	('mail_protocol','Mail Protocol','Select desired email protocol.','select','mail','mail','mail=Mail|sendmail=Sendmail|smtp=SMTP',1,1,''),
	('mail_sendmail_path','Sendmail Path','Path to server sendmail binary.','text','','','',0,1,''),
	('mail_smtp_host','SMTP Host Name','The host name of your smtp server.','text','','','',0,1,''),
	('mail_smtp_pass','SMTP Password','SMTP password.','text','','','',0,1,''),
	('mail_smtp_port','SMTP Port','SMTP port number.','text','','','',0,1,''),
	('mail_smtp_user','SMTP User Name','SMTP user name.','text','','','',0,1,''),
	('meta_topic','Meta Topic','Two or three words describing this type of company/website.','text','Content Management','Content Management','',0,1,''),
	('moderate_comments','Moderate Comments','Force comments to be approved before they appear on the site.','select','0','1','1=Enabled|0=Disabled',0,1,'comments'),
	('records_per_page','Records Per Page','How many records should we show per page in the admin section?','select','25','25','10=10|25=25|50=50|100=100',1,1,''),
	('require_lastname','Require last names?','For some situations, a last name may not be required. Do you want to force users to enter one or not?','radio','1','1','1=Required|0=Optional',1,1,''),
	('rss_feed_items','Feed item count','How many items should we show in RSS/news feeds?','select','25','25','10=10|25=25|50=50|100=100',1,1,''),
	('server_email','Server E-mail','All e-mails to users will come from this e-mail address.','text','admin@localhost','admin@localhost','',1,1,''),
	('site_name','Site Name','The name of the website for page titles and for use around the site.','text','Un-named Website','Sustentabilis','',1,1,''),
	('site_slogan','Site Slogan','The slogan of the website for page titles and for use around the site.','text','Add your slogan here','','',0,1,''),
	('twitter_cache','Cache time','How many minutes should your Tweets be stored?','text','300','300','',0,1,'twitter'),
	('twitter_consumer_key','Consumer Key','Twitter consumer key.','text','','','',0,1,'twitter'),
	('twitter_consumer_key_secret','Consumer Key Secret','Twitter consumer key secret.','text','','','',0,1,'twitter'),
	('twitter_feed_count','Feed Count','How many tweets should be returned to the Twitter feed block?','text','5','5','',0,1,'twitter'),
	('twitter_news','Twitter &amp; News integration.','Would you like to post links to new news articles on Twitter?','radio','0','0','1=Enabled|0=Disabled',0,1,'twitter'),
	('twitter_username','Username','Twitter username.','text','','','',0,1,'twitter'),
	('unavailable_message','Unavailable Message','When the site is turned off or there is a major problem, this message will show to users.','textarea','Sorry, this website is currently unavailable.','Sorry, this website is currently unavailable.','',0,1,''),
	('version','Version','','text','1.0','1.0.3','',0,0,'');

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
	(1,'dev@palmea.net','36a00bba9d95814a2bbd6f64d29373a793a59287','228cb',1,'',1,'',1298447728,1298447805,'admin',NULL,NULL);

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
	(1,'unsorted','Unsorted');

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
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `author` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `website` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `version` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` (`id`,`slug`,`title`,`description`,`author`,`website`,`version`)
VALUES
	(1,'google_maps','Google Maps','Display Google Maps on your site','Gregory Athons','http://www.gregathons.com',1),
	(2,'twitter_feed','Twitter Feed','Display Twitter feeds on your websites.','Phil Sturgeon','http://philsturgeon.co.uk/',1),
	(3,'html','HTML','Create blocks of custom HTML.','Phil Sturgeon','http://philsturgeon.co.uk/',1),
	(4,'login','Login','Display a simple login form anywhere.','Phil Sturgeon','http://philsturgeon.co.uk/',1),
	(5,'navigation','Navigation','Display a navigation group with a widget.','Phil Sturgeon','http://philsturgeon.co.uk/',1),
	(6,'rss_feed','RSS Feed','Display parsed RSS feeds on your websites.','Phil Sturgeon','http://philsturgeon.co.uk/',1),
	(7,'social_bookmark','Social Bookmark','Configurable social bookmark links from AddThis.','Phil Sturgeon','http://philsturgeon.co.uk/',1),
	(8,'archive','Archive','Display a list of old months with links to articles in those months.','Phil Sturgeon','http://philsturgeon.co.uk/',1),
	(9,'latest_news','Latest news','Display latest news articles with a widget.','Erik Berman','http://www.nukleo.fr',1),
	(10,'news_categories','News Categories','Show a list of news categories.','Stephen Cozart','http://github.com/clip/',1);

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;





/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
