--users
CREATE TABLE users
(
    id integer not null,
    username varchar(20),
    password varchar(256),
    name varchar(250),
    mail varchar(100),
    CONSTRAINT PK_USERS
        PRIMARY KEY (id)
);

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
