-- *********************************************
-- * SQL MySQL generation
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2
-- * Generator date: Sep 14 2021
-- * Generation date: Tue May 27 18:07:35 2025
-- *********************************************


-- Database Section
-- ________________

create database brand_di_moda;
use brand_di_moda;


-- Tables Section
-- _____________

create table ABITO (
     codice_abito int not null AUTO_INCREMENT,
     nome varchar(100) not null,
     descrizione_ varchar(1000) not null,
     codice_lavoro int not null,
     constraint ID_ABITO_ID primary key (codice_abito));

create table composto (
     codice_materiale int not null,
     codice_abito int not null,
     quantita_usata int not null,
     constraint ID_composto_ID primary key (codice_abito, codice_materiale));

create table contiene (
     Div_numero_immobile int not null,
     Div_numero int not null,
     numero int not null,
     codice_materiale int not null,
     quantita int not null,
     constraint ID_contiene_ID primary key (Div_numero_immobile, Div_numero, numero, codice_materiale));

create table CONTRATTO_PERSONALE (
     codice_tipologia_contratto int not null AUTO_INCREMENT,
     descrizione varchar(100) not null,
     stipendio_mensile int not null,
     constraint ID_CONTRATTO_PERSONALE_ID primary key (codice_tipologia_contratto));

create table EVENTO (
     codice_evento int not null AUTO_INCREMENT,
     nome varchar(100) not null,
     data_inizio_evento DATETIME not null,
     data_fine_evento DATETIME not null,
     descrizione varchar(1000) not null,
     partecipanti int not null,
     numero_immobile int,
     codice_lavoro int not null,
     e_nome varchar(100) not null,
     constraint ID_EVENTO_ID primary key (codice_evento));

create table GRUPPO_DI_LAVORO (
     codice_lavoro int not null AUTO_INCREMENT,
     data_inizio_lavoro DATETIME not null,
     descrizione varchar(1000) not null,
     tipo_gruppo char(10) not null,
     data_fine_lavoro DATETIME,
     constraint ID_GRUPPO_DI_LAVORO_ID primary key (codice_lavoro));

create table IMMOBILE (
     numero_immobile int not null,
     numero_telefono char(10) not null,
     indirizzo___via varchar(100),
     indirizzo___nuemro_civico int,
     constraint ID_IMMOBILE_ID primary key (numero_immobile));

create table MATERIALE (
     nome varchar(100) not null,
     descrizione varchar(1000) not null,
     codice_materiale int not null AUTO_INCREMENT,
     constraint ID_MATERIALE_ID primary key (codice_materiale));

create table MODELLA (
     CF char(16) not null,
     nome varchar(100) not null,
     cognome varchar(100) not null,
     telefono int not null,
     residenza___via varchar(100) not null,
     residenza___numero_civico int not null,
     constraint ID_MODELLA_ID primary key (CF));

create table OCCUPAZIONE (
     codice_tipologia_contratto int not null,
     CF char(16) not null,
     inizio_validita DATETIME not null,
     fine_validita DATETIME,
     constraint ID_OCCUPAZIONE_ID primary key (codice_tipologia_contratto, CF, inizio_validita));

create table OCCUPAZIONE_PASSATA (
     codice_lavoro int not null,
     inizio_lavoro DATETIME not null,
     CF char(16) not null,
     fine_lavoro DATETIME not null,
     constraint ID_OCCUPAZIONE_PASSATA_ID primary key (codice_lavoro, inizio_lavoro),
     constraint SID_OCCUPAZIONE_PASSATA_ID unique (CF, inizio_lavoro));

create table PARTECIPANTE (
     CF char(16) not null,
     nome varchar(100) not null,
     cognome varchar(100) not null,
     telefono int not null,
     residenza___via varchar(100) not null,
     residenza___numero_civico int not null,
     constraint ID_PARTECIPANTE_ID primary key (CF));

create table partecipanti_turno (
     CF char(16) not null,
     data_inizio DATETIME not null,
     codice_lavoro int not null,
     constraint IDpartecipanti_turno primary key (CF, data_inizio, codice_lavoro));

create table partecipazione (
     codice_evento int not null,
     CF char(16) not null,
     costo int not null,
     codice_biglietto int not null auto_increment,
     constraint ID_partecipazione_ID primary key (CF, codice_evento),
     constraint SID_partecipazione_ID unique (codice_biglietto));

create table PERSONALE (
     codice_aziendale int not null AUTO_INCREMENT,
     data_assunzione DATETIME not null,
     CF char(16) not null,
     nome varchar(100) not null,
     cognome varchar(100) not null,
     telefono int not null,
     residenza___via varchar(100) not null,
     residenza___numero_civico int not null,
     tipo_personale varchar(20) not null,
     occupazione_presente_inizio date,
     codice_lavoro int,
     numero_immobile int,
     amministratore_sistema boolean not null,
     password_applicativo char(5) not null,
     constraint SID_PERSONALE_ID unique (codice_aziendale),
     constraint ID_PERSONALE_ID primary key (CF));

create table PIANO (
     numero_immobile int not null,
     numero int not null,
     constraint ID_PIANO_ID primary key (numero_immobile, numero));

create table relativo (
     codice_contrattuale int not null,
     codice_materiale int not null,
     quantita int not null,
     constraint ID_relativo_ID primary key (codice_contrattuale, codice_materiale));

create table sottoscrive_spesa_abito (
     codice_contrattuale int not null,
     codice_abito int not null,
     constraint ID_sottoscrive_spesa_abito_ID primary key (codice_contrattuale, codice_abito));

create table sottoscrive_spesa_evento (
     codice_contrattuale int not null,
     codice_evento int not null,
     constraint ID_sottoscrive_spesa_evento_ID primary key (codice_evento, codice_contrattuale));

create table SPESA (
     codice_contrattuale int not null,
     data DATETIME not null,
     costo int not null,
     indirizzo___via varchar(100),
     indirizzo___nuemro_civico int,
     codice_lavoro int not null,
     CF char(16),
     constraint ID_SPESA_ID primary key (codice_contrattuale));

create table STANZA (
     Div_numero_immobile int not null,
     Div_numero int not null,
     numero int not null,
     partecipanti_massimi int not null,
     tipo_stanza char(10) not null,
     capienza int,
     codice_lavoro int,
     constraint ID_STANZA_ID primary key (Div_numero_immobile, Div_numero, numero));

create table tariffa (
     nome varchar(100) not null,
     CF char(16) not null,
     prezzo int not null,
     constraint ID_tariffa_ID primary key (nome, CF));

create table TIPOLOGIA_EVENTO (
     nome varchar(100) not null,
     descrizione varchar(100) not null,
     constraint ID_TIPOLOGIA_EVENTO_ID primary key (nome));

create table TURNO_della_MODELLA_nella_SFILATA (
     codice_evento int not null,
     codice_entrata_sfilata int not null,
     codice_abito int not null,
     codice_contrattuale int not null,
     constraint ID_TURNO_della_MODELLA_nella_SFILATA_ID primary key (codice_evento, codice_entrata_sfilata));

create table TURNO_di_LAVORO (
     data_inizio DATETIME not null,
     data_fine DATETIME not null,
     descrizione varchar(100) not null,
     cancellato bool not null,
     Div_numero_immobile int not null,
     Div_numero int not null,
     numero int not null,
     codice_lavoro int not null,
     constraint IDTURNO_di_LAVORO primary key (data_inizio, codice_lavoro));


-- Constraints Section
-- ___________________

alter table ABITO add constraint REF_ABITO_GRUPP_FK
     foreign key (codice_lavoro)
     references GRUPPO_DI_LAVORO (codice_lavoro);

alter table composto add constraint REF_compo_ABITO
     foreign key (codice_abito)
     references ABITO (codice_abito);

alter table composto add constraint REF_compo_MATER_FK
     foreign key (codice_materiale)
     references MATERIALE (codice_materiale);

alter table contiene add constraint REF_conti_MATER_FK
     foreign key (codice_materiale)
     references MATERIALE (codice_materiale);

alter table contiene add constraint REF_conti_STANZ
     foreign key (Div_numero_immobile, Div_numero, numero)
     references STANZA (Div_numero_immobile, Div_numero, numero);

alter table EVENTO add constraint REF_EVENT_IMMOB_FK
     foreign key (numero_immobile)
     references IMMOBILE (numero_immobile);

alter table EVENTO add constraint REF_EVENT_GRUPP_FK
     foreign key (codice_lavoro)
     references GRUPPO_DI_LAVORO (codice_lavoro);

alter table EVENTO add constraint REF_EVENT_TIPOL_FK
     foreign key (e_nome)
     references TIPOLOGIA_EVENTO (nome);

alter table OCCUPAZIONE add constraint EQU_OCCUP_PERSO_FK
     foreign key (CF)
     references PERSONALE (CF);

alter table OCCUPAZIONE add constraint REF_OCCUP_CONTR
     foreign key (codice_tipologia_contratto)
     references CONTRATTO_PERSONALE (codice_tipologia_contratto);

alter table OCCUPAZIONE_PASSATA add constraint REF_OCCUP_PERSO
     foreign key (CF)
     references PERSONALE (CF);

alter table OCCUPAZIONE_PASSATA add constraint REF_OCCUP_GRUPP
     foreign key (codice_lavoro)
     references GRUPPO_DI_LAVORO (codice_lavoro);

alter table partecipanti_turno add constraint REF_parte_PERSO
     foreign key (CF)
     references PERSONALE (CF);

alter table partecipanti_turno add constraint FKR
     foreign key (data_inizio, codice_lavoro)
     references TURNO_di_LAVORO (data_inizio, codice_lavoro);

alter table partecipazione add constraint REF_parte_PARTE
     foreign key (CF)
     references PARTECIPANTE (CF);

alter table partecipazione add constraint REF_parte_EVENT_FK
     foreign key (codice_evento)
     references EVENTO (codice_evento);

alter table PERSONALE add constraint REF_PERSO_GRUPP_FK
     foreign key (codice_lavoro)
     references GRUPPO_DI_LAVORO (codice_lavoro);

alter table PERSONALE add constraint REF_PERSO_IMMOB_FK
     foreign key (numero_immobile)
     references IMMOBILE (numero_immobile);

alter table PIANO add constraint REF_PIANO_IMMOB
     foreign key (numero_immobile)
     references IMMOBILE (numero_immobile);

alter table relativo add constraint REF_relat_MATER_FK
     foreign key (codice_materiale)
     references MATERIALE (codice_materiale);

alter table relativo add constraint REF_relat_SPESA
     foreign key (codice_contrattuale)
     references SPESA (codice_contrattuale);

alter table sottoscrive_spesa_abito add constraint REF_sotto_ABITO_FK
     foreign key (codice_abito)
     references ABITO (codice_abito);

alter table sottoscrive_spesa_abito add constraint REF_sotto_SPESA_1
     foreign key (codice_contrattuale)
     references SPESA (codice_contrattuale);

alter table sottoscrive_spesa_evento add constraint REF_sotto_EVENT
     foreign key (codice_evento)
     references EVENTO (codice_evento);

alter table sottoscrive_spesa_evento add constraint REF_sotto_SPESA_FK
     foreign key (codice_contrattuale)
     references SPESA (codice_contrattuale);

alter table SPESA add constraint REF_SPESA_GRUPP_FK
     foreign key (codice_lavoro)
     references GRUPPO_DI_LAVORO (codice_lavoro);

alter table SPESA add constraint REF_SPESA_MODEL_FK
     foreign key (CF)
     references MODELLA (CF);

alter table STANZA add constraint REF_STANZ_PIANO
     foreign key (Div_numero_immobile, Div_numero)
     references PIANO (numero_immobile, numero);

alter table STANZA add constraint REF_STANZ_GRUPP_FK
     foreign key (codice_lavoro)
     references GRUPPO_DI_LAVORO (codice_lavoro);

alter table tariffa add constraint REF_tarif_MODEL_FK
     foreign key (CF)
     references MODELLA (CF);

alter table tariffa add constraint REF_tarif_TIPOL
     foreign key (nome)
     references TIPOLOGIA_EVENTO (nome);

alter table TURNO_della_MODELLA_nella_SFILATA add constraint REF_TURNO_EVENT
     foreign key (codice_evento)
     references EVENTO (codice_evento);

alter table TURNO_della_MODELLA_nella_SFILATA add constraint REF_TURNO_ABITO_FK
     foreign key (codice_abito)
     references ABITO (codice_abito);

alter table TURNO_della_MODELLA_nella_SFILATA add constraint REF_TURNO_SPESA_FK
     foreign key (codice_contrattuale)
     references SPESA (codice_contrattuale);

alter table TURNO_di_LAVORO add constraint REF_TURNO_STANZ_FK
     foreign key (Div_numero_immobile, Div_numero, numero)
     references STANZA (Div_numero_immobile, Div_numero, numero);

alter table TURNO_di_LAVORO add constraint REF_TURNO_GRUPP_FK
     foreign key (codice_lavoro)
     references GRUPPO_DI_LAVORO (codice_lavoro);


-- Index Section
-- _____________

create unique index ID_ABITO_IND
     on ABITO (codice_abito);

create index REF_ABITO_GRUPP_IND
     on ABITO (codice_lavoro);

create unique index ID_composto_IND
     on composto (codice_abito, codice_materiale);

create index REF_compo_MATER_IND
     on composto (codice_materiale);

create unique index ID_contiene_IND
     on contiene (Div_numero_immobile, Div_numero, numero, codice_materiale);

create index REF_conti_MATER_IND
     on contiene (codice_materiale);

create unique index ID_CONTRATTO_PERSONALE_IND
     on CONTRATTO_PERSONALE (codice_tipologia_contratto);

