use [TV]
DROP TABLE salary_report
DROP TABLE salary
DROP TABLE corr_spec
DROP TABLE corr_lang
DROP TABLE report
DROP TABLE event
DROP TABLE telephone
DROP TABLE correspondent_table
DROP TABLE operator_tel
DROP TABLE operator
DROP TABLE city
DROP TABLE country
DROP TABLE specifity
DROP TABLE language




set DATEFORMAT dmy

CREATE TABLE correspondent_table (
	correspondent_id INT IDENTITY(1,1) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	middle_name VARCHAR(30),
	birthdate DATE NOT NULL,
	hire_date DATE NOT NULL, 
	home_address VARCHAR(100) NOT NULL,
	homecity_id INT NOT NULL,
	location_id INT NOT NULL,
	email VARCHAR(50) NOT NULL,
	status VARCHAR(20) NOT NULL,
	CONSTRAINT pk_correspondent PRIMARY KEY (correspondent_id) );

CREATE TABLE salary (
	salary_id INT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_salary PRIMARY KEY (salary_id),
	correspondent_id INT NOT NULL,
	CONSTRAINT fk_salary_corr FOREIGN KEY (correspondent_id) REFERENCES correspondent_table(correspondent_id),
	[date] datetime CONSTRAINT df_salary_date DEFAULT(getdate()) NOT NULL,
	salary_value NUMERIC(18,2),
	danger_award INT CONSTRAINT df_award_danger_value DEFAULT (0) NOT NULL,
	info varchar(100) );

CREATE TABLE telephone (
	correspondent_id INT NOT NULL,
	telephone VARCHAR(20) NOT NULL,
	type VARCHAR(10) NOT NULL,
	CONSTRAINT pk_telephone PRIMARY KEY (correspondent_id, telephone) );

CREATE TABLE corr_lang (
	correspondent_id INT NOT NULL,
	language_id SMALLINT NOT NULL,
	CONSTRAINT pk_corr_lang PRIMARY KEY (correspondent_id, language_id) );

CREATE TABLE language (
	language_id SMALLINT IDENTITY(1,1) NOT NULL,  
	CONSTRAINT pk_language PRIMARY KEY (language_id),
	name VARCHAR(30) NOT NULL );

CREATE TABLE city (
	city_id INT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_city PRIMARY KEY (city_id),
	name VARCHAR(20) NOT NULL,
	country_id SMALLINT NOT NULL );

CREATE TABLE country (
	country_id SMALLINT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_country PRIMARY KEY (country_id),
	name VARCHAR(20) NOT NULL );

CREATE TABLE corr_spec (
	correspondent_id INT NOT NULL,
	specifity_id SMALLINT NOT NULL,
	CONSTRAINT pk_corr_spec PRIMARY KEY (correspondent_id, specifity_id) );

CREATE TABLE specifity (
	specifity_id SMALLINT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_specifity PRIMARY KEY (specifity_id),
	name VARCHAR(30) NOT NULL );

CREATE TABLE operator (
	operator_id SMALLINT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_operator PRIMARY KEY (operator_id),	
	name VARCHAR(50) NOT NULL,
	status VARCHAR(20) NOT NULL,
	location_id INT NOT NULL );

CREATE TABLE operator_tel (
	operator_id SMALLINT NOT NULL,
	type VARCHAR(10) NOT NULL,
	telephone VARCHAR(20) NOT NULL,
	CONSTRAINT pk__oper_tel PRIMARY KEY (operator_id, telephone) );

CREATE TABLE report (
	report_id INT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_report PRIMARY KEY (report_id),
	correspondent_id INT NOT NULL,
	operator_id SMALLINT NOT NULL,
	event_id INT NOT NULL,
	duration SMALLINT,
	quality SMALLINT,
	[date] DATE,
	newscast_time TIME,
	is_video BIT,
	rating NUMERIC(3,2) );

CREATE TABLE event (
	event_id INT IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_event PRIMARY KEY (event_id),
	name VARCHAR(100) NOT NULL,
	[date] DATETIME CONSTRAINT df_event_date DEFAULT (getdate()) NOT NULL,
	city_id INT,
	danger SMALLINT,
	place VARCHAR(50),
	specifity_id SMALLINT NOT NULL );



