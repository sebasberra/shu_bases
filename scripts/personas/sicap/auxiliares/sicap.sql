DROP TABLE IF EXISTS tpobeneficiarioos
;
DROP TABLE IF EXISTS poriginaria
;
DROP TABLE IF EXISTS lengua
;
DROP TABLE IF EXISTS historiasClinicas
;
DROP TABLE IF EXISTS datosFiliatorios
;
DROP TABLE IF EXISTS calles
;
DROP TABLE IF EXISTS antecedentespersonal
;
DROP TABLE IF EXISTS antecedentesfamiliares
;
DROP TABLE IF EXISTS tipovivienda
;
DROP TABLE IF EXISTS tipopiso
;
DROP TABLE IF EXISTS tipoparedvivienda
;
DROP TABLE IF EXISTS tipoexcretas
;
DROP TABLE IF EXISTS tipodocumento
;
DROP TABLE IF EXISTS sexo
;
DROP TABLE IF EXISTS rtobrsoc_paciente
;
DROP TABLE IF EXISTS provincia
;
DROP TABLE IF EXISTS parentesco
;
DROP TABLE IF EXISTS paciente
;
DROP TABLE IF EXISTS ocupacion
;
DROP TABLE IF EXISTS obrassociales
;
DROP TABLE IF EXISTS niveleducacion
;
DROP TABLE IF EXISTS localidad
;
DROP TABLE IF EXISTS grupofamiliar
;
DROP TABLE IF EXISTS d_establecimiento
;
DROP TABLE IF EXISTS equipomedico
;
DROP TABLE IF EXISTS ecivil
;
DROP TABLE IF EXISTS eap
;
DROP TABLE IF EXISTS depto
;



CREATE TABLE tpobeneficiarioos
(
	CodTipoBeneficiario SMALLINT NOT NULL AUTO_INCREMENT,
	Codigo CHAR(2) NOT NULL DEFAULT '',
	Descripcion VARCHAR(30) NOT NULL DEFAULT '',
	PRIMARY KEY (CodTipoBeneficiario)
) TYPE=MyISAM
;


CREATE TABLE poriginaria
(
	idporiginaria INT(11) NOT NULL AUTO_INCREMENT,
	descripcion VARCHAR(100) NOT NULL DEFAULT '',
	PRIMARY KEY (idporiginaria)
) TYPE=MyISAM
;


CREATE TABLE lengua
(
	idlengua INT(11) NOT NULL AUTO_INCREMENT,
	descripcion VARCHAR(100) NOT NULL DEFAULT '',
	PRIMARY KEY (idlengua)
) TYPE=MyISAM
;


CREATE TABLE historiasClinicas
(
	NumeroPaciente INT(11) NOT NULL DEFAULT 0,
	NumeroGrupoFamiliar INT(11) NOT NULL DEFAULT 0,
	CodEstablecimiento VARCHAR(8) NOT NULL DEFAULT '',
	HistoriaFamiliar VARCHAR(11) NOT NULL DEFAULT '',
	HistoriaPersonal VARCHAR(11) NOT NULL DEFAULT '',
	PRIMARY KEY (NumeroPaciente, NumeroGrupoFamiliar, CodEstablecimiento),
	KEY (CodEstablecimiento),
	KEY (NumeroGrupoFamiliar),
	KEY (NumeroPaciente)
) TYPE=MyISAM
;


