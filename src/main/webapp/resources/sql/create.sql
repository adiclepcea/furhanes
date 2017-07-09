--users
CREATE TABLE users
(
    id integer not null,
    username varchar(20),
    pass varchar(256),
    first_name varchar(100),
    last_name varchar(200),
    email varchar(2050),
    enabled smallint,
    CONSTRAINT PK_USERS
        PRIMARY KEY (id)
);

--ALTER TABLE USERS ADD 
--first_name Varchar(100);
--ALTER TABLE USERS ADD 
--last_name Varchar(200);
--ALTER TABLE USERS ADD 
--email Varchar(250);

CREATE GENERATOR GEN_USERS_ID;

SET TERM !! ;
CREATE TRIGGER USERS_BI FOR USERS
ACTIVE BEFORE INSERT POSITION 0
AS
DECLARE VARIABLE tmp DECIMAL(18,0);
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(GEN_USERS_ID, 1);
  ELSE
  BEGIN
    tmp = GEN_ID(GEN_USERS_ID, 0);
    if (tmp < new.ID) then
      tmp = GEN_ID(GEN_USERS_ID, new.ID-tmp);
  END
END!!
SET TERM ; !!


GRANT SELECT,INSERT,UPDATE,DELETE,REFERENCES ON USERS TO roskofur;

insert into users (username, pass, enabled) values('administrator','2bb80d537b1da3e38bd30361aa855686bde0eacd7162fef6a25fe97bf527a25b',1);

--roles
CREATE TABLE roles
(
    id integer not null,
    name varchar(50),
    
    CONSTRAINT pk_roles
        PRIMARY KEY (id),
    constraint uq_roles_name
        UNIQUE      (name)
);

CREATE GENERATOR GEN_ROLES_ID;

SET TERM !! ;
CREATE TRIGGER ROLES_BI FOR ROLES
ACTIVE BEFORE INSERT POSITION 0
AS
DECLARE VARIABLE tmp DECIMAL(18,0);
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(GEN_ROLES_ID, 1);
  ELSE
  BEGIN
    tmp = GEN_ID(GEN_ROLES_ID, 0);
    if (tmp < new.ID) then
      tmp = GEN_ID(GEN_ROLES_ID, new.ID-tmp);
  END
END!!
SET TERM ; !!


GRANT SELECT,INSERT,UPDATE,DELETE,REFERENCES ON ROLES TO roskofur;


--rights

CREATE TABLE rights
(
    id integer not null,
    name varchar(100),
    CONSTRAINT pk_rights
        PRIMARY KEY (id),
    CONSTRAINT uq_rights_name UNIQUE (name)
);

CREATE GENERATOR GEN_RIGHTS_ID;

SET TERM !! ;
CREATE TRIGGER RIGHTS_BI FOR RIGHTS
ACTIVE BEFORE INSERT POSITION 0
AS
DECLARE VARIABLE tmp DECIMAL(18,0);
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(GEN_RIGHTS_ID, 1);
  ELSE
  BEGIN
    tmp = GEN_ID(GEN_RIGHTS_ID, 0);
    if (tmp < new.ID) then
      tmp = GEN_ID(GEN_RIGHTS_ID, new.ID-tmp);
  END
END!!
SET TERM ; !!

GRANT SELECT,INSERT,UPDATE,DELETE,REFERENCES ON RIGHTS TO roskofur;

insert into RIGHTS(NAME) values('ROLE_RIGHT_HOME');
insert into RIGHTS(NAME) values('ROLE_RIGHT_PO');
insert into RIGHTS(NAME) values('ROLE_RIGHT_SUPPLIERS');
insert into RIGHTS(NAME) values('ROLE_RIGHT_RECEPTIONS');
insert into RIGHTS(NAME) values('ROLE_RIGHT_STOCK');
insert into RIGHTS(NAME) values('ROLE_RIGHT_USERS');
insert into RIGHTS(NAME) values('ROLE_RIGHT_CONTRACTS');
insert into RIGHTS(NAME) values('ROLE_RIGHT_CONTRACTS_W');
insert into RIGHTS(NAME) values('ROLE_RIGHT_SUPPLIERS_W');
insert into RIGHTS(NAME) values('ROLE_RIGHT_PO_W');
insert into RIGHTS(NAME) values('ROLE_RIGHT_STOCK_W');
insert into RIGHTS(NAME) values('ROLE_RIGHT_USERS_W');