CREATE TABLE salary_report (
	salary_id INT NOT NULL,
	report_id INT NOT NULL,
	CONSTRAINT fk_salary__salary FOREIGN KEY (salary_id) REFERENCES salary(salary_id),
	CONSTRAINT fk_salary__report FOREIGN KEY (report_id) REFERENCES report(report_id) );

ALTER TABLE correspondent_table ADD
	CONSTRAINT fk_corr_homecity FOREIGN KEY (homecity_id) REFERENCES city(city_id),
	CONSTRAINT fk_corr_city FOREIGN KEY (location_id) REFERENCES city(city_id),
	CONSTRAINT ck_corr_status CHECK (status in ('активный', 'отпуск', 'болеет'))
	/*CONSTRAINT ck_corr_danger_award CHECK (danger_award > 0)*/

ALTER TABLE city ADD
	CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country(country_id)

ALTER TABLE corr_spec ADD
	CONSTRAINT fk_corr_spec__corr FOREIGN KEY (correspondent_id) REFERENCES correspondent_table(correspondent_id),
	CONSTRAINT fk_corr_spec__spec FOREIGN KEY (specifity_id) REFERENCES specifity(specifity_id)

ALTER TABLE report ADD
	CONSTRAINT fk_report_corr FOREIGN KEY (correspondent_id) REFERENCES correspondent_table(correspondent_id),
	CONSTRAINT fk_report_event FOREIGN KEY (event_id) REFERENCES event(event_id),
	CONSTRAINT fk_report_operator FOREIGN KEY (operator_id) REFERENCES operator(operator_id),
	CONSTRAINT ck_report_quality CHECK (quality >= 1 AND quality <= 3),
	CONSTRAINT ck_report_rating CHECK (rating >= 0 AND rating <= 5),
	CONSTRAINT ck_report__is_video CHECK (is_video in (0, 1))

ALTER TABLE event ADD
	CONSTRAINT fk_event_city FOREIGN KEY (city_id) REFERENCES city(city_id),
	CONSTRAINT fk_event_spec FOREIGN KEY (specifity_id) REFERENCES specifity(specifity_id),
	CONSTRAINT ck_event_danger CHECK (danger >= 0 AND danger <= 3)

ALTER TABLE telephone ADD
	CONSTRAINT fk_tel_corr FOREIGN KEY (correspondent_id) REFERENCES correspondent_table(correspondent_id),
	CONSTRAINT ck_telephone CHECK (type in ('рабочий', 'домашний')),
	CONSTRAINT ck_tel_plus CHECK (SUBSTRING(telephone, 1, 1) = '+'),
	CONSTRAINT ck_tel_len CHECK (LEN(telephone) = 12),
	CONSTRAINT ck_tel_dig CHECK (ISNUMERIC(telephone) = 1)

ALTER TABLE corr_lang ADD
	CONSTRAINT fk_corr_lang__corr FOREIGN KEY (correspondent_id) REFERENCES correspondent_table(correspondent_id),
	CONSTRAINT fk_corr_lang__lang FOREIGN KEY (language_id) REFERENCES language(language_id)

ALTER TABLE operator ADD
	CONSTRAINT fk_operator_city FOREIGN KEY (location_id) REFERENCES city(city_id),
	CONSTRAINT ck_operator_status CHECK (status in ('активный', 'отпуск', 'болеет'))

ALTER TABLE operator_tel ADD
	CONSTRAINT fk_operator_tel__operator FOREIGN KEY (operator_id) REFERENCES operator(operator_id),
	CONSTRAINT ck_operator_tel CHECK (type in ('рабочий', 'домашний'))



CREATE UNIQUE INDEX ix_correspondent on correspondent_table(email);
CREATE UNIQUE INDEX ix_language on language(name);
CREATE UNIQUE INDEX ix_specifity on specifity(name);
CREATE UNIQUE INDEX ix_country on country(name);
CREATE UNIQUE INDEX ix_telephone on telephone(telephone);
CREATE UNIQUE INDEX ix_operator_tel on operator_tel(telephone); 