CREATE TABLE datosFiliatorios
(
	id_datosfiliatorios INT(11) NOT NULL AUTO_INCREMENT,
	NumeroPaciente INT(11) NOT NULL DEFAULT 0,
	apellidoMadre VARCHAR(25) NOT NULL DEFAULT '',
	nombreMadre VARCHAR(25) NOT NULL DEFAULT '',
	CodTipDocumentoMadre CHAR(2) NOT NULL DEFAULT '',
	NroDocumentoMadre VARCHAR(10) NOT NULL DEFAULT '',
	apellidoPadre VARCHAR(25) NOT NULL DEFAULT '',
	nombrePadre VARCHAR(25) NOT NULL DEFAULT '',
	CodTipDocumentoPadre CHAR(2) NOT NULL DEFAULT '',
	NroDocumentoPadre VARCHAR(10) NOT NULL DEFAULT '',
	apellidoTutor VARCHAR(25) NOT NULL DEFAULT '',
	nombreTutor VARCHAR(25) NOT NULL DEFAULT '',
	CodTipDocumentoTutor CHAR(2) NOT NULL DEFAULT '',
	NroDocumentoTutor VARCHAR(10) NOT NULL DEFAULT '',
	conviveTutor CHAR(1) NOT NULL DEFAULT '',
	PRIMARY KEY (id_datosfiliatorios),
	KEY (NumeroPaciente)
) TYPE=MyISAM
;


CREATE TABLE calles
(
	idCalle INT(11) NOT NULL AUTO_INCREMENT,
	ClaveLocalidad VARCHAR(5) NOT NULL DEFAULT '',
	calle VARCHAR(60) NOT NULL DEFAULT '',
	PRIMARY KEY (idCalle),
	INDEX ClaveLocalidad (ClaveLocalidad ASC),
	INDEX calle (calle ASC)
) TYPE=MyISAM
;


CREATE TABLE antecedentespersonal
(
	NumeroPaciente INT(10) NOT NULL DEFAULT 0,
	IdCepsap SMALLINT NOT NULL DEFAULT 0,
	fechaDiagnostico DATE NOT NULL DEFAULT '0000-00-00',
	observa VARCHAR(200) NOT NULL DEFAULT '',
	PRIMARY KEY (NumeroPaciente, IdCepsap, fechaDiagnostico),
	KEY (NumeroPaciente)
) TYPE=MyISAM
;


CREATE TABLE antecedentesfamiliares
(
	NumeroGrupoFamiliar INT(11) NOT NULL DEFAULT 0,
	HTA SMALLINT NOT NULL DEFAULT 0,
	TBC SMALLINT NOT NULL DEFAULT 0,
	Diabetes SMALLINT NOT NULL DEFAULT 0,
	Dislipemias SMALLINT NOT NULL DEFAULT 0,
	TranstornoNutricion SMALLINT NOT NULL DEFAULT 0,
	Obesidad SMALLINT NOT NULL DEFAULT 0,
	Chagas SMALLINT NOT NULL DEFAULT 0,
	Cancer SMALLINT NOT NULL DEFAULT 0,
	EnfMental SMALLINT NOT NULL DEFAULT 0,
	EnfNeurologica SMALLINT NOT NULL DEFAULT 0,
	Alcoholismo SMALLINT NOT NULL DEFAULT 0,
	Drogas SMALLINT NOT NULL DEFAULT 0,
	Tabaco SMALLINT NOT NULL DEFAULT 0,
	BajoIngreso SMALLINT NOT NULL DEFAULT 0,
	FliaNumerosa SMALLINT NOT NULL DEFAULT 0,
	Promiscuidad SMALLINT NOT NULL DEFAULT 0,
	ETS SMALLINT NOT NULL DEFAULT 0,
	VIH SMALLINT NOT NULL DEFAULT 0,
	Desocupacion SMALLINT NOT NULL DEFAULT 0,
	ParejaInestable SMALLINT NOT NULL DEFAULT 0,
	MPsolo SMALLINT NOT NULL DEFAULT 0,
	Otros SMALLINT NOT NULL DEFAULT 0,
	PRIMARY KEY (NumeroGrupoFamiliar),
	KEY (NumeroGrupoFamiliar)
) TYPE=MyISAM
;


CREATE TABLE tipovivienda
(
	CodTipVivienda CHAR(2) NOT NULL DEFAULT '',
	DescripVivienda CHAR(20) NOT NULL DEFAULT '',
	PRIMARY KEY (CodTipVivienda)
) TYPE=MyISAM
;