--users2roles
CREATE TABLE users2roles
(
    id integer not null,
    users_id integer not null,
    roles_id integer not null,
    CONSTRAINT pk_users2roles
        PRIMARY KEY (id),
    CONSTRAINT pk_users_users2roles FOREIGN KEY (users_id) REFERENCES users (id),
    CONSTRAINT pk_roles_users2roles FOREIGN KEY (roles_id) REFERENCES roles (id)
);

CREATE GENERATOR GEN_USERS2ROLES_ID;

SET TERM !! ;
CREATE TRIGGER USERS2ROLES_BI FOR USERS2ROLES
ACTIVE BEFORE INSERT POSITION 0
AS
DECLARE VARIABLE tmp DECIMAL(18,0);
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(GEN_USERS2ROLES_ID, 1);
  ELSE
  BEGIN
    tmp = GEN_ID(GEN_USERS2ROLES_ID, 0);
    if (tmp < new.ID) then
      tmp = GEN_ID(GEN_USERS2ROLES_ID, new.ID-tmp);
  END
END!!
SET TERM ; !!

GRANT SELECT,INSERT,UPDATE,DELETE,REFERENCES ON USERS2ROLES TO roskofur;
insert into users2roles(users_id, roles_id) values(1,1);

--roles2rights
CREATE TABLE roles2rights
(
    id integer not null,
    roles_id integer not null,
    rights_id integer not null,
    CONSTRAINT pk_roles2rights
        PRIMARY KEY (id),
    constraint fk_roles_roles2rights FOREIGN KEY (roles_id) REFERENCES roles (id),
    constraint fk_rights_roles2rights    FOREIGN KEY (rights_id) REFERENCES rights (id)
);

CREATE GENERATOR GEN_ROLES2RIGHTS_ID;

SET TERM !! ;
CREATE TRIGGER ROLES2RIGHTS_BI FOR ROLES2RIGHTS
ACTIVE BEFORE INSERT POSITION 0
AS
DECLARE VARIABLE tmp DECIMAL(18,0);
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(GEN_ROLES2RIGHTS_ID, 1);
  ELSE
  BEGIN
    tmp = GEN_ID(GEN_ROLES2RIGHTS_ID, 0);
    if (tmp < new.ID) then
      tmp = GEN_ID(GEN_ROLES2RIGHTS_ID, new.ID-tmp);
  END
END!!
SET TERM ; !!

GRANT SELECT,INSERT,UPDATE,DELETE,REFERENCES ON ROLES2RIGHTS TO roskofur;

insert into ROLES2RIGHTS (ROLES_ID,RIGHTS_ID) values(1,1);
insert into ROLES2RIGHTS (ROLES_ID,RIGHTS_ID) values(1,2);
insert into ROLES2RIGHTS (ROLES_ID,RIGHTS_ID) values(1,3);
insert into ROLES2RIGHTS (ROLES_ID,RIGHTS_ID) values(1,4);
insert into ROLES2RIGHTS (ROLES_ID,RIGHTS_ID) values(1,5);
insert into ROLES2RIGHTS (ROLES_ID,RIGHTS_ID) values(1,6);
Insert into ROLES2RIGHTS (ROLES_ID, RIGHTS_ID) values(1,7);
Insert into ROLES2RIGHTS (ROLES_ID, RIGHTS_ID) values(1,8);
Insert into ROLES2RIGHTS (ROLES_ID, RIGHTS_ID) values(1,9);
Insert into ROLES2RIGHTS (ROLES_ID, RIGHTS_ID) values(1,10);
Insert into ROLES2RIGHTS (ROLES_ID, RIGHTS_ID) values(1,11);
Insert into ROLES2RIGHTS (ROLES_ID, RIGHTS_ID) values(1,12);

--suppliers