create unique index ID_EVENTO_IND
     on EVENTO (codice_evento);

create index REF_EVENT_IMMOB_IND
     on EVENTO (numero_immobile);

create index REF_EVENT_GRUPP_IND
     on EVENTO (codice_lavoro);

create index REF_EVENT_TIPOL_IND
     on EVENTO (e_nome);

create unique index ID_GRUPPO_DI_LAVORO_IND
     on GRUPPO_DI_LAVORO (codice_lavoro);

create unique index ID_IMMOBILE_IND
     on IMMOBILE (numero_immobile);

create unique index ID_MATERIALE_IND
     on MATERIALE (codice_materiale);

create unique index ID_MODELLA_IND
     on MODELLA (CF);

create unique index ID_OCCUPAZIONE_IND
     on OCCUPAZIONE (codice_tipologia_contratto, CF, inizio_validita);

create index EQU_OCCUP_PERSO_IND
     on OCCUPAZIONE (CF);

create unique index ID_OCCUPAZIONE_PASSATA_IND
     on OCCUPAZIONE_PASSATA (codice_lavoro, inizio_lavoro);

create unique index SID_OCCUPAZIONE_PASSATA_IND
     on OCCUPAZIONE_PASSATA (CF, inizio_lavoro);

create unique index ID_PARTECIPANTE_IND
     on PARTECIPANTE (CF);

create unique index ID_partecipazione_IND
     on partecipazione (CF, codice_evento);

create index REF_parte_EVENT_IND
     on partecipazione (codice_evento);

create unique index SID_PERSONALE_IND
     on PERSONALE (codice_aziendale);

create unique index ID_PERSONALE_IND
     on PERSONALE (CF);

create index REF_PERSO_GRUPP_IND
     on PERSONALE (codice_lavoro);

create index REF_PERSO_IMMOB_IND
     on PERSONALE (numero_immobile);

create unique index ID_PIANO_IND
     on PIANO (numero_immobile, numero);

create unique index ID_relativo_IND
     on relativo (codice_contrattuale, codice_materiale);

create index REF_relat_MATER_IND
     on relativo (codice_materiale);

create unique index ID_sottoscrive_spesa_abito_IND
     on sottoscrive_spesa_abito (codice_contrattuale, codice_abito);

create index REF_sotto_ABITO_IND
     on sottoscrive_spesa_abito (codice_abito);

create unique index ID_sottoscrive_spesa_evento_IND
     on sottoscrive_spesa_evento (codice_evento, codice_contrattuale);

create index REF_sotto_SPESA_IND
     on sottoscrive_spesa_evento (codice_contrattuale);

create unique index ID_SPESA_IND
     on SPESA (codice_contrattuale);

create index REF_SPESA_GRUPP_IND
     on SPESA (codice_lavoro);

create index REF_SPESA_MODEL_IND
     on SPESA (CF);

create unique index ID_STANZA_IND
     on STANZA (Div_numero_immobile, Div_numero, numero);

create index REF_STANZ_GRUPP_IND
     on STANZA (codice_lavoro);

create unique index ID_tariffa_IND
     on tariffa (nome, CF);

create index REF_tarif_MODEL_IND
     on tariffa (CF);

create unique index ID_TIPOLOGIA_EVENTO_IND
     on TIPOLOGIA_EVENTO (nome);

create unique index ID_TURNO_della_MODELLA_nella_SFILATA_IND
     on TURNO_della_MODELLA_nella_SFILATA (codice_evento, codice_entrata_sfilata);

create index REF_TURNO_ABITO_IND
     on TURNO_della_MODELLA_nella_SFILATA (codice_abito);

create index REF_TURNO_SPESA_IND
     on TURNO_della_MODELLA_nella_SFILATA (codice_contrattuale);

create index REF_TURNO_STANZ_IND
     on TURNO_di_LAVORO (Div_numero_immobile, Div_numero, numero);

create index REF_TURNO_GRUPP_IND
     on TURNO_di_LAVORO (codice_lavoro);

-- Data Section --
-- ____________ --

INSERT INTO IMMOBILE (numero_immobile, numero_telefono, indirizzo___via, indirizzo___nuemro_civico) VALUES
(1, '0312458440', 'Strada Benedetta', 162),
(2, '0314927555', 'Via Pellegrino', 80),
(3, '0328896602', 'Via Oreste', 39);

INSERT INTO GRUPPO_DI_LAVORO (data_inizio_lavoro, descrizione, tipo_gruppo, data_fine_lavoro) VALUES
('2025-06-01 09:00:00', 'Gruppo Comunicazione Digitale', 'admin', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Visual Design', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Contenuti Editoriali', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Podcast & Audio', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Video Produzione', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Social Media', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Ufficio Stampa', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo UX & UI Design', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Web Development', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Data Analysis', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Storytelling', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Traduzioni & Localizzazione', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Community Engagement', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Formazione & Didattica', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Ricerca & Innovazione', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Archiviazione Digitale', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo CRM & Automazioni', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Marketing Strategico', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo SEO & SEM', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Merchandising', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Gamification', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Motion Graphics', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Sviluppo App', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Knowledge Management', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Esperienza Utente', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Brand Identity', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Progettazione Editoriale', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Crowdfunding', 'prodotto', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Accoglienza Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Logistica Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Coordinamento Volontari Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Segreteria Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Relazioni Istituzionali Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Sicurezza Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Gestione Ticketing Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Assistenza Tecnica Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Supporto Speaker Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Documentazione Eventi Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Catering & Hospitality Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Registrazioni & Accrediti Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Scenografia & Allestimenti Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Programmazione Eventi Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Partner & Sponsor Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Backstage Management Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Comunicazione Live Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Supporto Workshop Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Coordinamento Palco Evento', 'evento', '2025-09-01 18:00:00'),
('2025-06-01 09:00:00', 'Gruppo Feedback & Valutazione Evento', 'evento', '2025-09-01 18:00:00');