CREATE TABLE tipopiso
(
	CodTipPiso CHAR(1) NOT NULL DEFAULT '',
	DescripPiso CHAR(20) NOT NULL DEFAULT '',
	PRIMARY KEY (CodTipPiso)
) TYPE=MyISAM
;


CREATE TABLE tipoparedvivienda
(
	CodTipPared CHAR(1) NOT NULL,
	DescripPared CHAR(20) NOT NULL DEFAULT '',
	PRIMARY KEY (CodTipPared)
) TYPE=MyISAM
;


CREATE TABLE tipoexcretas
(
	CodTipExcretas CHAR(1) NOT NULL DEFAULT '',
	DescripExcretas CHAR(20) NOT NULL DEFAULT '',
	PRIMARY KEY (CodTipExcretas)
) TYPE=MyISAM
;


CREATE TABLE tipodocumento
(
	CodTipDocumento CHAR(1) NOT NULL DEFAULT '',
	DescripDocumento VARCHAR(30) NOT NULL DEFAULT '',
	CodTipDocumentoRed CHAR(3) NOT NULL DEFAULT '',
	PRIMARY KEY (CodTipDocumento)
) TYPE=MyISAM
;


CREATE TABLE sexo
(
	CodSexo CHAR(1) NOT NULL DEFAULT '',
	DescripSexo CHAR(30) NOT NULL DEFAULT '',
	siglaSexo VARCHAR(1) NOT NULL DEFAULT '',
	PRIMARY KEY (CodSexo)
) TYPE=MyISAM
;


CREATE TABLE rtobrsoc_paciente
(
	CodObraSoc VARCHAR(6) NOT NULL DEFAULT '',
	NumeroPaciente INT(11) NOT NULL DEFAULT 0,
	CodTipoBeneficiario SMALLINT NOT NULL DEFAULT 0,
	nroBeneficiario VARCHAR(10) NOT NULL DEFAULT '',
	PRIMARY KEY (CodObraSoc, NumeroPaciente, CodTipoBeneficiario),
	KEY (CodObraSoc),
	KEY (NumeroPaciente),
	KEY (CodTipoBeneficiario)
) TYPE=MyISAM
;


CREATE TABLE provincia
(
	CodProvincia CHAR(2) NOT NULL DEFAULT '',
	NombreProvincia CHAR(30) NOT NULL DEFAULT '',
	PRIMARY KEY (CodProvincia)
) TYPE=MyISAM
;


CREATE TABLE parentesco
(
	CodParentesco CHAR(2) NOT NULL DEFAULT '',
	DescripParentesco CHAR(25) NOT NULL DEFAULT '',
	EdadMinParent TINYINT NOT NULL,
	PRIMARY KEY (CodParentesco)
) TYPE=MyISAM
;