CREATE TABLE suppliers
(
    id integer not null,
    name varchar(300),
    address varchar(400),
    cui varchar(20),
    j varchar(20),
    bank varchar(300),
    iban varchar(34),
    swift varchar(11),
    phone varchar(200),
    fax varchar(200),
    mail varchar(300),
    
    CONSTRAINT pk_suppliers
        PRIMARY KEY (id),
    constraint uq_cui_suppliers
        unique (cui),
    constraint uq_j_suppliers
        unique (j)
);


CREATE GENERATOR GEN_SUPPLIERS_ID;

SET TERM !! ;
CREATE TRIGGER SUPPLIERS_BI FOR SUPPLIERS
ACTIVE BEFORE INSERT POSITION 0
AS
DECLARE VARIABLE tmp DECIMAL(18,0);
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(GEN_SUPPLIERS_ID, 1);
  ELSE
  BEGIN
    tmp = GEN_ID(GEN_SUPPLIERS_ID, 0);
    if (tmp < new.ID) then
      tmp = GEN_ID(GEN_SUPPLIERS_ID, new.ID-tmp);
  END
END!!
SET TERM ; !!


GRANT SELECT,INSERT,UPDATE,DELETE,REFERENCES ON SUPPLIERS TO roskofur;

--contracts
CREATE TABLE contracts
(
    id integer not null,
    suppliers_id integer not null,
    contract_date date,
    internal_number integer,
    expiration_date date,
    undefinite smallint default 0,
    contract_object varchar(300),
    contact_person integer,
    filed varchar(50),
    payment_term integer,
    scan_file varchar(1000),
    original_file_name varchar(1000),
    observations varchar(500),
    do_not_renew smallint default 0,
    CONSTRAINT pk_contracts 
        PRIMARY KEY (id),
    constraint fk_suppliers_contracts
        FOREIGN KEY (SUPPLIERS_ID) REFERENCES SUPPLIERS (ID)

);

GRANT SELECT,INSERT,UPDATE,DELETE ON CONTRACTS TO roskofur;

CREATE GENERATOR GEN_CONTRACTS_ID;

SET TERM !! ;
CREATE TRIGGER CONTRACTS_BI FOR CONTRACTS
ACTIVE BEFORE INSERT POSITION 0
AS
DECLARE VARIABLE tmp DECIMAL(18,0);
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(GEN_CONTRACTS_ID, 1);
  ELSE
  BEGIN
    tmp = GEN_ID(GEN_CONTRACTS_ID, 0);
    if (tmp < new.ID) then
      tmp = GEN_ID(GEN_CONTRACTS_ID, new.ID-tmp);
  END
END!!
SET TERM ; !!

--contacts
CREATE TABLE contacts
(
    ID integer not null,
    NAME varchar(200),
    SURNAME varchar(250),
    TITLE varchar(20),
    CONTACT_FUNCTION varchar(200),
    MAIL varchar(400),
    FAX varchar(200),
    PHONE varchar(200),
    MOBILE_PHONE varchar(200),
    OBSERVATIONS varchar(500),
    SUPPLIERS_ID integer not null,
    
    CONSTRAINT PK_CONTACTS
        PRIMARY KEY (ID),
    constraint FK_SUPPLIERS_CONTACTS
        FOREIGN KEY (SUPPLIERS_ID) REFERENCES SUPPLIERS (ID)
        
);

GRANT SELECT,INSERT,UPDATE,DELETE ON CONTACTS TO roskofur;

CREATE GENERATOR GEN_CONTACTS_ID;

SET TERM !! ;
CREATE TRIGGER CONTACTS_BI FOR CONTACTS
ACTIVE BEFORE INSERT POSITION 0
AS
DECLARE VARIABLE tmp DECIMAL(18,0);
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(GEN_CONTACTS_ID, 1);
  ELSE
  BEGIN
    tmp = GEN_ID(GEN_CONTACTS_ID, 0);
    if (tmp < new.ID) then
      tmp = GEN_ID(GEN_CONTACTS_ID, new.ID-tmp);
  END
END!!
SET TERM ; !!