INSERT INTO MATERIALE (nome, descrizione) VALUES
('Acciaio', 'Materiale acciaio di alta qualità'),
('Legno', 'Materiale legno utilizzato per costruzioni'),
('Vetro', 'Materiale vetro trasparente e resistente'),
('Plastica', 'Materiale plastica versatile e leggero'),
('Alluminio', 'Materiale alluminio leggero e resistente alla corrosione'),
('Rame', 'Materiale rame con ottima conducibilità elettrica'),
('Fibra di carbonio', 'Materiale fibra di carbonio resistente e leggero'),
('Cemento', 'Materiale cemento utilizzato in edilizia'),
('Lana di vetro', 'Materiale lana di vetro per isolamento termico'),
('Polistirene', 'Materiale polistirene espanso per isolamento'),
('Marmo', 'Materiale marmo utilizzato per rivestimenti e decorazioni'),
('Carta', 'Materiale carta per uso vario'),
('Tela', 'Materiale tela resistente per abbigliamento'),
('Cotone', 'Materiale cotone naturale per tessuti'),
('Gomma', 'Materiale gomma elastica e resistente'),
('Zinco', 'Materiale zinco per protezione da corrosione'),
('Ottone', 'Materiale ottone legato di rame e zinco'),
('Ceramica', 'Materiale ceramica duro e resistente al calore'),
('Acciaio inox', 'Materiale acciaio inox resistente alla ruggine'),
('Poliuretano', 'Materiale poliuretano versatile per imbottiture'),
('Nylon', 'Materiale nylon resistente e leggero'),
('Fibra di vetro', 'Materiale fibra di vetro usato per rinforzi'),
('Tela cerata', 'Materiale tela cerata impermeabile'),
('Tessuto sintetico', 'Materiale tessuto sintetico resistente'),
('Ferro', 'Materiale ferro robusto e durevole'),
('Bronzo', 'Materiale bronzo utilizzato per sculture'),
('PVC', 'Materiale PVC versatile per tubazioni'),
('Schiuma', 'Materiale schiuma utilizzato per imbottiture'),
('Sughero', 'Materiale sughero leggero e isolante'),
('Tessuto di lino', 'Materiale tessuto di lino naturale'),
('Silicone', 'Materiale silicone flessibile e resistente'),
('Calcestruzzo', 'Materiale calcestruzzo per strutture edili'),
('Pietra', 'Materiale pietra naturale per costruzioni'),
('Juta', 'Materiale juta resistente e biodegradabile'),
('Lana', 'Materiale lana calda e naturale'),
('Polietilene', 'Materiale polietilene usato in imballaggi'),
('Polipropilene', 'Materiale polipropilene resistente all’acqua'),
('Velluto', 'Materiale velluto morbido per arredamento'),
('Sabbia', 'Materiale sabbia naturale usato in edilizia'),
('Ceramica smaltata', 'Materiale ceramica smaltata decorativa'),
('Carta riciclata', 'Materiale carta riciclata ecologica'),
('Pelle', 'Materiale pelle naturale per abbigliamento'),
('Lana merino', 'Materiale lana merino fine e pregiata'),
('Fibra naturale', 'Materiale fibra naturale per tessuti'),
('Carbonio', 'Materiale carbonio ad alta resistenza'),
('Lana acrilica', 'Materiale lana acrilica sintetica'),
('Poliammide', 'Materiale poliammide resistente all’usura'),
('Gesso', 'Materiale gesso per uso artistico e edilizio'),
('Lattice', 'Materiale lattice elastico'),
('Vetro temperato', 'Materiale vetro temperato resistente agli urti'),
('Tessuto di seta', 'Materiale tessuto di seta pregiato'),
('Acrilico', 'Materiale acrilico trasparente e resistente'),
('Tessuto impermeabile', 'Materiale tessuto impermeabile per esterni'),
('Fibra ottica', 'Materiale fibra ottica per trasmissioni dati'),
('Rattan', 'Materiale rattan flessibile per mobili'),
('Canapa', 'Materiale canapa resistente e ecologica'),
('Tessuto di poliestere', 'Materiale tessuto di poliestere resistente'),
('Legno di pino', 'Materiale legno di pino robusto'),
('Legno di quercia', 'Materiale legno di quercia durevole'),
('Carta kraft', 'Materiale carta kraft resistente'),
('Feltro', 'Materiale feltro spesso e isolante'),
('Schiuma poliuretanica', 'Materiale schiuma poliuretanica per imbottiture'),
('Gesso idraulico', 'Materiale gesso idraulico per costruzioni'),
('Tessuto jacquard', 'Materiale tessuto jacquard decorativo'),
('Vetro acrilico', 'Materiale vetro acrilico trasparente'),
('Carbonio composito', 'Materiale carbonio composito ad alta resistenza'),
('Ferro zincato', 'Materiale ferro zincato anti corrosione'),
('Legno compensato', 'Materiale legno compensato per mobili'),
('Tessuto di lana', 'Materiale tessuto di lana caldo'),
('Resina epossidica', 'Materiale resina epossidica resistente'),
('Tessuto non tessuto', 'Materiale tessuto non tessuto per filtri'),
('Schiuma di poliuretano', 'Materiale schiuma di poliuretano espanso'),
('Fibra di lino', 'Materiale fibra di lino naturale'),
('Carta patinata', 'Materiale carta patinata per stampa'),
('Legno di ciliegio', 'Materiale legno di ciliegio pregiato'),
('Carta pergamena', 'Materiale carta pergamena per documenti'),
('Policarbonato', 'Materiale policarbonato resistente e trasparente'),
('Lana di alpaca', 'Materiale lana di alpaca morbida e calda'),
('Tessuto denim', 'Materiale tessuto denim resistente'),
('Fibra di juta', 'Materiale fibra di juta naturale'),
('Legno di abete', 'Materiale legno di abete leggero'),
('Carta ricoperta', 'Materiale carta ricoperta per imballaggi'),
('Tessuto felpato', 'Materiale tessuto felpato morbido'),
('Lana vergine', 'Materiale lana vergine naturale'),
('Tessuto stretch', 'Materiale tessuto stretch elastico'),
('Cuoio', 'Materiale cuoio resistente per abbigliamento'),
('Carta da parati', 'Materiale carta da parati decorativa'),
('Legno di betulla', 'Materiale legno di betulla chiaro'),
('Fibra sintetica', 'Materiale fibra sintetica resistente'),
('Tessuto a maglia', 'Materiale tessuto a maglia elastico'),
('Pelle sintetica', 'Materiale pelle sintetica ecologica'),
('Tessuto di lino grezzo', 'Materiale tessuto di lino grezzo'),
('Polietilene ad alta densità', 'Materiale polietilene ad alta densità'),
('Legno massello', 'Materiale legno massello robusto'),
('Carta ondulata', 'Materiale carta ondulata per imballaggi'),
('Tessuto a rete', 'Materiale tessuto a rete traspirante'),
('Schiuma melamminica', 'Materiale schiuma melamminica isolante'),
('Fibra di vetro intrecciata', 'Materiale fibra di vetro intrecciata resistente'),
('Pelle scamosciata', 'Materiale pelle scamosciata morbida'),
('Carta lucida', 'Materiale carta lucida per stampa'),
('Tessuto sintetico traspirante', 'Materiale tessuto sintetico traspirante'),
('Legno di noce', 'Materiale legno di noce pregiato'),
('Tessuto in microfibra', 'Materiale tessuto in microfibra morbido'),
('Fibra di seta', 'Materiale fibra di seta naturale'),
('Carta kraft riciclata', 'Materiale carta kraft riciclata ecologica'),
('Legno di teak', 'Materiale legno di teak resistente'),
('Pelle conciata', 'Materiale pelle conciata naturale'),
('Tessuto jacquard di seta', 'Materiale tessuto jacquard di seta'),
('Carta bianca', 'Materiale carta bianca per uso vario'),
('Fibra di poliestere', 'Materiale fibra di poliestere resistente'),
('Legno lamellare', 'Materiale legno lamellare per costruzioni'),
('Tessuto a spina di pesce', 'Materiale tessuto a spina di pesce decorativo'),
('Carta pergamena riciclata', 'Materiale carta pergamena riciclata'),
('Fibra acrilica', 'Materiale fibra acrilica sintetica'),
('Legno di castagno', 'Materiale legno di castagno robusto'),
('Tessuto a righe', 'Materiale tessuto a righe colorato'),
('Carta velina', 'Materiale carta velina sottile'),
('Fibra di vetro rinforzata', 'Materiale fibra di vetro rinforzata'),
('Legno di faggio', 'Materiale legno di faggio resistente'),
('Tessuto vellutato', 'Materiale tessuto vellutato morbido'),
('Carta da filtro', 'Materiale carta da filtro per uso industriale'),
('Fibra di polipropilene', 'Materiale fibra di polipropilene resistente'),
('Legno di ciliegio massello', 'Materiale legno di ciliegio massello'),
('Tessuto di cotone biologico', 'Materiale tessuto di cotone biologico'),
('Carta da lucido', 'Materiale carta da lucido trasparente'),
('Fibra di nylon', 'Materiale fibra di nylon resistente'),
('Legno di pino massello', 'Materiale legno di pino massello'),
('Tessuto impermeabile tecnico', 'Materiale tessuto impermeabile tecnico'),
('Carta per acquerello', 'Materiale carta per acquerello artistica'),
('Fibra di kevlar', 'Materiale fibra di kevlar ad alta resistenza'),
('Legno di acacia', 'Materiale legno di acacia resistente'),
('Tessuto a coste', 'Materiale tessuto a coste decorativo'),
('Carta da stampa', 'Materiale carta da stampa di qualità'),
('Fibra di spandex', 'Materiale fibra di spandex elastico'),
('Legno di noce massello', 'Materiale legno di noce massello'),
('Tessuto in lana merino', 'Materiale tessuto in lana merino pregiato'),
('Carta da imballaggio', 'Materiale carta da imballaggio resistente'),
('Fibra di carbonio tessuta', 'Materiale fibra di carbonio tessuta resistente'),
('Legno di abete massello', 'Materiale legno di abete massello'),
('Tessuto jacquard di cotone', 'Materiale tessuto jacquard di cotone'),
('Carta per stampa fotografica', 'Materiale carta per stampa fotografica'),
('Fibra di poliestere riciclata', 'Materiale fibra di poliestere riciclata'),
('Legno compensato marino', 'Materiale legno compensato marino resistente'),
('Tessuto tecnico traspirante', 'Materiale tessuto tecnico traspirante'),
('Carta da diario', 'Materiale carta da diario decorativa'),
('Fibra di polipropilene tessuta', 'Materiale fibra di polipropilene tessuta'),
('Legno di rovere', 'Materiale legno di rovere resistente'),
('Tessuto di lino pregiato', 'Materiale tessuto di lino pregiato'),
('Carta da costruzione', 'Materiale carta da costruzione robusta'),
('Fibra di vetro ad alta densità', 'Materiale fibra di vetro ad alta densità'),
('Legno di abete rosso', 'Materiale legno di abete rosso'),
('Tessuto di seta naturale', 'Materiale tessuto di seta naturale'),
('Carta per origami', 'Materiale carta per origami'),
('Fibra di carbonio ad alta resistenza', 'Materiale fibra di carbonio ad alta resistenza'),
('Legno di ciliegio pregiato', 'Materiale legno di ciliegio pregiato'),
('Tessuto di cotone grezzo', 'Materiale tessuto di cotone grezzo'),
('Carta da riciclo', 'Materiale carta da riciclo ecologica'),
('Fibra di nylon resistente', 'Materiale fibra di nylon resistente'),
('Legno di noce chiaro', 'Materiale legno di noce chiaro'),
('Tessuto di lana grossa', 'Materiale tessuto di lana grossa'),
('Carta per scrittura', 'Materiale carta per scrittura di qualità'),
('Fibra di polipropilene resistente', 'Materiale fibra di polipropilene resistente'),
('Legno di faggio chiaro', 'Materiale legno di faggio chiaro'),
('Tessuto di seta lucida', 'Materiale tessuto di seta lucida'),
('Carta da disegno', 'Materiale carta da disegno per artisti'),
('Fibra di vetro resistente', 'Materiale fibra di vetro resistente'),
('Legno di betulla chiaro', 'Materiale legno di betulla chiaro'),
('Tessuto di cotone fine', 'Materiale tessuto di cotone fine'),
('Carta per stampa digitale', 'Materiale carta per stampa digitale'),
('Fibra sintetica leggera', 'Materiale fibra sintetica leggera'),
('Legno di rovere massello', 'Materiale legno di rovere massello'),
('Tessuto in lino tessuto', 'Materiale tessuto in lino tessuto'),
('Carta da regalo', 'Materiale carta da regalo decorativa'),
('Fibra di carbonio leggera', 'Materiale fibra di carbonio leggera'),
('Legno di castagno massello', 'Materiale legno di castagno massello'),
('Tessuto jacquard di lana', 'Materiale tessuto jacquard di lana'),
('Carta da cucina', 'Materiale carta da cucina'),
('Fibra di poliestere morbida', 'Materiale fibra di poliestere morbida'),
('Legno di acacia massello', 'Materiale legno di acacia massello'),
('Tessuto impermeabile leggero', 'Materiale tessuto impermeabile leggero'),
('Carta da lucido trasparente', 'Materiale carta da lucido trasparente'),
('Fibra di nylon resistente', 'Materiale fibra di nylon resistente'),
('Legno di pino chiaro', 'Materiale legno di pino chiaro'),
('Tessuto tecnico leggero', 'Materiale tessuto tecnico leggero'),
('Carta da acquerello pesante', 'Materiale carta da acquerello pesante'),
('Fibra di kevlar resistente', 'Materiale fibra di kevlar resistente'),
('Legno di noce scuro', 'Materiale legno di noce scuro'),
('Tessuto a coste spesse', 'Materiale tessuto a coste spesse'),
('Carta da stampa lucida', 'Materiale carta da stampa lucida'),
('Fibra di spandex elastica', 'Materiale fibra di spandex elastica'),
('Legno di abete scuro', 'Materiale legno di abete scuro'),
('Tessuto in lana fine', 'Materiale tessuto in lana fine'),
('Carta da imballaggio riciclata', 'Materiale carta da imballaggio riciclata'),
('Fibra di carbonio tessuta leggera', 'Materiale fibra di carbonio tessuta leggera'),
('Legno di abete chiaro', 'Materiale legno di abete chiaro'),
('Tessuto jacquard di cotone leggero', 'Materiale tessuto jacquard di cotone leggero'),
('Carta per stampa fotografica lucida', 'Materiale carta per stampa fotografica lucida'),
('Fibra di poliestere riciclata leggera', 'Materiale fibra di poliestere riciclata leggera'),
('Legno compensato marino leggero', 'Materiale legno compensato marino leggero'),
('Tessuto tecnico traspirante leggero', 'Materiale tessuto tecnico traspirante leggero'),
('Carta da diario decorativa', 'Materiale carta da diario decorativa'),
('Fibra di polipropilene tessuta leggera', 'Materiale fibra di polipropilene tessuta leggera'),
('Legno di rovere chiaro', 'Materiale legno di rovere chiaro'),
('Tessuto di lino pregiato leggero', 'Materiale tessuto di lino pregiato leggero'),
('Carta da costruzione resistente', 'Materiale carta da costruzione resistente'),
('Fibra di vetro ad alta densità leggera', 'Materiale fibra di vetro ad alta densità leggera'),
('Legno di abete rosso chiaro', 'Materiale legno di abete rosso chiaro'),
('Tessuto di seta naturale leggero', 'Materiale tessuto di seta naturale leggero'),
('Carta per origami leggera', 'Materiale carta per origami leggera'),
('Fibra di carbonio ad alta resistenza leggera', 'Materiale fibra di carbonio ad alta resistenza leggera'),
('Legno di ciliegio pregiato chiaro', 'Materiale legno di ciliegio pregiato chiaro'),
('Tessuto di cotone grezzo leggero', 'Materiale tessuto di cotone grezzo leggero'),
('Carta da riciclo ecologica', 'Materiale carta da riciclo ecologica'),
('Fibra di nylon resistente leggera', 'Materiale fibra di nylon resistente leggera'),
('Legno di noce chiaro lucido', 'Materiale legno di noce chiaro lucido'),
('Tessuto di lana grossa resistente', 'Materiale tessuto di lana grossa resistente'),
('Carta per scrittura di qualità', 'Materiale carta per scrittura di qualità'),
('Fibra di polipropilene resistente leggera', 'Materiale fibra di polipropilene resistente leggera'),
('Legno di faggio chiaro resistente', 'Materiale legno di faggio chiaro resistente'),
('Tessuto di seta lucida resistente', 'Materiale tessuto di seta lucida resistente'),
('Carta da disegno artistica', 'Materiale carta da disegno artistica'),
('Fibra di vetro resistente leggera', 'Materiale fibra di vetro resistente leggera'),
('Legno di betulla chiaro lucido', 'Materiale legno di betulla chiaro lucido'),
('Tessuto di cotone fine leggero', 'Materiale tessuto di cotone fine leggero'),
('Carta per stampa digitale lucida', 'Materiale carta per stampa digitale lucida'),
('Fibra sintetica leggera resistente', 'Materiale fibra sintetica leggera resistente'),
('Legno di rovere massello resistente', 'Materiale legno di rovere massello resistente'),
('Tessuto in lino tessuto leggero', 'Materiale tessuto in lino tessuto leggero'),
('Carta da regalo decorativa', 'Materiale carta da regalo decorativa'),
('Fibra di carbonio leggera resistente', 'Materiale fibra di carbonio leggera resistente'),
('Legno di castagno massello robusto', 'Materiale legno di castagno massello robusto'),
('Tessuto jacquard di lana pesante', 'Materiale tessuto jacquard di lana pesante'),
('Carta da cucina resistente', 'Materiale carta da cucina resistente'),
('Fibra di poliestere morbida leggera', 'Materiale fibra di poliestere morbida leggera'),
('Legno di acacia massello robusto', 'Materiale legno di acacia massello robusto'),
('Tessuto impermeabile leggero resistente', 'Materiale tessuto impermeabile leggero resistente'),
('Carta da lucido trasparente resistente', 'Materiale carta da lucido trasparente resistente'),
('Fibra di nylon resistente pesante', 'Materiale fibra di nylon resistente pesante'),
('Legno di pino chiaro robusto', 'Materiale legno di pino chiaro robusto'),
('Tessuto tecnico leggero traspirante', 'Materiale tessuto tecnico leggero traspirante'),
('Carta da acquerello pesante resistente', 'Materiale carta da acquerello pesante resistente'),
('Fibra di kevlar resistente pesante', 'Materiale fibra di kevlar resistente pesante'),
('Legno di noce scuro lucido', 'Materiale legno di noce scuro lucido'),
('Tessuto a coste spesse resistenti', 'Materiale tessuto a coste spesse resistenti'),
('Carta da stampa lucida resistente', 'Materiale carta da stampa lucida resistente'),
('Fibra di spandex elastica resistente', 'Materiale fibra di spandex elastica resistente'),
('Legno di abete scuro resistente', 'Materiale legno di abete scuro resistente'),
('Tessuto in lana fine leggero', 'Materiale tessuto in lana fine leggero'),
('Carta da imballaggio riciclata resistente', 'Materiale carta da imballaggio riciclata resistente'),
('Fibra di carbonio tessuta leggera resistente', 'Materiale fibra di carbonio tessuta leggera resistente'),
('Legno di abete chiaro resistente', 'Materiale legno di abete chiaro resistente'),
('Tessuto jacquard di cotone leggero resistente', 'Materiale tessuto jacquard di cotone leggero resistente'),
('Carta per stampa fotografica lucida resistente', 'Materiale carta per stampa fotografica lucida resistente'),
('Fibra di poliestere riciclata leggera resistente', 'Materiale fibra di poliestere riciclata leggera resistente'),
('Legno compensato marino leggero resistente', 'Materiale legno compensato marino leggero resistente'),
('Tessuto tecnico traspirante leggero resistente', 'Materiale tessuto tecnico traspirante leggero resistente'),
('Carta da diario decorativa resistente', 'Materiale carta da diario decorativa resistente'),
('Fibra di polipropilene tessuta leggera resistente', 'Materiale fibra di polipropilene tessuta leggera resistente'),
('Legno di rovere chiaro resistente', 'Materiale legno di rovere chiaro resistente'),
('Tessuto di lino pregiato leggero resistente', 'Materiale tessuto di lino pregiato leggero resistente'),
('Carta da costruzione resistente pesante', 'Materiale carta da costruzione resistente pesante'),
('Fibra di vetro ad alta densità leggera resistente', 'Materiale fibra di vetro ad alta densità leggera resistente'),
('Legno di abete rosso chiaro resistente', 'Materiale legno di abete rosso chiaro resistente'),
('Tessuto di seta naturale leggero resistente', 'Materiale tessuto di seta naturale leggero resistente'),
('Carta per origami leggera resistente', 'Materiale carta per origami leggera resistente'),
('Fibra di carbonio ad alta resistenza leggera resistente', 'Materiale fibra di carbonio ad alta resistenza leggera resistente'),
('Legno di ciliegio pregiato chiaro resistente', 'Materiale legno di ciliegio pregiato chiaro resistente'),
('Tessuto di cotone grezzo leggero resistente', 'Materiale tessuto di cotone grezzo leggero resistente'),
('Carta da riciclo ecologica resistente', 'Materiale carta da riciclo ecologica resistente'),
('Fibra di nylon resistente leggera resistente', 'Materiale fibra di nylon resistente leggera resistente'),
('Legno di noce chiaro lucido resistente', 'Materiale legno di noce chiaro lucido resistente'),
('Tessuto di lana grossa resistente pesante', 'Materiale tessuto di lana grossa resistente pesante'),
('Carta per scrittura di qualità resistente', 'Materiale carta per scrittura di qualità resistente'),
('Fibra di polipropilene resistente leggera resistente', 'Materiale fibra di polipropilene resistente leggera resistente'),
('Legno di faggio chiaro resistente pesante', 'Materiale legno di faggio chiaro resistente pesante'),
('Tessuto di seta lucida resistente pesante', 'Materiale tessuto di seta lucida resistente pesante'),
('Carta da disegno artistica resistente', 'Materiale carta da disegno artistica resistente'),
('Fibra di vetro resistente leggera resistente', 'Materiale fibra di vetro resistente leggera resistente'),
('Legno di betulla chiaro lucido resistente', 'Materiale legno di betulla chiaro lucido resistente'),
('Tessuto di cotone fine leggero resistente', 'Materiale tessuto di cotone fine leggero resistente'),
('Carta per stampa digitale lucida resistente', 'Materiale carta per stampa digitale lucida resistente'),
('Fibra sintetica leggera resistente pesante', 'Materiale fibra sintetica leggera resistente pesante'),
('Legno di rovere massello resistente pesante', 'Materiale legno di rovere massello resistente pesante'),
('Tessuto in lino tessuto leggero resistente', 'Materiale tessuto in lino tessuto leggero resistente'),
('Carta da regalo decorativa resistente', 'Materiale carta da regalo decorativa resistente'),
('Fibra di carbonio leggera resistente pesante', 'Materiale fibra di carbonio leggera resistente pesante'),
('Legno di castagno massello robusto resistente', 'Materiale legno di castagno massello robusto resistente'),
('Tessuto jacquard di lana pesante resistente', 'Materiale tessuto jacquard di lana pesante resistente'),
('Carta da cucina resistente pesante', 'Materiale carta da cucina resistente pesante'),
('Fibra di poliestere morbida leggera resistente', 'Materiale fibra di poliestere morbida leggera resistente'),
('Legno di acacia massello robusto resistente', 'Materiale legno di acacia massello robusto resistente'),
('Tessuto impermeabile leggero resistente pesante', 'Materiale tessuto impermeabile leggero resistente pesante'),
('Carta da lucido trasparente resistente pesante', 'Materiale carta da lucido trasparente resistente pesante'),
('Fibra di nylon resistente pesante robusta', 'Materiale fibra di nylon resistente pesante robusta'),
('Legno di pino chiaro robusto resistente', 'Materiale legno di pino chiaro robusto resistente'),
('Tessuto tecnico leggero traspirante resistente', 'Materiale tessuto tecnico leggero traspirante resistente'),
('Carta da acquerello pesante resistente robusta', 'Materiale carta da acquerello pesante resistente robusta'),
('Fibra di kevlar resistente pesante robusta', 'Materiale fibra di kevlar resistente pesante robusta'),
('Legno di noce scuro lucido resistente', 'Materiale legno di noce scuro lucido resistente'),
('Tessuto a coste spesse resistenti pesanti', 'Materiale tessuto a coste spesse resistenti pesanti'),
('Carta da stampa lucida resistente pesante', 'Materiale carta da stampa lucida resistente pesante'),
('Fibra di spandex elastica resistente pesante', 'Materiale fibra di spandex elastica resistente pesante'),
('Legno di abete scuro resistente pesante', 'Materiale legno di abete scuro resistente pesante'),
('Tessuto in lana fine leggero resistente', 'Materiale tessuto in lana fine leggero resistente'),
('Carta da imballaggio riciclata resistente pesante', 'Materiale carta da imballaggio riciclata resistente pesante'),
('Fibra di carbonio tessuta leggera resistente pesante', 'Materiale fibra di carbonio tessuta leggera resistente pesante'),
('Legno di abete chiaro resistente pesante', 'Materiale legno di abete chiaro resistente pesante'),
('Tessuto jacquard di cotone leggero resistente pesante', 'Materiale tessuto jacquard di cotone leggero resistente pesante'),
('Carta per stampa fotografica lucida resistente pesante', 'Materiale carta per stampa fotografica lucida resistente pesante'),
('Fibra di poliestere riciclata leggera resistente pesante', 'Materiale fibra di poliestere riciclata leggera resistente pesante'),
('Legno compensato marino leggero resistente pesante', 'Materiale legno compensato marino leggero resistente pesante'),
('Tessuto tecnico traspirante leggero resistente pesante', 'Materiale tessuto tecnico traspirante leggero resistente pesante'),
('Carta da diario decorativa resistente pesante', 'Materiale carta da diario decorativa resistente pesante'),
('Fibra di polipropilene tessuta leggera resistente pesante', 'Materiale fibra di polipropilene tessuta leggera resistente pesante'),
('Legno di rovere chiaro resistente pesante', 'Materiale legno di rovere chiaro resistente pesante'),
('Tessuto di lino pregiato leggero resistente pesante', 'Materiale tessuto di lino pregiato leggero resistente pesante'),
('Carta da costruzione resistente pesante robusta', 'Materiale carta da costruzione resistente pesante robusta'),
('Fibra di vetro ad alta densità leggera resistente pesante', 'Materiale fibra di vetro ad alta densità leggera resistente pesante'),
('Legno di abete rosso chiaro resistente pesante', 'Materiale legno di abete rosso chiaro resistente pesante'),
('Tessuto di seta naturale leggero resistente pesante', 'Materiale tessuto di seta naturale leggero resistente pesante'),
('Carta per origami leggera resistente pesante', 'Materiale carta per origami leggera resistente pesante'),
('Fibra di carbonio ad alta resistenza leggera resistente pesante', 'Materiale fibra di carbonio ad alta resistenza leggera resistente pesante'),
('Legno di ciliegio pregiato chiaro resistente pesante', 'Materiale legno di ciliegio pregiato chiaro resistente pesante'),
('Tessuto di cotone grezzo leggero resistente pesante', 'Materiale tessuto di cotone grezzo leggero resistente pesante'),
('Carta da riciclo ecologica resistente pesante', 'Materiale carta da riciclo ecologica resistente pesante'),
('Fibra di nylon resistente leggera resistente pesante', 'Materiale fibra di nylon resistente leggera resistente pesante'),
('Legno di noce chiaro lucido resistente pesante', 'Materiale legno di noce chiaro lucido resistente pesante'),
('Tessuto di lana grossa resistente pesante robusta', 'Materiale tessuto di lana grossa resistente pesante robusta'),
('Carta per scrittura di qualità resistente pesante', 'Materiale carta per scrittura di qualità resistente pesante'),
('Fibra di polipropilene resistente leggera resistente pesante', 'Materiale fibra di polipropilene resistente leggera resistente pesante'),
('Legno di faggio chiaro resistente pesante robusto', 'Materiale legno di faggio chiaro resistente pesante robusto'),
('Tessuto di seta lucida resistente pesante robusta', 'Materiale tessuto di seta lucida resistente pesante robusta');