CREATE TABLE paciente
(
	NumeroPaciente INT(11) NOT NULL AUTO_INCREMENT,
	CodOcupacion CHAR(3) NOT NULL DEFAULT '',
	CodEstCiv CHAR(1) NOT NULL DEFAULT '',
	DescripEstCiv VARCHAR(25) NOT NULL DEFAULT '',
	CodParentesco CHAR(2) NOT NULL DEFAULT '',
	CodNivelEduc CHAR(2) NOT NULL DEFAULT '',
	CodEstadoReg CHAR(2) NOT NULL DEFAULT '',
	CodCondicion CHAR(2) NOT NULL DEFAULT '',
	CodPais CHAR(3) NOT NULL DEFAULT '',
	CodSexo CHAR(1) NOT NULL DEFAULT '',
	NumeroGrupoFamiliar INT(11) NOT NULL,
	CodEquipoAtencion INT(11) NOT NULL,
	CodTipDocumento CHAR(2) NOT NULL DEFAULT '',
	ClaseDocumento CHAR(1) NOT NULL DEFAULT 'P',
	CodEquipoMedico INT(11) NOT NULL,
	NroDocumento VARCHAR(10) NOT NULL DEFAULT '',
	Nombre VARCHAR(25) NOT NULL DEFAULT '',
	Apellido VARCHAR(25) NOT NULL DEFAULT '',
	ClaveLocalidad VARCHAR(8) NOT NULL DEFAULT '',
	FechaIngreso DATE NOT NULL,
	Calle VARCHAR(40) NOT NULL DEFAULT '',
	Numero VARCHAR(5) NOT NULL DEFAULT '',
	Piso VARCHAR(5) NOT NULL DEFAULT '',
	Depto CHAR(3) NOT NULL DEFAULT '',
	manzana VARCHAR(17) NOT NULL DEFAULT '',
	entrecalle VARCHAR(27) NOT NULL DEFAULT '',
	ycalle VARCHAR(17) NOT NULL DEFAULT '',
	municipio VARCHAR(13) NOT NULL DEFAULT '',
	CodPostal VARCHAR(4) NOT NULL DEFAULT '',
	Telefono VARCHAR(15) NOT NULL DEFAULT '',
	ApellidoCasada VARCHAR(25) NOT NULL DEFAULT '',
	FechaNacimiento DATE NOT NULL,
	provinciaNacimiento VARCHAR(11) NOT NULL DEFAULT '',
	localidadNacimiento VARCHAR(11) NOT NULL DEFAULT '',
	paisNacimiento VARCHAR(20) NOT NULL DEFAULT '',
	idporiginaria INT(11) NOT NULL DEFAULT 0,
	idlengua INT(11) NOT NULL DEFAULT 0,
	FechaFallecimiento DATE NOT NULL DEFAULT '0000-00-00',
	CodProvincia CHAR(2) NOT NULL DEFAULT '',
	CodParajeBarrio CHAR(3) NOT NULL DEFAULT '',
	seguro CHAR(1) NOT NULL DEFAULT '',
	obra CHAR(1) NOT NULL DEFAULT '',
	observacion VARCHAR(255) NOT NULL DEFAULT '',
	FUENTE VARCHAR(20) NOT NULL DEFAULT '',
	FechaAta DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	UsuarioIngreso VARCHAR(12),
	FechaModificacion DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	UsuarioModificacion VARCHAR(12) NOT NULL DEFAULT '',
	PRIMARY KEY (NumeroPaciente),
	KEY (CodEquipoAtencion),
	KEY (CodEstCiv),
	KEY (CodEquipoMedico),
	KEY (idlengua),
	KEY (ClaveLocalidad),
	KEY (CodNivelEduc),
	KEY (CodOcupacion),
	KEY (CodParentesco),
	KEY (idporiginaria),
	KEY (CodSexo),
	KEY (CodTipDocumento),
	INDEX idx_NumeroGrupoFamiliar (NumeroGrupoFamiliar ASC),
	INDEX Nombre (Nombre ASC),
	INDEX Apellido (Apellido ASC),
	INDEX NroDocumento (NroDocumento ASC)
) TYPE=MyISAM
;


CREATE TABLE ocupacion
(
	CodOcupacion CHAR(3) NOT NULL DEFAULT '',
	DescripOcupacion CHAR(30) NOT NULL DEFAULT '',
	PRIMARY KEY (CodOcupacion)
) TYPE=MyISAM
;


CREATE TABLE obrassociales
(
	CodObraSoc VARCHAR(6) NOT NULL DEFAULT '',
	NomObraSoc VARCHAR(200) NOT NULL DEFAULT '',
	Calle VARCHAR(40) NOT NULL DEFAULT '',
	Numero VARCHAR(5) NOT NULL DEFAULT '',
	Piso VARCHAR(5) NOT NULL DEFAULT '',
	Depto CHAR(3) NOT NULL DEFAULT '',
	CodPostal VARCHAR(4) NOT NULL DEFAULT '',
	PRIMARY KEY (CodObraSoc)
) TYPE=MyISAM
;


