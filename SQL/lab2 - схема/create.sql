set DATEFORMAT dmy

CREATE TABLE correspondent (
	correspondent_id SMALLINT IDENTITY(1,1) NOT NULL,
	last_name VARCHAR(30),
	first_name VARCHAR(30),
	middle_name VARCHAR,
	birthdate DATE,
	hire_date DATE, 
	home_address VARCHAR(50),
	salary NUMERIC(7,2),
	award NUMERIC(7,2),
	location_id SMALLINT NOT NULL,
	email VARCHAR(50),
	is_active SMALLINT,
	CONSTRAINT pk_correspondent PRIMARY KEY (correspondent_id) );

CREATE TABLE telephone (
	correspondent_id SMALLINT NOT NULL,
	telephone VARCHAR(15),
	type VARCHAR(10),
	CONSTRAINT pk_telephone PRIMARY KEY (correspondent_id, telephone) );

CREATE TABLE corr_lang (
	correspondent_id SMALLINT NOT NULL,
	language_id SMALLINT NOT NULL,
	CONSTRAINT pk_corr_lang PRIMARY KEY (correspondent_id, language_id) );

CREATE TABLE language (
	language_id SMALLINT IDENTITY(1,1) NOT NULL,  
	CONSTRAINT pk_language PRIMARY KEY (language_id),
	name VARCHAR(20) );

CREATE TABLE city (
	city_id SMALLINT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_city PRIMARY KEY (city_id),
	country_id SMALLINT NOT NULL,
	name VARCHAR(20) );

CREATE TABLE country (
	country_id SMALLINT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_country PRIMARY KEY (country_id),
	name VARCHAR(20) );

CREATE TABLE corr_spec (
	correspondent_id SMALLINT NOT NULL,
	specifity_id SMALLINT NOT NULL,
	CONSTRAINT pk_corr_spec PRIMARY KEY (correspondent_id, specifity_id) );

CREATE TABLE specifity (
	specifity_id SMALLINT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_specifity PRIMARY KEY (specifity_id),
	name VARCHAR(15) );

CREATE TABLE operator (
	operator_id SMALLINT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_operator PRIMARY KEY (operator_id),	
	name VARCHAR(30),
	is_active SMALLINT,
	location_id SMALLINT NOT NULL );

CREATE TABLE operator_tel (
	operator_id SMALLINT NOT NULL,
	type VARCHAR(10),
	telephone VARCHAR(15),
	CONSTRAINT pk__oper_tel PRIMARY KEY (operator_id, telephone) );

CREATE TABLE report (
	CONSTRAINT pk_report PRIMARY KEY(event_id, correspondent_id),
	correspondent_id SMALLINT NOT NULL,
	operator_id SMALLINT NOT NULL,
	event_id SMALLINT NOT NULL,
	duration INTEGER,
	quality SMALLINT,
	report_date DATE,
	newscast_time TIME,
	is_video SMALLINT,
	rating SMALLINT );

CREATE TABLE event (
	event_id SMALLINT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_event PRIMARY KEY (event_id),
	[date] DATETIME CONSTRAINT df_event_date DEFAULT (getdate()),
	city_id SMALLINT NOT NULL,
	danger SMALLINT,
	place VARCHAR(15),
	class VARCHAR(15) );



ALTER TABLE correspondent ADD
	CONSTRAINT fk_corr_city FOREIGN KEY (location_id) REFERENCES city(city_id),
	CONSTRAINT ck_corr_active CHECK (is_active in (0, 1)), 
	CONSTRAINT ck_corr_age CHECK (YEAR(getdate()) - YEAR(birthdate) >=  18) 

ALTER TABLE city ADD
	CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country(country_id)

ALTER TABLE corr_spec ADD
	CONSTRAINT fk_corr_spec__corr FOREIGN KEY (correspondent_id) REFERENCES correspondent(correspondent_id),
	CONSTRAINT fk_corr_spec__spec FOREIGN KEY (specifity_id) REFERENCES specifity(specifity_id)

ALTER TABLE report ADD
	CONSTRAINT fk_report_corr FOREIGN KEY (correspondent_id) REFERENCES correspondent(correspondent_id),
	CONSTRAINT fk_report_event FOREIGN KEY (event_id) REFERENCES event(event_id),
	CONSTRAINT fk_report_operator FOREIGN KEY (operator_id) REFERENCES operator(operator_id),
	CONSTRAINT ck_report_quality CHECK (quality > 0 AND quality < 5),
	CONSTRAINT ck_report__is_video CHECK (is_video in (0, 1))

ALTER TABLE event ADD
	CONSTRAINT fk_event_city FOREIGN KEY (city_id) REFERENCES city(city_id),
	CONSTRAINT ck_event_danger CHECK (danger > 0 AND danger < 5)

ALTER TABLE telephone ADD
	CONSTRAINT fk_tel_corr FOREIGN KEY (correspondent_id) REFERENCES correspondent(correspondent_id)

ALTER TABLE corr_lang ADD
	CONSTRAINT fk_corr_lang__corr FOREIGN KEY (correspondent_id) REFERENCES correspondent(correspondent_id),
	CONSTRAINT fk_corr_lang__lang FOREIGN KEY (language_id) REFERENCES language(language_id)

ALTER TABLE operator ADD
	CONSTRAINT fk_operator_city FOREIGN KEY (location_id) REFERENCES city(city_id),
	CONSTRAINT ck_operator_active CHECK (is_active in (0, 1))

ALTER TABLE operator_tel ADD
	CONSTRAINT fk_operator_tel__operator FOREIGN KEY (operator_id) REFERENCES operator(operator_id)


CREATE UNIQUE INDEX ix_correspondent on correspondent(email);
CREATE UNIQUE INDEX ix_language on language(name);
CREATE UNIQUE INDEX ix_specifity on specifity(name);
CREATE UNIQUE INDEX ix_country on country(name);
CREATE UNIQUE INDEX ix_telephone on telephone(telephone);
CREATE UNIQUE INDEX ix_oper_tel on operator_tel(telephone); 