INSERT INTO CONTRATTO_PERSONALE (descrizione, stipendio_mensile) VALUES
('Contratto a tempo indeterminato full-time', 3000),
('Contratto a tempo determinato 6 mesi', 2800),
('Contratto part-time 20 ore settimanali', 1500),
('Contratto a progetto', 2200),
('Contratto di apprendistato', 1800),
('Contratto stagionale estivo', 2000),
('Contratto di collaborazione coordinata e continuativa', 2100),
('Contratto di somministrazione lavoro', 1900),
('Contratto a tempo indeterminato part-time', 2500),
('Contratto di stage curriculare', 1200),
('Contratto di stage extracurriculare', 1300),
('Contratto di lavoro intermittente', 1600),
('Contratto di lavoro a chiamata', 1700),
('Contratto a tempo determinato 12 mesi', 2900),
('Contratto di lavoro subordinato full-time', 3100),
('Contratto di lavoro subordinato part-time', 2300),
('Contratto di inserimento lavorativo', 1950),
('Contratto di lavoro a tempo parziale verticale', 1800),
('Contratto di lavoro a tempo parziale orizzontale', 1750),
('Contratto di lavoro a tempo determinato 3 mesi', 2600),
('Contratto di collaborazione occasionale', 1400),
('Contratto di lavoro a tempo indeterminato con incentivi', 3200),
('Contratto di lavoro part-time 15 ore settimanali', 1300),
('Contratto di lavoro per esigenze stagionali', 2100),
('Contratto di lavoro a termine con proroga', 2700),
('Contratto di lavoro intermittente con retribuzione variabile', 1900),
('Contratto di apprendistato professionalizzante', 2000),
('Contratto di lavoro a progetto con bonus', 2300),
('Contratto di lavoro a tempo indeterminato con bonus produttività', 3500),
('Contratto di collaborazione a progetto part-time', 1800),
('Contratto di lavoro per sostituzione maternità', 2400),
('Contratto di lavoro in somministrazione full-time', 2600),
('Contratto di lavoro in somministrazione part-time', 1800),
('Contratto di lavoro a tempo determinato per sostituzione', 2800),
('Contratto di lavoro a chiamata con preavviso', 1600),
('Contratto di lavoro intermittente per esigenze aziendali', 1700),
('Contratto di lavoro stagionale inverno', 2200),
('Contratto di lavoro a progetto con durata 1 anno', 2500),
('Contratto di lavoro subordinato a tempo parziale', 2400),
('Contratto di lavoro subordinato full-time senior', 3700),
('Contratto di collaborazione coordinata e continuativa con bonus', 2600),
('Contratto di apprendistato per giovani', 1800),
('Contratto di lavoro part-time 10 ore settimanali', 1000),
('Contratto di lavoro a tempo indeterminato junior', 2700),
('Contratto di lavoro a termine per progetti specifici', 2900),
('Contratto di lavoro a tempo determinato 9 mesi', 2850),
('Contratto di lavoro a chiamata con durata limitata', 1500),
('Contratto di lavoro a progetto senior', 2800),
('Contratto di collaborazione occasionale per consulenze', 1700),
('Contratto di lavoro stagionale primavera-estate', 2300);