CREATE TABLE niveleducacion
(
	CodNivelEduc CHAR(2) NOT NULL DEFAULT '',
	DescripNivelEduc CHAR(30) NOT NULL DEFAULT '',
	PRIMARY KEY (CodNivelEduc)
) TYPE=MyISAM
;


CREATE TABLE localidad
(
	ClaveLocalidad VARCHAR(5) NOT NULL DEFAULT '',
	CodDepartamento CHAR(3) NOT NULL DEFAULT '',
	CodLocalidad CHAR(2) NOT NULL DEFAULT '',
	CodZona CHAR(2) NOT NULL DEFAULT '',
	NombreLocalidad CHAR(40) NOT NULL DEFAULT '',
	CodPostal CHAR(4) NOT NULL DEFAULT '',
	PRIMARY KEY (ClaveLocalidad),
	KEY (CodDepartamento)
) TYPE=MyISAM
;


CREATE TABLE grupofamiliar
(
	NUMPAC INT(11) NOT NULL,
	NumeroGrupoFamiliar INT(11) NOT NULL AUTO_INCREMENT,
	CodTipDocumento CHAR(1) NOT NULL DEFAULT '',
	NroDocumento VARCHAR(10) NOT NULL DEFAULT '',
	Nombre VARCHAR(25) NOT NULL DEFAULT '',
	Apellido VARCHAR(25) NOT NULL DEFAULT '',
	CodTipVivienda CHAR(2) NOT NULL DEFAULT '',
	CodTipPiso CHAR(1) NOT NULL DEFAULT '',
	CodTipPared CHAR(1) NOT NULL DEFAULT '',
	CodTipExcretas CHAR(1) NOT NULL DEFAULT '',
	ClaveLocalidad VARCHAR(5) NOT NULL DEFAULT '',
	LuzElectrica CHAR(1) NOT NULL DEFAULT 'N',
	AguaRed CHAR(1) NOT NULL DEFAULT 'N',
	RecoleccionBasura CHAR(1) NOT NULL DEFAULT 'N',
	CalefaccionGas CHAR(1) NOT NULL DEFAULT 'N',
	CocinaGas CHAR(1) NOT NULL DEFAULT 'N',
	CantidadIntegrantes TINYINT NOT NULL DEFAULT 0,
	CantidadHabitaciones TINYINT NOT NULL DEFAULT 0,
	Calle VARCHAR(40) NOT NULL DEFAULT '',
	Numero VARCHAR(5) NOT NULL DEFAULT '',
	Piso VARCHAR(5) NOT NULL DEFAULT '',
	CodParajeBarrio CHAR(3) NOT NULL DEFAULT '',
	Depto CHAR(3) NOT NULL DEFAULT '',
	manzana VARCHAR(17) NOT NULL DEFAULT '',
	entrecalle VARCHAR(27) NOT NULL DEFAULT '',
	ycalle VARCHAR(17) NOT NULL DEFAULT '',
	Telefono VARCHAR(15) NOT NULL DEFAULT '',
	municipio VARCHAR(13) NOT NULL DEFAULT '',
	CodPostal VARCHAR(4) NOT NULL DEFAULT '',
	FechaAta DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	UsuarioIngreso VARCHAR(12) NOT NULL DEFAULT '',
	FechaModificacion DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	UsuarioModificacion VARCHAR(12) NOT NULL DEFAULT '',
	PRIMARY KEY (NumeroGrupoFamiliar),
	KEY (ClaveLocalidad),
	KEY (CodTipDocumento),
	KEY (CodTipExcretas),
	KEY (CodTipPared),
	KEY (CodTipPiso),
	KEY (CodTipVivienda)
) TYPE=MyISAM
;


CREATE TABLE d_establecimiento
(
	CodBaseReferencial VARCHAR(8) NOT NULL DEFAULT '',
	jerarquia CHAR(1) NOT NULL DEFAULT '',
	CodDepartamento CHAR(3) NOT NULL DEFAULT '',
	NroEstablecimiento VARCHAR(5) NOT NULL DEFAULT '',
	DigitoEstablecimiento CHAR(1) NOT NULL DEFAULT '',
	NombreEstablecimiento VARCHAR(50) NOT NULL DEFAULT '',
	NombreEstRed VARCHAR(30) NOT NULL DEFAULT '',
	cabcoddepest CHAR(3) NOT NULL DEFAULT '',
	cabcodnroest VARCHAR(5) NOT NULL DEFAULT '',
	nodo TINYINT NOT NULL,
	subnodo SMALLINT NOT NULL,
	CodZona CHAR(2) NOT NULL DEFAULT '',
	codlocest CHAR(2) NOT NULL DEFAULT '',
	Calle VARCHAR(40) NOT NULL DEFAULT '',
	Numero VARCHAR(5) NOT NULL DEFAULT '',
	dcpest VARCHAR(4) NOT NULL DEFAULT '',
	Telefono VARCHAR(30) NOT NULL DEFAULT '',
	Email VARCHAR(40) NOT NULL DEFAULT '',
	NivelComplejidad VARCHAR(4) NOT NULL DEFAULT '',
	FechaHabilitacion DATETIME NOT NULL,
	CodProvincia CHAR(2) NOT NULL DEFAULT '',
	CodParajeBarrio CHAR(3) NOT NULL DEFAULT '',
	regjurest VARCHAR(15) NOT NULL DEFAULT '',
	regimenjuridico CHAR(2) NOT NULL DEFAULT '',
	acadmest VARCHAR(15) NOT NULL DEFAULT '',
	fecadmest DATETIME NOT NULL,
	hpaest SMALLINT NOT NULL,
	tipogestion VARCHAR(40) NOT NULL DEFAULT '',
	hpainsest VARCHAR(10) NOT NULL DEFAULT '',
	camaguest SMALLINT NOT NULL,
	camcroest SMALLINT NOT NULL,
	fecactest DATETIME NOT NULL,
	marintest SMALLINT NOT NULL,
	depadmest CHAR(1) NOT NULL DEFAULT '',
	tipifest CHAR(2) NOT NULL DEFAULT '',
	directest VARCHAR(30) NOT NULL DEFAULT '',
	presidest VARCHAR(25) NOT NULL DEFAULT '',
	tesorest VARCHAR(25) NOT NULL DEFAULT '',
	secreest VARCHAR(25) NOT NULL DEFAULT '',
	repestest VARCHAR(25) NOT NULL DEFAULT '',
	repproest VARCHAR(25) NOT NULL DEFAULT '',
	repnopest VARCHAR(25) NOT NULL DEFAULT '',
	repcomest VARCHAR(25) NOT NULL DEFAULT '',
	repcooest VARCHAR(25) NOT NULL DEFAULT '',
	fecapeest DATETIME NOT NULL,
	feccieest DATETIME NOT NULL,
	marbasest SMALLINT NOT NULL,
	marindest SMALLINT NOT NULL,
	marurbest SMALLINT NOT NULL,
	marinfest SMALLINT NOT NULL,
	marenfest SMALLINT NOT NULL,
	rrhest VARCHAR(6) NOT NULL DEFAULT '',
	rendicest VARCHAR(6) NOT NULL DEFAULT '',
	sueldest VARCHAR(6) NOT NULL DEFAULT '',
	CodEstablecimiento VARCHAR(8) NOT NULL DEFAULT '',
	agregacion INT(1) NOT NULL,
	ClaveLocalidad VARCHAR(5) NOT NULL DEFAULT '',
	fechaoper DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (CodEstablecimiento),
	KEY (CodDepartamento),
	KEY (ClaveLocalidad),
	KEY (depadmest)
) TYPE=MyISAM
;