INSERT INTO MODELLA (CF, nome, cognome, telefono, residenza___via, residenza___numero_civico) VALUES
('BNCLDA90B12F205Y', 'Lara', 'Bianchi', 32976543, 'Via Milano', 45),
('VRDLNZ91C23G204Z', 'Lorenza', 'Verdi', 34798765, 'Corso Italia', 7),
('FMLGPN88D15D214W', 'Giulia', 'Famiglia', 33311223, 'Via Torino', 22),
('PRSDRN85E14E456T', 'Sabrina', 'Parisi', 33577889, 'Piazza Dante', 10),
('CDLRRT92F19F308P', 'Chiara', 'Caldara', 33122334, 'Via Napoli', 34),
('LSMMNL87G25H410M', 'Alessia', 'Lusmini', 32844556, 'Via Firenze', 18),
('MRTGPP89H21I512L', 'Martina', 'Martignoni', 3475566, 'Viale Europa', 5),
('GRZLDA84J30J613N', 'Giada', 'Graziani', 3399988, 'Via Roma', 50),
('ZNCFLR86K05K714R', 'Federica', 'Zanconi', 34566778, 'Via Genova', 9),
('TNRGLD93L15L814A', 'Alba', 'Tonarelli', 34022334, 'Via Palermo', 27),
('SMRRRT95M20M917E', 'Serena', 'Samarati', 3478899, 'Corso Venezia', 31),
('LPZMRT94N10N102D', 'Laura', 'Lopez', 3315566, 'Via Torino', 40),
('BNCGPP90O18O208F', 'Beatrice', 'Bianchi', 33677889, 'Via Milano', 55),
('CRLNMR87P25P312G', 'Carolina', 'Carletti', 33811224, 'Via Roma', 15),
('DNNLSD92Q01Q414H', 'Daniela', 'Donati', 34044556, 'Viale Italia', 22),
('FMRGLD85R12R513I', 'Francesca', 'Ferri', 34555668, 'Piazza Garibaldi', 8),
('GLNMRZ93S05S615J', 'Giulia', 'Galletti', 33999886, 'Via Napoli', 28),
('LCCMRT88T10T719K', 'Luca', 'Locci', 34766789, 'Via Firenze', 4),
('MRZPPT94U20U818L', 'Maria', 'Marzotto', 3402235, 'Via Roma', 37),
('NVLDNM89V11V919M', 'Nadia', 'Navid', 3315578, 'Via Genova', 19),
('PPLBRT92W15W102N', 'Paola', 'Pappalardo', 3367790, 'Corso Italia', 29),
('RMMGRS87X19X205P', 'Rossella', 'Ramone', 33811224, 'Via Torino', 12),
('SMRGRN90Y21Y309Q', 'Simona', 'Sammarco', 34044567, 'Via Milano', 6),
('TRNCFF85Z03Z410R', 'Teresa', 'Trinca', 34555668, 'Via Firenze', 41),
('VLGRMT93A04A515S', 'Valeria', 'Valgrisi', 3398776, 'Piazza Dante', 20),
('ZRCPTR88B10B619T', 'Zara', 'Zerocchi', 3476889, 'Via Roma', 3),
('BLNNTR90C11C720U', 'Bianca', 'Bellini', 3402445, 'Corso Venezia', 26),
('CLLRMN92D14D812V', 'Clara', 'Colleroni', 3315778, 'Via Napoli', 14),
('DGRRMT85E18E916W', 'Diana', 'De Gregori', 3368990, 'Via Genova', 11),
('FLLMSR89F21F103X', 'Federica', 'Fallani', 3382334, 'Via Torino', 9),
('GNRFRT94G25G205Y', 'Gianna', 'Generali', 3404667, 'Viale Italia', 42),
('LCMLNT87H29H308Z', 'Lucia', 'Lombardi', 3466778, 'Piazza Garibaldi', 7),
('MNRDPT90I01I410A', 'Monica', 'Morandi', 3398776, 'Via Firenze', 21),
('PRCLDT85J05J514B', 'Paola', 'Pericoli', 3476889, 'Via Roma', 17),
('RLSMNT93K10K619C', 'Rossana', 'Rossi', 3402245, 'Corso Italia', 25),
('SGRNNL88L15L712D', 'Sonia', 'Sangrinelli', 3366778, 'Via Milano', 8),
('TLMRGT92M20M815E', 'Tania', 'Talamonti', 3367990, 'Via Napoli', 38),
('VCLLRT85N25N918F', 'Valentina', 'Vaccarelli', 3322334, 'Via Torino', 33),
('ZGRDPT89O30O102G', 'Zita', 'Zanardi', 3455667, 'Viale Europa', 12),
('BLCRNT90P03P204H', 'Beatrice', 'Bolcarini', 3456778, 'Via Roma', 16),
('CLMZRT93Q10Q306I', 'Cristina', 'Calmazzi', 3398776, 'Piazza Dante', 20),
('DNRGLD85R15R408J', 'Diletta', 'Donarini', 3476889, 'Via Genova', 11),
('FMRNPT92S18S509K', 'Francesca', 'Ferrante', 34033445, 'Corso Venezia', 27),
('GLSMRT87T21T610L', 'Giada', 'Gelsomini', 3315578, 'Via Napoli', 9),
('LCNTMR90U24U713M', 'Luca', 'Lucenti', 3367790, 'Via Torino', 15),
('MRTDPT85V29V817N', 'Martina', 'Moretti', 3381334, 'Via Firenze', 23),
('PRSLRT93W03W919P', 'Paola', 'Prasoli', 34045667, 'Viale Italia', 18),
('RSGNTL88X10X102Q', 'Roberta', 'Rossi', 3455778, 'Piazza Garibaldi', 5),
('SMRGLT92Y15Y203R', 'Simona', 'Sammarini', 3399776, 'Via Roma', 13),
('TLNMRT85Z20Z304S', 'Tania', 'Tolomei', 3476689, 'Corso Italia', 30),
('VLRGPN90A25A406T', 'Valeria', 'Valleggi', 3402245, 'Via Milano', 41),
('ZRCMLT87B30B509U', 'Zara', 'Zoccoli', 3316778, 'Via Napoli', 10),
('BNCRMT93C04C612V', 'Bianca', 'Benacchio', 3788990, 'Via Torino', 8),
('CLRGPT90D10D715W', 'Clara', 'Carretti', 3382334, 'Viale Europa', 22),
('DNRMRT85E15E819X', 'Daniela', 'Donnini', 3405667, 'Piazza Dante', 16),
('FMLRPT92F18F921Y', 'Federica', 'Falorni', 366778, 'Via Roma', 19),
('GNRMRT87G22G102Z', 'Gianna', 'Gonnelli', 3399986, 'Corso Venezia', 7),
('LCRMNT90H25H204A', 'Lucia', 'Lamberti', 3476679, 'Via Napoli', 34),
('MRDTPT85I30I306B', 'Monica', 'Marotti', 3433445, 'Via Firenze', 28),
('PRSGRT93J04J408C', 'Paola', 'Pastore', 3315778, 'Via Torino', 13),
('RSLMNT88K09K510D', 'Rossana', 'Russo', 3367790, 'Via Milano', 9),
('SGRNLT92L14L613E', 'Sonia', 'Sangiorgi', 3382334, 'Viale Europa', 20),
('TLMRPT85M19M715F', 'Tania', 'Talamonti', 3404667, 'Piazza Dante', 6),
('VCLRMT90N22N818G', 'Valentina', 'Vaccari', 3466778, 'Via Roma', 12),
('ZGRDPT87O27O920H', 'Zita', 'Zangari', 3399986, 'Corso Italia', 18);

INSERT INTO PARTECIPANTE (CF, nome, cognome, telefono, residenza___via, residenza___numero_civico) VALUES
('RSSMRA85M01H501A', 'Maria', 'Rossi', 34514567, 'Via Roma', 12),
('BNCLDA90B12F205B', 'Lara', 'Bianchi', 3297621, 'Via Milano', 45),
('VRDLNZ91C23G204C', 'Lorenza', 'Verdi', 3479843, 'Corso Italia', 7),
('FMLGPN88D15D214D', 'Giulia', 'Famiglia', 3332334, 'Via Torino', 22),
('PRSDRN85E14E456E', 'Sabrina', 'Parisi', 3357990, 'Piazza Dante', 10),
('CDLRRT92F19F308F', 'Chiara', 'Caldara', 3312445, 'Via Napoli', 34),
('LSMMNL87G25H410G', 'Alessia', 'Lusmini', 3284467, 'Via Firenze', 18),
('MRTGPP89H21I512H', 'Martina', 'Martignoni', 3476778, 'Viale Europa', 5),
('GRZLDA84J30J613I', 'Giada', 'Graziani', 3399976, 'Via Roma', 50),
('ZNCFLR86K05K714J', 'Federica', 'Zanconi', 3457889, 'Via Genova', 9),
('TNRGLD93L15L814K', 'Alba', 'Tonarelli', 3402445, 'Via Palermo', 27),
('SMRRRT95M20M917L', 'Serena', 'Samarati', 3479001, 'Corso Venezia', 31),
('LPZMRT94N10N102M', 'Laura', 'Lopez', 3315578, 'Via Torino', 40),
('BNCGPP90O18O208N', 'Beatrice', 'Bianchi', 3388990, 'Via Milano', 55),
('CRLNMR87P25P312O', 'Carolina', 'Carletti', 3122334, 'Via Roma', 15),
('DNNLSD92Q01Q414P', 'Daniela', 'Donati', 3404667, 'Viale Italia', 22),
('FMRGLD85R12R513Q', 'Francesca', 'Ferri', 3456778, 'Piazza Garibaldi', 8),
('GLNMRZ93S05S615R', 'Giulia', 'Galletti', 3399776, 'Via Napoli', 28),
('LCCMRT88T10T719S', 'Luca', 'Locci', 3476689, 'Via Firenze', 4),
('MRZPPT94U20U818T', 'Maria', 'Marzotto', 3433445, 'Via Roma', 37),
('BRNGLD75A01Z123A', 'Bruna', 'Borghetti', 5123456, 'Via Torino', 4),
('CNLFRZ86B15Y234B', 'Carlo', 'Canali', 6789123, 'Via Milano', 12),
('DVRGLR90C20X345C', 'Davide', 'DAngelo', 7345678, 'Piazza Duomo', 6),
('FRNRLT88D12W456D', 'Franco', 'Ferrari', 8123456, 'Via Roma', 9),
('GLSNTT91E05V567E', 'Giusy', 'Galanti', 6234789, 'Via Firenze', 14),
('LBRMNG83F22U678F', 'Laura', 'Liberati', 7342891, 'Viale Europa', 27),
('MNTLRZ89G17T789G', 'Marta', 'Montel', 5123874, 'Corso Italia', 3),
('PNLZRV84H10S890H', 'Paolo', 'Ponzani', 6758432, 'Via Napoli', 33),
('RZZNCL87I08R901I', 'Rosa', 'Rizzo', 7981234, 'Via Genova', 8),
('SNTGRD85J19Q012J', 'Sara', 'Santoro', 6231748, 'Piazza Dante', 21),
('TMRLZ92K25P123K', 'Tommaso', 'Tomasi', 5874321, 'Via Palermo', 5),
('VLLMNG80L30O234L', 'Valeria', 'Valli', 6123457, 'Via Torino', 17),
('ZNLFRT93M16N345M', 'Zeno', 'Zanetti', 7423891, 'Corso Venezia', 12),
('CLDRNZ86N29M456N', 'Clara', 'Calderoni', 6745123, 'Via Roma', 9),
('GLLNRT91O13L567O', 'Giulia', 'Gallina', 7341982, 'Via Milano', 7),
('LVRDNR88P24K678P', 'Luca', 'Lavorini', 5123498, 'Viale Italia', 19),
('MNRGLD83Q07J789Q', 'Marco', 'Manzoni', 6234871, 'Piazza Garibaldi', 10),
('PNLRRD85R15I890R', 'Paola', 'Pellari', 7345891, 'Via Firenze', 26),
('RBLGDL90S23H901S', 'Roberta', 'Rubini', 6981237, 'Via Napoli', 7),
('SCLDNR92T31G012T', 'Simone', 'Scaloni', 6732145, 'Corso Italia', 4),
('TCLMRT87U20F123U', 'Tommaso', 'Tocchi', 7456123, 'Via Genova', 11),
('VNLGRZ84V15E234V', 'Vanessa', 'Venanzi', 6234890, 'Piazza Dante', 2),
('ZBRMTN89W25D345W', 'Zaira', 'Zerbini', 5874320, 'Via Torino', 15),
('CMLGRT93X10C456X', 'Camilla', 'Comoli', 6123498, 'Via Milano', 6),
('GRLZMR85Y05B567Y', 'Giorgia', 'Garlati', 6745129, 'Viale Europa', 21),
('LLMNTR81Z18A678Z', 'Lorenzo', 'Lombardi', 7341987, 'Corso Venezia', 10),
('MRTLGD87A29Z789A', 'Martina', 'Martignoni', 5123490, 'Via Roma', 18),
('PNLRCD89B13Y890B', 'Pina', 'Pellegrini', 6234875, 'Via Firenze', 5),
('RDLGNT83C25X901C', 'Riccardo', 'Rondini', 7345897, 'Piazza Garibaldi', 16),
('SBLMNR91D10W012D', 'Sara', 'Sibilia', 6981239, 'Via Napoli', 7),
('TNRGLD86E20V123E', 'Tiziana', 'Tonarelli', 6732140, 'Via Torino', 20),
('VCLNRT84F15U234F', 'Valeria', 'Vincenzi', 7456129, 'Piazza Dante', 12),
('ZMLGDR90G29T345G', 'Zeno', 'Zamboni', 6234897, 'Corso Italia', 4),
('CNRMRT88H13S456H', 'Chiara', 'Cenni', 5874329, 'Via Milano', 17),
('GLNPRZ85I25R567I', 'Gianluca', 'Gallo', 6123490, 'Viale Italia', 22),
('LBRGNT83J10Q678J', 'Luca', 'Liberati', 6745125, 'Via Genova', 13),
('MNTLZR92K20P789K', 'Martina', 'Montel', 7341980, 'Via Palermo', 6),
('PNLZGR89L15O890L', 'Paolo', 'Ponzani', 5123497, 'Piazza Dante', 10),
('RZZNCL87M29N901M', 'Rosa', 'Rizzo', 6234879, 'Via Torino', 3),
('SNTGRD85N13M012N', 'Sara', 'Santoro', 7345890, 'Via Firenze', 25),
('TMRLZR90O25L123O', 'Tommaso', 'Tomasi', 6981235, 'Corso Venezia', 8),
('VLLMNG84P10K234P', 'Valeria', 'Valli', 6732149, 'Via Roma', 14),
('ZNLFRT93Q05J345Q', 'Zeno', 'Zanetti', 7456128, 'Via Milano', 6),
('CLDRNZ86R18I456R', 'Clara', 'Calderoni', 6234895, 'Viale Europa', 9),
('GLLNRT91S29H567S', 'Giulia', 'Gallina', 5874321, 'Corso Italia', 20),
('LVRDNR88T13G678T', 'Luca', 'Lavorini', 6123492, 'Via Napoli', 4),
('BRNGLD75A02Z124A', 'Bruno', 'Bianchi', 5123457, 'Via Torino', 8),
('CNLFRZ86B16Y235B', 'Claudio', 'Cattani', 6789124, 'Via Milano', 21),
('DVRGLR90C21X346C', 'Dario', 'DAngelo', 7345679, 'Piazza Duomo', 14),
('FRNRLT88D13W457D', 'Federica', 'Ferrari', 8123457, 'Via Roma', 13),
('GLSNTT91E06V568E', 'Giuseppina', 'Galanti', 6234790, 'Via Firenze', 23),
('LBRMNG83F23U679F', 'Luca', 'Liberati', 7342892, 'Viale Europa', 36),
('MNTLRZ89G18T780G', 'Matteo', 'Montel', 5123875, 'Corso Italia', 11),
('PNLZRV84H11S891H', 'Paola', 'Ponzani', 6758433, 'Via Napoli', 44),
('RZZNCL87I09R902I', 'Roberto', 'Rizzo', 7981235, 'Via Genova', 18),
('SNTGRD85J20Q013J', 'Silvia', 'Santoro', 6231749, 'Piazza Dante', 25),
('TMRLZ92K26P124K', 'Tiziano', 'Tomasi', 5874322, 'Via Palermo', 16),
('VLLMNG80L31O235L', 'Valentino', 'Valli', 6123458, 'Via Torino', 19),
('ZNLFRT93M17N346M', 'Zaccaria', 'Zanetti', 7423892, 'Corso Venezia', 26),
('CLDRNZ86N30M457N', 'Claudio', 'Calderoni', 6745124, 'Via Roma', 15),
('GLLNRT91O14L568O', 'Gianluca', 'Gallina', 7341983, 'Via Milano', 12),
('LVRDNR88P25K679P', 'Lorenzo', 'Lavorini', 5123499, 'Viale Italia', 28),
('MNRGLD83Q08J790Q', 'Marco', 'Manzoni', 6234872, 'Piazza Garibaldi', 22),
('PNLRRD85R16I891R', 'Patrizia', 'Pellari', 7345892, 'Via Firenze', 31),
('RBLGDL90S24H902S', 'Roberta', 'Rubini', 6981238, 'Via Napoli', 20),
('SCLDNR92T32G013T', 'Simone', 'Scaloni', 6732146, 'Corso Italia', 11),
('TCLMRT87U21F124U', 'Tommaso', 'Tocchi', 7456124, 'Via Genova', 24),
('VNLGRZ84V16E235V', 'Vanessa', 'Venanzi', 6234891, 'Piazza Dante', 29),
('ZBRMTN89W26D346W', 'Zara', 'Zerbini', 5874321, 'Via Torino', 21),
('CMLGRT93X11C457X', 'Camilla', 'Comoli', 6123499, 'Via Milano', 23),
('GRLZMR85Y06B568Y', 'Giorgia', 'Garlati', 6745130, 'Viale Europa', 33),
('LLMNTR81Z19A679Z', 'Lorenzo', 'Lombardi', 7341988, 'Corso Venezia', 28),
('MRTLGD87A30Z780A', 'Martina', 'Martignoni', 5123491, 'Via Roma', 24),
('PNLRCD89B14Y891B', 'Paolo', 'Pellegrini', 6234876, 'Via Firenze', 16),
('RDLGNT83C26X902C', 'Riccardo', 'Rondini', 7345898, 'Piazza Garibaldi', 30),
('SBLMNR91D11W013D', 'Sara', 'Sibilia', 6981240, 'Via Napoli', 26),
('TNRGLD86E21V124E', 'Tiziana', 'Tonarelli', 6732141, 'Via Torino', 28),
('VCLNRT84F16U235F', 'Valeria', 'Vincenzi', 7456130, 'Piazza Dante', 35),
('ZMLGDR90G30T346G', 'Zeno', 'Zamboni', 6234898, 'Corso Italia', 29),
('CNRMRT88H14S457H', 'Chiara', 'Cenni', 5874330, 'Via Milano', 30),
('GLNPRZ85I26R568I', 'Gianluca', 'Gallo', 6123491, 'Viale Italia', 27),
('LBRGNT83J11Q679J', 'Luca', 'Liberati', 6745126, 'Via Genova', 35),
('MNTLZR92K21P780K', 'Martina', 'Montel', 7341981, 'Via Palermo', 24),
('PNLZGR89L16O891L', 'Paolo', 'Ponzani', 5123498, 'Piazza Dante', 30),
('RZZNCL87M30N902M', 'Rosa', 'Rizzo', 6234880, 'Via Torino', 19),
('SNTGRD85N14M013N', 'Sara', 'Santoro', 7345891, 'Via Firenze', 38),
('TMRLZR90O26L124O', 'Tommaso', 'Tomasi', 6981236, 'Corso Venezia', 21),
('VLLMNG84P11K235P', 'Valeria', 'Valli', 6732150, 'Via Roma', 33),
('ZNLFRT93Q06J346Q', 'Zeno', 'Zanetti', 7456129, 'Via Milano', 26),
('CLDRNZ86R19I457R', 'Clara', 'Calderoni', 6234896, 'Viale Europa', 27),
('GLLNRT91S30H568S', 'Giulia', 'Gallina', 5874322, 'Corso Italia', 33),
('LVRDNR88T14G679T', 'Luca', 'Lavorini', 6123493, 'Via Napoli', 18),
('BRNGLD75A03Z125A', 'Bruna', 'Borghetti', 5123458, 'Via Torino', 12),
('CNLFRZ86B17Y236B', 'Carlo', 'Canali', 6789125, 'Via Milano', 29),
('DVRGLR90C22X347C', 'Davide', 'DAngelo', 7345680, 'Piazza Duomo', 17),
('FRNRLT88D14W458D', 'Franco', 'Ferrari', 8123458, 'Via Roma', 16),
('GLSNTT91E07V569E', 'Giusy', 'Galanti', 6234791, 'Via Firenze', 27),
('LBRMNG83F24U680F', 'Laura', 'Liberati', 7342893, 'Viale Europa', 41),
('MNTLRZ89G19T781G', 'Marta', 'Montel', 5123876, 'Corso Italia', 13),
('PNLZRV84H12S892H', 'Paolo', 'Ponzani', 6758434, 'Via Napoli', 51),
('RZZNCL87I10R903I', 'Rosa', 'Rizzo', 7981236, 'Via Genova', 21),
('SNTGRD85J21Q014J', 'Sara', 'Santoro', 6231750, 'Piazza Dante', 30),
('TMRLZ92K27P125K', 'Tommaso', 'Tomasi', 5874323, 'Via Palermo', 18),
('VLLMNG80L32O236L', 'Valeria', 'Valli', 6123459, 'Via Torino', 24),
('ZNLFRT93M18N347M', 'Zeno', 'Zanetti', 7423893, 'Corso Venezia', 31),
('CLDRNZ86N31M458N', 'Clara', 'Calderoni', 6745125, 'Via Roma', 21),
('GLLNRT91O15L569O', 'Giulia', 'Gallina', 7341984, 'Via Milano', 14),
('LVRDNR88P26K680P', 'Luca', 'Lavorini', 5123500, 'Viale Italia', 33),
('MNRGLD83Q09J791Q', 'Marco', 'Manzoni', 6234873, 'Piazza Garibaldi', 29),
('PNLRRD85R17I892R', 'Paola', 'Pellari', 7345893, 'Via Firenze', 37),
('RBLGDL90S25H903S', 'Roberta', 'Rubini', 6981239, 'Via Napoli', 29),
('SCLDNR92T33G014T', 'Simone', 'Scaloni', 6732147, 'Corso Italia', 16),
('TCLMRT87U22F125U', 'Tommaso', 'Tocchi', 7456125, 'Via Genova', 32),
('VNLGRZ84V17E236V', 'Vanessa', 'Venanzi', 6234892, 'Piazza Dante', 31),
('ZBRMTN89W27D347W', 'Zaira', 'Zerbini', 5874322, 'Via Torino', 27),
('CMLGRT93X12C458X', 'Camilla', 'Comoli', 6123500, 'Via Milano', 30),
('GRLZMR85Y07B569Y', 'Giorgia', 'Garlati', 6745131, 'Viale Europa', 39),
('LLMNTR81Z20A680Z', 'Lorenzo', 'Lombardi', 7341989, 'Corso Venezia', 37),
('MRTLGD87A31Z781A', 'Martina', 'Martignoni', 5123492, 'Via Roma', 30),
('PNLRCD89B15Y892B', 'Pina', 'Pellegrini', 6234877, 'Via Firenze', 21),
('RDLGNT83C27X903C', 'Riccardo', 'Rondini', 7345899, 'Piazza Garibaldi', 35),
('SBLMNR91D12W014D', 'Sara', 'Sibilia', 6981241, 'Via Napoli', 33),
('TNRGLD86E22V125E', 'Tiziana', 'Tonarelli', 6732142, 'Via Torino', 33),
('VCLNRT84F17U236F', 'Valeria', 'Vincenzi', 7456131, 'Piazza Dante', 42),
('ZMLGDR90G31T347G', 'Zeno', 'Zamboni', 6234899, 'Corso Italia', 37),
('CNRMRT88H15S458H', 'Chiara', 'Cenni', 5874331, 'Via Milano', 38),
('GLNPRZ85I27R569I', 'Gianluca', 'Gallo', 6123492, 'Viale Italia', 35),
('LBRGNT83J12Q680J', 'Luca', 'Liberati', 6745127, 'Via Genova', 41),
('MNTLZR92K22P781K', 'Martina', 'Montel', 7341982, 'Via Palermo', 30),
('PNLZGR89L17O892L', 'Paolo', 'Ponzani', 5123499, 'Piazza Dante', 38),
('RZZNCL87M31N903M', 'Rosa', 'Rizzo', 6234881, 'Via Torino', 27),
('SNTGRD85N15M014N', 'Sara', 'Santoro', 7345892, 'Via Firenze', 45),
('TMRLZR90O27L125O', 'Tommaso', 'Tomasi', 6981237, 'Corso Venezia', 29),
('VLLMNG84P12K236P', 'Valeria', 'Valli', 6732151, 'Via Roma', 37),
('ZNLFRT93Q07J347Q', 'Zeno', 'Zanetti', 7456130, 'Via Milano', 31),
('CLDRNZ86R20I458R', 'Clara', 'Calderoni', 6234897, 'Viale Europa', 33),
('GLLNRT91S31H569S', 'Giulia', 'Gallina', 5874323, 'Corso Italia', 38),
('LVRDNR88T15G680T', 'Luca', 'Lavorini', 6123494, 'Via Napoli', 23);

INSERT INTO TIPOLOGIA_EVENTO (nome, descrizione) VALUES
('Conferenza', 'Evento formale con interventi e dibattiti su temi specifici'),
('Workshop', 'Sessione pratica e interattiva per apprendere nuove competenze'),
('Seminario', 'Incontro per approfondire un argomento con esperti del settore'),
('Fiera', 'Esposizione di prodotti e servizi per networking e promozione'),
('Concerto', 'Evento musicale dal vivo con performance di artisti');


INSERT INTO ABITO (nome, descrizione_, codice_lavoro) VALUES
('Completo Business', 'Completo elegante per riunioni formali', 1),
('Casual Smart', 'Abito casual ma curato per ufficio', 1),
('Giacca e Jeans', 'Giacca blu con jeans scuri', 1),
('Polo e Pantaloni', 'Polo a maniche corte con pantaloni chino', 1),
('Tuta da Lavoro', 'Tuta resistente per lavori manuali', 2),
('Camicia a Quadri', 'Camicia a quadri per attività all’aperto', 2),
('Jeans Rinforzati', 'Jeans con rinforzi per maggiore durata', 2),
('Giacca Imbottita', 'Giacca calda per lavorare all’esterno', 2),
('Vestito Estivo', 'Vestito leggero per climi caldi', 3),
('Gonna e Blusa', 'Look elegante per ufficio femminile', 3),
('Pantaloni Palazzo', 'Pantaloni larghi e comodi', 3),
('Cardigan Leggero', 'Cardigan per serate fresche', 3),
('Uniforme Tecnica', 'Divisa tecnica per manutentori', 4),
('Maglietta Tecnica', 'Maglietta traspirante per attività fisiche', 4),
('Pantaloni Tecnici', 'Pantaloni resistenti e comodi', 4),
('Giacca a Vento', 'Giacca leggera antivento', 4),
('Abito Cerimonia', 'Abito elegante per eventi speciali', 5),
('Camicia Bianca', 'Camicia classica bianca', 5),
('Pantaloni Classici', 'Pantaloni eleganti da uomo', 5),
('Giacca Doppiopetto', 'Giacca formale doppiopetto', 5),
('Maglietta Sportiva', 'Maglietta tecnica per attività sportive', 6),
('Pantaloncini Corti', 'Pantaloncini per allenamento', 6),
('Felpa con Cappuccio', 'Felpa comoda per riscaldamento', 6),
('Giacca Running', 'Giacca leggera per corsa', 6),
('Camicia Casual', 'Camicia a maniche lunghe casual', 7),
('Jeans Classici', 'Jeans blu classici', 7),
('Maglione a V', 'Maglione elegante a V', 7),
('Giacca di Pelle', 'Giacca in pelle nera', 7),
('Divisa Ospedaliera', 'Divisa sanitaria per medici', 8),
('Pantaloni Sanitari', 'Pantaloni comodi per lavoro ospedaliero', 8),
('Casacca Bianca', 'Casacca bianca per infermieri', 8),
('Scarpe Antinfortunistiche', 'Scarpe sicure per ospedale', 8),
('Abito Estivo Uomo', 'Abito leggero estivo per uomo', 9),
('Camicia a Maniche Corte', 'Camicia fresca a maniche corte', 9),
('Pantaloni Leggeri', 'Pantaloni estivi leggeri', 9),
('Sandali Eleganti', 'Sandali comodi ed eleganti', 9),
('Giacca a Quadri', 'Giacca con motivo a quadri', 10),
('Pantaloni in Lana', 'Pantaloni caldi in lana', 10),
('Camicia in Flanella', 'Camicia calda in flanella', 10),
('Stivali in Pelle', 'Stivali resistenti in pelle', 10),
('T-shirt Grafica', 'Maglietta con stampa grafica', 11),
('Jeans Strappati', 'Jeans con effetto consumato', 11),
('Felpa Oversize', 'Felpa comoda oversize', 11),
('Sneakers Sportive', 'Scarpe sportive casual', 11),
('Abito Elegante Donna', 'Abito da sera elegante', 12),
('Blazer Nero', 'Blazer nero classico', 12),
('Pantaloni a Sigaretta', 'Pantaloni aderenti eleganti', 12),
('Décolleté', 'Scarpe décolleté nere', 12),
('Camicia a Righe', 'Camicia con righe sottili', 13),
('Jeans Slim Fit', 'Jeans aderenti', 13),
('Giacca in Denim', 'Giacca casual in jeans', 13),
('Stivaletti', 'Stivaletti comodi', 13),
('Tuta Sportiva', 'Tuta completa per allenamento', 14),
('Maglietta Traspirante', 'Maglietta tecnica', 14),
('Pantaloni Jogging', 'Pantaloni per jogging', 14),
('Felpa con Zip', 'Felpa comoda con cerniera', 14),
('Abito da Lavoro', 'Abito formale da ufficio', 15),
('Camicia Classica', 'Camicia da uomo classica', 15),
('Cravatta', 'Cravatta elegante', 15),
('Scarpe Eleganti', 'Scarpe da uomo formali', 15),
('Giacca a Vento Tecnica', 'Giacca antivento per esterni', 16),
('Pantaloni Impermeabili', 'Pantaloni per pioggia', 16),
('Maglietta Termica', 'Maglietta per basse temperature', 16),
('Scarpe Trekking', 'Scarpe da trekking robuste', 16),
('Camicia Lino', 'Camicia estiva in lino', 17),
('Pantaloni Corti', 'Pantaloni corti estivi', 17),
('Sandali', 'Sandali aperti', 17),
('Cappello Panama', 'Cappello estivo elegante', 17),
('Completo Cerimonia', 'Completo elegante da cerimonia', 18),
('Camicia Bianca', 'Camicia classica da cerimonia', 18),
('Papillon', 'Papillon elegante', 18),
('Scarpe Lucide', 'Scarpe formali lucide', 18),
('Tuta da Meccanico', 'Tuta resistente per meccanici', 19),
('Maglietta Cotone', 'Maglietta semplice in cotone', 19),
('Guanti da Lavoro', 'Guanti protettivi', 19),
('Scarpe Antinfortunistiche', 'Scarpe di sicurezza', 19),
('Abito Casual Donna', 'Vestito casual comodo', 20),
('Cardigan', 'Cardigan morbido', 20),
('Jeans', 'Jeans classici', 20),
('Sneakers', 'Scarpe sportive casual', 20),
('Giacca Formale', 'Giacca elegante da uomo', 21),
('Pantaloni Classici', 'Pantaloni formali', 21),
('Camicia', 'Camicia elegante', 21),
('Cravatta', 'Cravatta coordinata', 21),
('Maglietta Polo', 'Polo a maniche corte', 22),
('Pantaloni Chino', 'Pantaloni comodi', 22),
('Scarpe Casual', 'Scarpe sportive casual', 22),
('Giacca Leggera', 'Giacca leggera da primavera', 22),
('Vestito Elegante Donna', 'Vestito da sera', 23),
('Bolero', 'Bolero elegante', 23),
('Scarpe con Tacco', 'Scarpe eleganti con tacco', 23),
('Borsa Coordinata', 'Borsa da sera', 23),
('T-shirt Basic', 'Maglietta semplice', 24),
('Jeans', 'Jeans comodi', 24),
('Felpa', 'Felpa con cappuccio', 24),
('Sneakers', 'Scarpe sportive', 24),
('Abito da Ufficio', 'Abito elegante per ufficio', 25),
('Camicia Bianca', 'Camicia formale bianca', 25),
('Pantaloni', 'Pantaloni eleganti', 25),
('Scarpe Eleganti', 'Scarpe da uomo formali', 25),
('Tuta Sportiva Donna', 'Tuta per allenamento', 26),
('Maglietta Tecnica', 'Maglietta traspirante', 26),
('Pantaloni Fitness', 'Pantaloni aderenti', 26),
('Scarpe Running', 'Scarpe da corsa', 26),
('Giacca in Pelle', 'Giacca nera in pelle', 27),
('Jeans', 'Jeans blu scuro', 27),
('Maglione', 'Maglione caldo', 27),
('Stivaletti', 'Stivaletti eleganti', 27),
('Camicia Casual Uomo', 'Camicia a maniche lunghe', 28),
('Pantaloni Chino', 'Pantaloni comodi', 28),
('Giacca Sportiva', 'Giacca leggera', 28),
('Scarpe Casual', 'Scarpe da passeggio', 28),
('Abito Elegante Uomo', 'Abito da sera', 29),
('Camicia Elegante', 'Camicia bianca', 29),
('Cravatta', 'Cravatta elegante', 29),
('Scarpe Lucide', 'Scarpe formali', 29),
('Tuta da Lavoro', 'Tuta resistente', 30),
('Maglietta', 'Maglietta comoda', 30),
('Guanti', 'Guanti protettivi', 30),
('Scarpe Sicure', 'Scarpe antinfortunistiche', 30),
('Abito Casual Donna', 'Vestito comodo', 31),
('Cardigan', 'Cardigan leggero', 31),
('Jeans', 'Jeans aderenti', 31),
('Scarpe Sportive', 'Sneakers comode', 31),
('Giacca Formale Uomo', 'Giacca elegante', 32),
('Pantaloni', 'Pantaloni classici', 32),
('Camicia', 'Camicia formale', 32),
('Cravatta', 'Cravatta coordinata', 32),
('Maglietta Sportiva', 'Maglietta tecnica', 33),
('Pantaloni', 'Pantaloni da allenamento', 33),
('Felpa', 'Felpa con cappuccio', 33),
('Scarpe Running', 'Scarpe sportive', 33),
('Vestito Elegante Donna', 'Vestito da sera', 34),
('Blazer', 'Blazer elegante', 34),
('Scarpe con Tacco', 'Scarpe eleganti', 34),
('Borsa', 'Borsa da sera', 34),
('Tuta da Meccanico', 'Tuta resistente', 35),
('Maglietta', 'Maglietta semplice', 35),
('Guanti', 'Guanti da lavoro', 35),
('Scarpe Sicure', 'Scarpe antinfortunistiche', 35),
('Abito Estivo Uomo', 'Abito leggero', 36),
('Camicia', 'Camicia a maniche corte', 36),
('Pantaloni', 'Pantaloni leggeri', 36),
('Sandali', 'Sandali comodi', 36),
('Completo Business', 'Completo formale', 37),
('Camicia', 'Camicia bianca', 37),
('Cravatta', 'Cravatta elegante', 37),
('Scarpe Eleganti', 'Scarpe da uomo', 37),
('Giacca a Vento', 'Giacca antivento', 38),
('Pantaloni', 'Pantaloni impermeabili', 38),
('Maglietta', 'Maglietta termica', 38),
('Scarpe Trekking', 'Scarpe da trekking', 38),
('Camicia Lino', 'Camicia estiva', 39),
('Pantaloni Corti', 'Pantaloni estivi', 39),
('Sandali', 'Sandali aperti', 39),
('Cappello', 'Cappello estivo', 39),
('Abito Cerimonia', 'Abito elegante', 40),
('Camicia', 'Camicia bianca', 40),
('Papillon', 'Papillon elegante', 40),
('Scarpe Lucide', 'Scarpe formali', 40),
('Tuta da Lavoro', 'Tuta resistente', 41),
('Maglietta', 'Maglietta semplice', 41),
('Guanti', 'Guanti protettivi', 41),
('Scarpe Antinfortunistiche', 'Scarpe di sicurezza', 41),
('Abito Casual Donna', 'Vestito comodo', 42),
('Cardigan', 'Cardigan morbido', 42),
('Jeans', 'Jeans aderenti', 42),
('Sneakers', 'Scarpe sportive', 42),
('Giacca Formale', 'Giacca elegante', 43),
('Pantaloni', 'Pantaloni classici', 43),
('Camicia', 'Camicia formale', 43),
('Cravatta', 'Cravatta coordinata', 43),
('Maglietta Polo', 'Polo casual', 44),
('Pantaloni Chino', 'Pantaloni comodi', 44),
('Scarpe Casual', 'Scarpe sportive', 44),
('Giacca Leggera', 'Giacca da primavera', 44),
('Vestito Elegante Donna', 'Vestito da sera', 45),
('Bolero', 'Bolero elegante', 45),
('Scarpe con Tacco', 'Scarpe eleganti', 45),
('Borsa', 'Borsa da sera', 45),
('T-shirt Basic', 'Maglietta semplice', 46),
('Jeans', 'Jeans comodi', 46),
('Felpa', 'Felpa con cappuccio', 46),
('Sneakers', 'Scarpe sportive', 46),
('Abito da Ufficio', 'Abito elegante', 47),
('Camicia Bianca', 'Camicia formale', 47),
('Pantaloni', 'Pantaloni eleganti', 47),
('Scarpe Eleganti', 'Scarpe da uomo', 47),
('Tuta Sportiva Donna', 'Tuta da allenamento', 48),
('Maglietta Tecnica', 'Maglietta traspirante', 48),
('Pantaloni Fitness', 'Pantaloni aderenti', 48),
('Scarpe Running', 'Scarpe da corsa', 48);