CREATE TABLE equipomedico
(
	CodEquipoMedico INT(11) NOT NULL AUTO_INCREMENT,
	NombreEquipoMedico CHAR(50) NOT NULL DEFAULT '',
	ObservacionesEqMed CHAR(50) NOT NULL DEFAULT '',
	CanBenefEqMed INT(11) NOT NULL,
	CodZona CHAR(2) NOT NULL DEFAULT '',
	PRIMARY KEY (CodEquipoMedico)
) TYPE=MyISAM
;


CREATE TABLE ecivil
(
	CodEstCiv CHAR(1) NOT NULL DEFAULT '',
	DescripEstCiv CHAR(25) NOT NULL DEFAULT '',
	PRIMARY KEY (CodEstCiv)
) TYPE=MyISAM
;


CREATE TABLE eap
(
	CodEquipoAtencion INT(11) NOT NULL AUTO_INCREMENT,
	CodEquipoMedico INT(11) NOT NULL DEFAULT 0,
	CodEstablecimiento VARCHAR(8) NOT NULL DEFAULT '',
	DescripEqAtencion VARCHAR(50) NOT NULL DEFAULT '',
	TopeBeneficiarios INT(11) NOT NULL,
	CodZona CHAR(2) NOT NULL DEFAULT '',
	codigo_pn VARCHAR(10) NOT NULL DEFAULT '',
	PRIMARY KEY (CodEquipoAtencion),
	KEY (CodEstablecimiento),
	KEY (CodEquipoMedico)
) TYPE=MyISAM
;


CREATE TABLE depto
(
	CodDepartamento CHAR(3) NOT NULL DEFAULT '',
	CodProvincia CHAR(2) NOT NULL DEFAULT '',
	NombreDepartamento CHAR(40) NOT NULL DEFAULT '',
	PRIMARY KEY (CodDepartamento)
) TYPE=MyISAM
;






ALTER TABLE historiasClinicas ADD CONSTRAINT FK_historiasClinicas_d_establecimiento 
	FOREIGN KEY (CodEstablecimiento) REFERENCES d_establecimiento (CodEstablecimiento)
;

ALTER TABLE historiasClinicas ADD CONSTRAINT FK_historiasClinicas_grupofamiliar 
	FOREIGN KEY (NumeroGrupoFamiliar) REFERENCES grupofamiliar (NumeroGrupoFamiliar)
;

ALTER TABLE historiasClinicas ADD CONSTRAINT FK_historiasClinicas_paciente 
	FOREIGN KEY (NumeroPaciente) REFERENCES paciente (NumeroPaciente)
;

ALTER TABLE datosFiliatorios ADD CONSTRAINT FK_datosFiliatorios_paciente 
	FOREIGN KEY (NumeroPaciente) REFERENCES paciente (NumeroPaciente)
;

ALTER TABLE calles ADD CONSTRAINT FK_calles_localidad 
	FOREIGN KEY (ClaveLocalidad) REFERENCES localidad (ClaveLocalidad)
;

ALTER TABLE antecedentespersonal ADD CONSTRAINT FK_antecedentespersonal_paciente 
	FOREIGN KEY (NumeroPaciente) REFERENCES paciente (NumeroPaciente)
;

ALTER TABLE antecedentesfamiliares ADD CONSTRAINT FK_antecedentesfamiliares_grupofamiliar 
	FOREIGN KEY (NumeroGrupoFamiliar) REFERENCES grupofamiliar (NumeroGrupoFamiliar)
;

ALTER TABLE rtobrsoc_paciente ADD CONSTRAINT FK_rtobrsoc_paciente_obrassociales 
	FOREIGN KEY (CodObraSoc) REFERENCES obrassociales (CodObraSoc)
;

ALTER TABLE rtobrsoc_paciente ADD CONSTRAINT FK_rtobrsoc_paciente_paciente 
	FOREIGN KEY (NumeroPaciente) REFERENCES paciente (NumeroPaciente)
;