INSERT INTO PIANO (numero_immobile, numero) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(2, 3),
(3, 1),
(3, 2),
(3, 3);

INSERT INTO PERSONALE (
    data_assunzione, CF, nome, cognome, telefono,
    residenza___via, residenza___numero_civico, tipo_personale,
    occupazione_presente_inizio, codice_lavoro, numero_immobile,
    amministratore_sistema, password_applicativo
) VALUES
('2022-05-10 10:00:00', 'RSSMRA80A01F205X', 'Maria', 'Rossi', 345112233, 'Via Milano', 12, 'specializzato', '2023-01-15', 1, 1, true, 'abc12'),
('2021-09-01 09:00:00', 'VRDLGU85B15C351Y', 'Luigi', 'Verdi', 331998877, 'Via Roma', 45, 'specializzato', '2023-02-10', 30, 1, false, 'def34'),
('2023-03-15 08:30:00', 'BNCLRA90C30H501Z', 'Chiara', 'Bianchi', 320556677, 'Via Torino', 78, 'specializzato', '2023-03-01', 15, 2, false, 'ghi56'),
('2020-11-20 14:20:00', 'PLZZNT75D22L219Q', 'Antonio', 'Palazzi', 392887766, 'Viale Venezia', 90, 'specializzato', '2022-09-18', 40, 2, false, 'jkl78'),
('2021-01-07 12:00:00', 'FRNCST88E18A794W', 'Stefano', 'Franchi', 389665544, 'Corso Italia', 33, 'specializzato', '2023-04-03', 5, 3, false, 'mno90'),
('2022-06-21 11:15:00', 'LMBRTI95F05Z404M', 'Giulia', 'Lamberti', 377445566, 'Via Napoli', 27, 'specializzato', '2022-10-01', 46, 3, false, 'pqr12'),
('2020-10-11 07:45:00', 'GLLFNC76G14L219S', 'Francesca', 'Gallo', 366223344, 'Via Firenze', 5, 'specializzato', '2021-01-20', 10, 1, false, 'stu34'),
('2019-12-05 13:00:00', 'TRNTNI85H20F205U', 'Tania', 'Trentini', 334889900, 'Via Bari', 102, 'specializzato', '2020-05-09', 28, 2, false, 'vwx56'),
('2023-02-01 16:30:00', 'BSCLNZ89I12M082P', 'Lorenzo', 'Boschi', 388667788, 'Via Palermo', 88, 'specializzato', '2023-05-10', 20, 3, false, 'yza78'),
('2021-04-17 09:50:00', 'MRTGLD90L01Z404N', 'Gilda', 'Moretti', 350112233, 'Via Genova', 6, 'specializzato', '2022-02-20', 43, 1, false, 'bcd90'),
('2023-11-28 10:00:00', 'VRDLGU85B15C351Y', 'fernanda', 'verdinini', 7645381929, 'Via giangiacomo', 8, 'specializzato', '2024-03-20', 2, 3, false, 'pqrl88');

INSERT INTO SPESA (codice_contrattuale, data, costo, indirizzo___via, indirizzo___nuemro_civico, codice_lavoro, CF) VALUES
(7001, '2025-06-05 10:30:00', 180.00, 'Via Milano', 45, 1, 'BNCLDA90B12F205Y'),
(7002, '2025-06-07 14:15:00', 210.00, 'Via Torino', 22, 2, 'FMLGPN88D15D214W'),
(7003, '2025-06-10 09:50:00', 170.00, 'Via Firenze', 18, 3, 'LSMMNL87G25H410M'),
(7004, '2025-06-12 11:45:00', 200.00, 'Via Genova', 9, 4, 'ZNCFLR86K05K714R'),
(7005, '2025-06-15 16:30:00', 220.00, 'Piazza Dante', 10, 5, 'PRSDRN85E14E456T'),
(7006, '2025-06-17 10:00:00', 190.00, 'Via Roma', 40, 6, 'GRZLDA84J30J613N'),
(7007, '2025-06-20 15:10:00', 175.00, 'Corso Italia', 7, 7, 'VRDLNZ91C23G204Z'),
(7008, '2025-06-22 13:20:00', 230.00, 'Via Napoli', 34, 8, 'CDLRRT92F19F308P'),
(7009, '2025-06-25 09:30:00', 165.00, 'Viale Europa', 5, 9, 'MRTGPP89H21I512L');

INSERT INTO EVENTO (nome, data_inizio_evento, data_fine_evento, descrizione, partecipanti, numero_immobile, codice_lavoro, e_nome) VALUES
('Conferenza Digital Marketing', '2025-06-10 09:00:00', '2025-06-10 17:00:00', 'Evento dedicato alle strategie di marketing digitale', 150, 1, 1, 'Conferenza'),
('Workshop UX/UI Design', '2025-06-15 10:00:00', '2025-06-15 16:00:00', 'Laboratorio pratico su UX e UI design', 40, 2, 2, 'Workshop'),
('Seminario SEO e SEM', '2025-07-10 09:00:00', '2025-07-10 12:00:00', 'Seminario sulle tecniche SEO e SEM', 120, 3, 3, 'Seminario'),
('Fiera Prodotti Digitali', '2025-07-25 09:00:00', '2025-07-25 18:00:00', 'Esposizione di soluzioni e servizi digitali', 200, 1, 4, 'Fiera'),
('Concerto di Beneficenza', '2025-08-05 20:00:00', '2025-08-05 23:00:00', 'Concerto con artisti locali per raccolta fondi', 300, 2, 5, 'Concerto'),
('Workshop Crowdfunding', '2025-09-01 09:00:00', '2025-09-01 16:00:00', 'Laboratorio su tecniche di crowdfunding', 50, 3, 6, 'Workshop'),
('Evento di Networking', '2025-09-10 18:00:00', '2025-09-10 22:00:00', 'Evento per fare rete tra professionisti', 180, 1, 7, 'Fiera'),
('Seminario Innovazione Tecnologica', '2025-08-15 10:00:00', '2025-08-15 18:00:00', 'Incontro con esperti di tecnologia', 130, 2, 8, 'Seminario'),
('Festa di Team Building', '2025-07-01 18:00:00', '2025-07-01 23:00:00', 'Evento sociale per rafforzare il team', 80, 3, 9, 'Fiera'),
('Formazione Social Media', '2025-08-05 09:00:00', '2025-08-05 17:00:00', 'Corso di formazione su social media marketing', 90, 1, 10, 'Workshop');

INSERT INTO STANZA (Div_numero_immobile, Div_numero, numero, partecipanti_massimi, tipo_stanza, capienza, codice_lavoro) VALUES
(1, 1, 101, 20, 'Ufficio', 20, 1),
(1, 1, 102, 15, 'Meeting', 15, 2),
(1, 2, 201, 30, 'Sala', 30, 3),
(1, 2, 202, 25, 'Ufficio', 25, 4),
(1, 3, 301, 10, 'Ufficio', 10, 5),
(2, 1, 101, 40, 'Sala', 40, 6),
(2, 1, 102, 12, 'Meeting', 12, 7),
(2, 2, 201, 8, 'Ufficio', 8, 8),
(3, 1, 101, 35, 'Sala', 35, 9),
(3, 3, 301, 50, 'Auditorium', 50, 10);

INSERT INTO composto (codice_materiale, codice_abito, quantita_usata) VALUES
(13, 1, 5),
(14, 1, 3),
(58, 1, 2),
(24, 8, 4),
(20, 8, 2),
(22, 8, 1),
(14, 9, 6),
(30, 9, 3),
(44, 7, 7),
(46, 7, 2),
(24, 5, 6),
(14, 5, 4),
(14, 2, 4),
(24, 2, 3),
(21, 2, 2),
(53, 9, 1),
(24, 13, 6),
(21, 13, 3),
(20, 13, 2),
(45, 17, 4),
(53, 17, 2),
(39, 17, 1);

INSERT INTO relativo (codice_contrattuale, codice_materiale, quantita) VALUES
(7001, 14, 3),
(7001, 23, 2),
(7002, 53, 1),
(7002, 29, 2),
(7003, 19, 2),
(7003, 20, 1),
(7004, 21, 3),
(7004, 24, 2);


INSERT INTO partecipazione (codice_evento, CF, costo) VALUES
(1, 'RSSMRA85M01H501A', 20),
(1, 'BNCLDA90B12F205B', 20),
(1, 'VRDLNZ91C23G204C', 20),
(2, 'FMLGPN88D15D214D', 15),
(2, 'PRSDRN85E14E456E', 15),
(2, 'CDLRRT92F19F308F', 15),
(3, 'LSMMNL87G25H410G', 10),
(3, 'MRTGPP89H21I512H', 10),
(3, 'GRZLDA84J30J613I', 10),
(4, 'ZNCFLR86K05K714J', 25),
(4, 'TNRGLD93L15L814K', 25),
(4, 'SMRRRT95M20M917L', 25),
(5, 'LPZMRT94N10N102M', 30),
(5, 'BNCGPP90O18O208N', 30),
(5, 'CRLNMR87P25P312O', 30),
(6, 'DNNLSD92Q01Q414P', 12),
(6, 'FMRGLD85R12R513Q', 12),
(6, 'GLNMRZ93S05S615R', 12),
(7, 'LCCMRT88T10T719S', 18),
(7, 'MRZPPT94U20U818T', 18),
(7, 'BRNGLD75A01Z123A', 18),
(8, 'CNLFRZ86B15Y234B', 14),
(8, 'DVRGLR90C20X345C', 14),
(8, 'FRNRLT88D12W456D', 14),
(9, 'GLSNTT91E05V567E', 16),
(9, 'LBRMNG83F22U678F', 16),
(9, 'MNTLRZ89G17T789G', 16),
(10, 'PNLZRV84H10S890H', 22),
(10, 'RZZNCL87I08R901I', 22),
(10, 'SNTGRD85J19Q012J', 22);

INSERT INTO sottoscrive_spesa_abito (codice_contrattuale, codice_abito) VALUES
(7001, 1),
(7001, 2),
(7001, 3),
(7001, 4),
(7002, 5),
(7002, 6),
(7002, 7),
(7002, 8),
(7003, 9),
(7003, 10),
(7003, 11),
(7003, 12),
(7004, 13),
(7004, 14),
(7004, 15),
(7004, 16),
(7005, 17),
(7005, 18),
(7005, 19),
(7005, 20),
(7006, 21),
(7006, 22),
(7006, 23),
(7006, 24),
(7007, 25),
(7007, 26),
(7007, 27),
(7007, 28),
(7008, 29),
(7008, 30),
(7008, 31),
(7008, 32),
(7009, 33),
(7009, 34),
(7009, 35),
(7009, 36);

INSERT INTO sottoscrive_spesa_evento (codice_contrattuale, codice_evento) VALUES
(7001, 1),
(7002, 2),
(7003, 3),
(7004, 4),
(7005, 5),
(7006, 6),
(7007, 7),
(7008, 8),
(7009, 9);


INSERT INTO OCCUPAZIONE (codice_tipologia_contratto, CF, inizio_validita, fine_validita) VALUES
(1, 'RSSMRA80A01F205X', '2023-01-15', NULL),
(10, 'VRDLGU85B15C351Y', '2023-02-10', '2023-08-10'),
(22, 'BNCLRA90C30H501Z', '2023-03-01', NULL),
(1, 'PLZZNT75D22L219Q', '2022-09-18', NULL),
(21, 'FRNCST88E18A794W', '2023-04-03', '2023-10-03'),
(22, 'LMBRTI95F05Z404M', '2022-10-01', '2024-10-01'),
(1, 'GLLFNC76G14L219S', '2021-01-20', NULL),
(22, 'TRNTNI85H20F205U', '2020-05-09', '2022-05-09'),
(21, 'BSCLNZ89I12M082P', '2023-05-10', '2023-11-10'),
(1, 'MRTGLD90L01Z404N', '2022-02-20', NULL),
(1, 'BNCLGU85C15H501Z', '2023-01-15', NULL);

INSERT INTO OCCUPAZIONE_PASSATA (codice_lavoro, inizio_lavoro, CF, fine_lavoro) VALUES
(10, '2022-03-01 09:00:00', 'RSSMRA80A01F205X', '2023-01-10 18:00:00'),
(27, '2020-09-01 10:00:00', 'VRDLGU85B15C351Y', '2021-06-01 18:00:00'),
(20, '2021-07-01 10:00:00', 'VRDLGU85B15C351Y', '2022-12-15 18:00:00'),
(14, '2021-03-01 09:00:00', 'BNCLRA90C30H501Z', '2023-02-28 17:00:00'),
(42, '2019-06-01 08:00:00', 'PLZZNT75D22L219Q', '2022-08-30 17:00:00'),
(30, '2020-02-15 10:00:00', 'FRNCST88E18A794W', '2022-10-15 18:00:00'),
(3,  '2021-01-15 09:00:00', 'LMBRTI95F05Z404M', '2022-09-15 18:00:00'),
(43, '2020-02-01 08:30:00', 'GLLFNC76G14L219S', '2020-12-31 17:30:00'),
(15, '2018-04-01 09:00:00', 'TRNTNI85H20F205U', '2020-04-01 18:00:00'),
(27, '2022-01-10 10:00:00', 'BSCLNZ89I12M082P', '2023-01-10 17:00:00'),
(1,  '2020-01-01 08:30:00', 'MRTGLD90L01Z404N', '2022-01-31 17:00:00');


INSERT INTO tariffa (nome, CF, prezzo) VALUES
('Conferenza', 'RSSMRA85M01H501U', 150),
('Workshop', 'BNCLDA90B12F205Y', 120),
('Seminario', 'VRDLNZ91C23G204Z', 130),
('Fiera', 'FMLGPN88D15D214W', 100),
('Concerto', 'PRSDRN85E14E456T', 200),
('Conferenza', 'CDLRRT92F19F308P', 160),
('Workshop', 'LSMMNL87G25H410M', 110),
('Seminario', 'MRTGPP89H21I512L', 140),
('Fiera', 'GRZLDA84J30J613N', 90),
('Concerto', 'ZNCFLR86K05K714R', 210);

INSERT INTO CONTIENE (Div_numero_immobile, Div_numero, numero, codice_materiale, quantita) VALUES
(1, 1, 101, 2, 50),
(1, 1, 101, 3, 30),
(1, 1, 101, 4, 20),
(1, 1, 102, 2, 100),
(1, 1, 102, 3, 60),
(1, 1, 102, 8, 40),
(1, 2, 201, 8, 200),
(1, 2, 201, 1, 100),
(1, 2, 201, 11, 70),
(1, 2, 202, 2, 60),
(1, 2, 202, 4, 30),
(2, 1, 101, 1, 150),
(2, 1, 101, 8, 90),
(2, 1, 101, 3, 80),
(2, 1, 102, 2, 70),
(2, 1, 102, 11, 40),
(3, 3, 301, 1, 300),
(3, 3, 301, 8, 250),
(3, 3, 301, 5, 150),
(3, 3, 301, 3, 120);


INSERT INTO TURNO_di_LAVORO (data_inizio, data_fine, descrizione, cancellato, Div_numero_immobile, Div_numero, numero, codice_lavoro) VALUES
('2025-06-01 09:00:00', '2025-06-03 09:00:00', 'Turno mattina Gruppo Comunicazione Digitale', '0', 1, 1, 101, 1),
('2025-06-01 14:00:00', '2025-06-01 18:00:00', 'Turno pomeriggio Gruppo Comunicazione Digitale', '0', 1, 1, 101, 1),
('2025-06-02 09:00:00', '2025-06-02 13:00:00', 'Turno mattina Gruppo Visual Design', '0', 1, 1, 102, 2),
('2025-06-02 14:00:00', '2025-06-02 18:00:00', 'Turno pomeriggio Gruppo Visual Design', '0', 1, 1, 102, 2),
('2025-06-03 09:00:00', '2025-06-03 13:00:00', 'Turno mattina Gruppo Contenuti Editoriali', '0', 1, 2, 201, 3),
('2025-06-03 14:00:00', '2025-06-03 18:00:00', 'Turno pomeriggio Gruppo Contenuti Editoriali', '0', 1, 2, 201, 3),
('2025-06-04 09:00:00', '2025-06-04 13:00:00', 'Turno mattina Gruppo Podcast & Audio', '0', 1, 2, 202, 4),
('2025-06-04 14:00:00', '2025-06-04 18:00:00', 'Turno pomeriggio Gruppo Podcast & Audio', '0', 1, 2, 202, 4),
('2025-06-05 09:00:00', '2025-06-05 13:00:00', 'Turno mattina Gruppo Video Produzione', '0', 1, 3, 301, 5),
('2025-06-05 14:00:00', '2025-06-05 18:00:00', 'Turno pomeriggio Gruppo Video Produzione', '0', 1, 3, 301, 5),
('2025-06-06 09:00:00', '2025-06-06 13:00:00', 'Turno mattina Gruppo Sala Immobile 2', '0', 2, 1, 101, 6),
('2025-06-06 14:00:00', '2025-06-06 18:00:00', 'Turno pomeriggio Gruppo Sala Immobile 2', '0', 2, 1, 101, 6),
('2025-06-07 09:00:00', '2025-06-07 13:00:00', 'Turno mattina Gruppo Meeting Immobile 2', '0', 2, 1, 102, 7),
('2025-06-07 14:00:00', '2025-06-07 18:00:00', 'Turno pomeriggio Gruppo Meeting Immobile 2', '0', 2, 1, 102, 7);

INSERT INTO partecipanti_turno (CF, data_inizio, codice_lavoro) VALUES
('RSSMRA80A01F205X', '2025-06-01 09:00:00', 1),
('VRDLGU85B15C351Y', '2025-06-03 09:00:00', 3),
('VRDLGU85B15C351Y', '2025-06-03 14:00:00', 3),
('BNCLRA90C30H501Z', '2025-06-02 09:00:00', 2),
('BNCLRA90C30H501Z', '2025-06-02 14:00:00', 2),
('PLZZNT75D22L219Q', '2025-06-04 09:00:00', 4),
('PLZZNT75D22L219Q', '2025-06-04 14:00:00', 4),
('FRNCST88E18A794W', '2025-06-05 09:00:00', 5),
('FRNCST88E18A794W', '2025-06-05 14:00:00', 5);

INSERT INTO TURNO_della_MODELLA_nella_SFILATA (
    codice_evento, codice_entrata_sfilata, codice_abito, codice_contrattuale
) VALUES
(1, 1, 1, 7001),
(2, 2, 5, 7002),
(3, 3, 9, 7003),
(4, 4, 13, 7004),
(5, 5, 17, 7005),
(6, 6, 21, 7006),
(7, 7, 25, 7007),
(8, 8, 29, 7008),
(9, 9, 33, 7009),
(10, 10, 37, 7001);