ALTER TABLE rtobrsoc_paciente ADD CONSTRAINT FK_rtobrsoc_paciente_tpobeneficiarioos 
	FOREIGN KEY (CodTipoBeneficiario) REFERENCES tpobeneficiarioos (CodTipoBeneficiario)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_eap 
	FOREIGN KEY (CodEquipoAtencion) REFERENCES eap (CodEquipoAtencion)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_ecivil 
	FOREIGN KEY (CodEstCiv) REFERENCES ecivil (CodEstCiv)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_equipomedico 
	FOREIGN KEY (CodEquipoMedico) REFERENCES equipomedico (CodEquipoMedico)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_grupofamiliar 
	FOREIGN KEY (NumeroGrupoFamiliar) REFERENCES grupofamiliar (NumeroGrupoFamiliar)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_lengua 
	FOREIGN KEY (idlengua) REFERENCES lengua (idlengua)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_localidad 
	FOREIGN KEY (ClaveLocalidad) REFERENCES localidad (ClaveLocalidad)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_niveleducacion 
	FOREIGN KEY (CodNivelEduc) REFERENCES niveleducacion (CodNivelEduc)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_ocupacion 
	FOREIGN KEY (CodOcupacion) REFERENCES ocupacion (CodOcupacion)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_parentesco 
	FOREIGN KEY (CodParentesco) REFERENCES parentesco (CodParentesco)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_poriginaria 
	FOREIGN KEY (idporiginaria) REFERENCES poriginaria (idporiginaria)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_sexo 
	FOREIGN KEY (CodSexo) REFERENCES sexo (CodSexo)
;

ALTER TABLE paciente ADD CONSTRAINT FK_paciente_tipodocumento 
	FOREIGN KEY (CodTipDocumento) REFERENCES tipodocumento (CodTipDocumento)
;

ALTER TABLE localidad ADD CONSTRAINT FK_localidad_depto 
	FOREIGN KEY (CodDepartamento) REFERENCES depto (CodDepartamento)
;

ALTER TABLE grupofamiliar ADD CONSTRAINT FK_grupofamiliar_localidad 
	FOREIGN KEY (ClaveLocalidad) REFERENCES localidad (ClaveLocalidad)
;

ALTER TABLE grupofamiliar ADD CONSTRAINT FK_grupofamiliar_tipodocumento 
	FOREIGN KEY (CodTipDocumento) REFERENCES tipodocumento (CodTipDocumento)
;

ALTER TABLE grupofamiliar ADD CONSTRAINT FK_grupofamiliar_tipoexcretas 
	FOREIGN KEY (CodTipExcretas) REFERENCES tipoexcretas (CodTipExcretas)
;

ALTER TABLE grupofamiliar ADD CONSTRAINT FK_grupofamiliar_tipoparedvivienda 
	FOREIGN KEY (CodTipPared) REFERENCES tipoparedvivienda (CodTipPared)
;

ALTER TABLE grupofamiliar ADD CONSTRAINT FK_grupofamiliar_tipopiso 
	FOREIGN KEY (CodTipPiso) REFERENCES tipopiso (CodTipPiso)
;

ALTER TABLE grupofamiliar ADD CONSTRAINT FK_grupofamiliar_tipovivienda 
	FOREIGN KEY (CodTipVivienda) REFERENCES tipovivienda (CodTipVivienda)
;

ALTER TABLE d_establecimiento ADD CONSTRAINT FK_d_establecimiento_depto 
	FOREIGN KEY (CodDepartamento) REFERENCES depto (CodDepartamento)
;

ALTER TABLE d_establecimiento ADD CONSTRAINT FK_d_establecimiento_localidad 
	FOREIGN KEY (ClaveLocalidad) REFERENCES localidad (ClaveLocalidad)
;

ALTER TABLE eap ADD CONSTRAINT FK_eap_d_establecimiento 
	FOREIGN KEY (CodEstablecimiento) REFERENCES d_establecimiento (CodEstablecimiento)
;

ALTER TABLE eap ADD CONSTRAINT FK_eap_equipomedico 
	FOREIGN KEY (CodEquipoMedico) REFERENCES equipomedico (CodEquipoMedico)
;
