CREATE TABLE menu(
  menuID              VARCHAR(20) NOT NULL ,
  CONSTRAINT menu_pk  PRIMARY KEY (menuID)
);

CREATE TABLE buffet(
  menuID                VARCHAR(20) NOT NULL ,
  fixedRate             FLOAT(4,2) NOT NULL,
  ageRange         VARCHAR(10) NOT NULL,
  CONSTRAINT buffet_pk  PRIMARY KEY (menuID, ageRange),
  CONSTRAINT buffet_fk  FOREIGN KEY (menuID) REFERENCES menu (menuID)
);

CREATE TABLE aLaCarte(
  menuID                  VARCHAR(20) NOT NULL ,
  menuType                VARCHAR(20),
  CONSTRAINT aLaCarte_pk  PRIMARY KEY (menuID),
  CONSTRAINT aLaCarte_fk  FOREIGN KEY (menuID) REFERENCES menu (menuID)
);

CREATE TABLE spiceLevelEnum(
  spiceLevel                    ENUM('Mild', 'Tangy', 'Piquant', 'Hot', 'Oh My God') NOT NULL,
  CONSTRAINT spiceLevelEnum_pk  PRIMARY KEY (spiceLevel)
);

CREATE TABLE entreeEnum(
  entree                ENUM('Chef Special', 'Pork', 'Beef', 'Chicken', 'Seafood', 'Vegetables'),
  CONSTRAINT entree_pk  PRIMARY KEY (entree)
);

CREATE TABLE menuItem(
  itemID                   VARCHAR(20) NOT NULL ,
  itemName                 VARCHAR(60) NOT NULL ,
  spiceLevel               ENUM ('Mild', 'Tangy', 'Piquant', 'Hot', 'Oh My God') NOT NULL,
  entree                   ENUM('Chef Special', 'Pork', 'Beef', 'Chicken', 'Seafood', 'Vegetables'),
  CONSTRAINT menuItem_pk   PRIMARY KEY (itemID),
  CONSTRAINT menuItem_fk1  FOREIGN KEY (spiceLevel) REFERENCES spiceLevelEnum (spiceLevel),
  CONSTRAINT menuItem_fk2  FOREIGN KEY (entree)     REFERENCES entreeEnum (entree)
);

CREATE TABLE menuMenuItem(
  menuID                       VARCHAR(20) NOT NULL ,
  itemID                       VARCHAR(20) NOT NULL ,
  itemPrice                    FLOAT(5,2) NOT NULL,
  size                         VARCHAR(20),
  CONSTRAINT menuMenuItem_pk   PRIMARY KEY (menuID, itemID),
  CONSTRAINT menuMenuItem_fk1  FOREIGN KEY (menuID) REFERENCES menu (menuID),
  CONSTRAINT menuMenuItem_fk2  FOREIGN KEY (itemID) REFERENCES menuItem (itemID)
);

CREATE TABLE categoryEnum (
  category                     ENUM('Appetizer', 'Soup', 'Meat Entrees', 'Chow Mein', 'Egg Foo Young', 'Chop Suey') NOT NULL,
  CONSTRAINT catergoryEnum_pk  PRIMARY KEY (category)
);

CREATE TABLE menuItemCategory(
  itemID                           VARCHAR(20) NOT NULL ,
  category                         ENUM('Appetizer', 'Soup', 'Meat Entrees', 'Chow Mein', 'Egg Foo Young', 'Chop Suey') NOT NULL ,
  CONSTRAINT menuItemCategory_pk   PRIMARY KEY (itemId, category),
  CONSTRAINT menuItemCategory_fk1  FOREIGN KEY (itemID)   REFERENCES menuItem (itemID),
  CONSTRAINT menuItemCategory_fk2  FOREIGN KEY (category) REFERENCES categoryEnum (category)
);

CREATE TABLE customer(
  customerID              VARCHAR(20) NOT NULL,
  cFirstName              VARCHAR(20),
  cLastName            VARCHAR(20),
  CONSTRAINT customer_pk  PRIMARY KEY (customerID)
);

CREATE TABLE orders(
  orderID              VARCHAR(20) NOT NULL,
  orderDate            DATE NOT NULL,
  totalAmount          FLOAT(6,2) NOT NULL,
  customerID           VARCHAR(20) NOT NULL,
  gratuityGiven         FLOAT(5,2),
  CONSTRAINT order_pk  PRIMARY KEY (orderID),
  CONSTRAINT order_fk  FOREIGN KEY (customerID) REFERENCES customer (customerID)
);

CREATE TABLE orderDetail(
  menuID                      VARCHAR(20) NOT NULL ,
  itemID                      VARCHAR(20) NOT NULL ,
  orderID                     VARCHAR(20) NOT NULL,
  quantity                    INT,
  CONSTRAINT orderDetail_pk   PRIMARY KEY (menuID, itemID, orderID),
  CONSTRAINT orderDetail_fk1  FOREIGN KEY (menuID, itemID) REFERENCES menuMenuItem (menuID, itemID),
  CONSTRAINT orderDetail_fk2  FOREIGN KEY (orderID)        REFERENCES orders (orderID)
);

CREATE TABLE member(
  customerID            VARCHAR(20) NOT NULL,
  cAge                  INT NOT NULL ,
  cPhoneNum             VARCHAR(20) NOT NULL ,
  cEmail                VARCHAR(50) NOT NULL ,
  CONSTRAINT member_pk  PRIMARY KEY (customerID),
  CONSTRAINT member_fk  FOREIGN KEY (customerID) REFERENCES customer (customerID),
  CONSTRAINT member_ck  UNIQUE KEY (cEmail)
);

CREATE TABLE account(
  customerID             VARCHAR(20) NOT NULL ,
  mimingMoney            INT,
  CONSTRAINT account_pk  PRIMARY KEY (customerID),
  CONSTRAINT account_fk  FOREIGN KEY (customerID) REFERENCES member (customerID)
);

CREATE TABLE individual(
  customerID                VARCHAR(20) NOT NULL,
  snailMail                 VARCHAR(60),
  CONSTRAINT individual_pk  PRIMARY KEY (customerID),
  CONSTRAINT individual_fk  FOREIGN KEY (customerID) REFERENCES member (customerID)
);

CREATE TABLE corporation(
  customerID                 VARCHAR(20) NOT NULL,
  corporationName            VARCHAR(20) NOT NULL,
  organizationName           VARCHAR(20) NOT NULL,
  officeAddress              VARCHAR(60) NOT NULL,
  CONSTRAINT corporation_pk  PRIMARY KEY(customerID),
  CONSTRAINT corporation_fk  FOREIGN KEY(customerID) REFERENCES member (customerID)
);

CREATE TABLE payment(
  paymentNum             VARCHAR(20) NOT NULL,
  paymentDate            DATE,
  orderID                VARCHAR(20) NOT NULL,
  CONSTRAINT payment_pk  PRIMARY KEY (paymentNum),
  CONSTRAINT payment_fk  FOREIGN KEY (orderID) REFERENCES orders (orderID)
);

CREATE TABLE cash(
  paymentNum          VARCHAR(20) NOT NULL,
  CONSTRAINT cash_pk  PRIMARY KEY (paymentNum),
  CONSTRAINT cash_fk  FOREIGN KEY (paymentNum) REFERENCES payment (paymentNum)
);

CREATE TABLE card(
  paymentNum          VARCHAR(20) NOT NULL ,
  cardType            VARCHAR(25) NOT NULL ,
  minCharge           FLOAT(4, 2) NOT NULL ,
  paymentSplit        FLOAT(5, 2),
  CONSTRAINT card_pk  PRIMARY KEY (paymentNum),
  CONSTRAINT card_fk  FOREIGN KEY (paymentNum) REFERENCES payment (paymentNum)
);

CREATE TABLE togo(
  orderID             VARCHAR(20) NOT NULL,
  orderStatus         VARCHAR(20) NOT NULL,
  orderMethod         VARCHAR(20) NOT NULL,
  pickUpTime          TIME,
  readyTime           TIME,
  CONSTRAINT togo_pk  PRIMARY KEY (orderID),
  CONSTRAINT togo_fk  FOREIGN KEY (orderID) REFERENCES orders (orderID),
  CONSTRAINT togo_ck  UNIQUE KEY (orderMethod, pickUpTime, readyTime)
);

CREATE TABLE shift(
  shiftType          VARCHAR(20) NOT NULL,
  startTime          TIMESTAMP,
  endTime            TIMESTAMP,
  CONSTRAINT shift_pk  PRIMARY KEY (shiftType, startTime, endTime)
);

CREATE TABLE job(
  jobTitle                         VARCHAR(20) NOT NULL,
  jobDescription              VARCHAR(200) NOT NULL ,
  CONSTRAINT job_pk  PRIMARY KEY (jobTitle)
);

CREATE TABLE employee(
  eid                       VARCHAR(20) NOT NULL,
  eFirstName    VARCHAR(20) NOT NULL ,
  eLastName               VARCHAR(20) NOT NULL ,
  eDOB    DATE NOT NULL,
  shiftType                   VARCHAR(20) NOT NULL,
  jobTitle                    VARCHAR(20) NOT NULL ,
  managerID                 VARCHAR(20) ,
  CONSTRAINT employee_pk    PRIMARY KEY (eid),
  CONSTRAINT employee_fk1   FOREIGN KEY (shiftType) REFERENCES shift (shiftType),
  CONSTRAINT employeee_fk2  FOREIGN KEY (jobTitle) REFERENCES job (jobTitle),
  CONSTRAINT employee_fk3   FOREIGN KEY (managerID) REFERENCES employee (eID),
  CONSTRAINT employee_ck    UNIQUE KEY (eFirstName, eLastName, eDOB)
);

CREATE TABLE salaryStaff(
  eid                        VARCHAR(20) NOT NULL ,
  weeklyRate                 FLOAT(7,2) NOT NULL ,
  healthCareBenefits         VARCHAR(60) NOT NULL ,
  CONSTRAINT salaryStaff_pk  PRIMARY KEY (eid),
  CONSTRAINT salaryStaff_fk  FOREIGN KEY (eid) REFERENCES employee (eid)
);

CREATE TABLE chef(
  eid                 VARCHAR(20) NOT NULL,
  CONSTRAINT chef_pk  PRIMARY KEY (eID),
  CONSTRAINT chef_fk  FOREIGN KEY (eID) REFERENCES salaryStaff (eID)
);

CREATE TABLE sousChef(
  eID                     VARCHAR(20) NOT NULL,
  CONSTRAINT sousChef_pk  PRIMARY KEY (eID),
  CONSTRAINT sousChef_fk  FOREIGN KEY (eID) REFERENCES chef (eID)
);

CREATE TABLE mentorShip(
  eID                           VARCHAR(20) NOT NULL ,
  sChefID                     VARCHAR(20) NOT NULL ,
  itemID                        VARCHAR(20) NOT NULL ,
  startDate                   DATE NOT NULL ,
  endDate                    DATE,
  CONSTRAINT mentorShip_pk    PRIMARY KEY (eID, sChefID, itemID, startDate),
  CONSTRAINT mentorShip_fk1  FOREIGN KEY (itemID) REFERENCES menuItem (itemID),
  CONSTRAINT mentorShip_fk2  FOREIGN KEY (eID) REFERENCES sousChef (eID),
  CONSTRAINT mentorShip_fk3  FOREIGN KEY (sChefID) REFERENCES sousChef (eID)
);

CREATE TABLE specialty(
  eID                      VARCHAR(20) NOT NULL,
  specialty                VARCHAR(50) NOT NULL,
  CONSTRAINT specialty_pk  PRIMARY KEY (eID, specialty),
  CONSTRAINT specialty_fk  FOREIGN KEY (eID) REFERENCES sousChef (eID)
);

CREATE TABLE headChef(
  eID                      VARCHAR(20) NOT NULL,
  CONSTRAINT headChef_pk   PRIMARY KEY (eID),
  CONSTRAINT headChef_fk  FOREIGN KEY (eID) REFERENCES chef (eID)
);

CREATE TABLE recipe(
  eID                   VARCHAR(20) NOT NULL,
  recipe                VARCHAR(70) NOT NULL,
  CONSTRAINT recipe_pk  PRIMARY KEY (eID, recipe),
  CONSTRAINT recipe_fk  FOREIGN KEY (eID) REFERENCES chef (eID)
);

CREATE TABLE lineCook
(
  eID VARCHAR(20) NOT NULL,
  CONSTRAINT lineCook_pk PRIMARY KEY (eID),
  CONSTRAINT lineCook_fk FOREIGN KEY (eID) REFERENCES chef (eID)
);

CREATE TABLE station(
  eID                    VARCHAR(20) NOT NULL,
  station                VARCHAR(20) NOT NULL,
  CONSTRAINT station_pk  PRIMARY KEY (eID, station),
  CONSTRAINT station_fk  FOREIGN KEY (eID) REFERENCES lineCook (eID)
);

CREATE TABLE maitreD(
  eID                     VARCHAR(20) NOT NULL,
  CONSTRAINT maitreD_pk   PRIMARY KEY (eid),
  CONSTRAINT maitreD_fk  FOREIGN KEY (eid) REFERENCES employee (eid)
);

CREATE TABLE dishWasher(
  eID                        VARCHAR(20) NOT NULL,
  CONSTRAINT dishWasher_pk   PRIMARY KEY (eid),
  CONSTRAINT dishWasher_fk  FOREIGN KEY (eid) REFERENCES employee (eid)
);

CREATE TABLE waitStaff(
  eID                       VARCHAR(20) NOT NULL ,
  tipReceived               FLOAT(5,2),
  CONSTRAINT waitStaff_pk   PRIMARY KEY (eid),
  CONSTRAINT waitStaff_fk  FOREIGN KEY (eid) REFERENCES employee (eid)
);

CREATE TABLE tableInfo(
  tableNum    INT NOT NULL,
  orderID                 VARCHAR(20) NOT NULL,
  tableCap                INT NOT NULL,
  eID                     VARCHAR(20) NOT NULL,
  reservationStat         VARCHAR(20),
  gratuityGiven           FLOAT(5,2),
  CONSTRAINT tableInfo_pk  PRIMARY KEY (tableNum, orderID),
  CONSTRAINT tableInfo_fk  FOREIGN KEY (eID) REFERENCES waitStaff (eID)
);

CREATE TABLE eatIn(
  tableNum              INT NOT NULL,
  orderID               VARCHAR(20) NOT NULL ,
  partySize             INT NOT NULL ,
  gratuityCharge        FLOAT(5, 2),
  CONSTRAINT eatIn_pk   PRIMARY KEY (tableNum, orderID),
  CONSTRAINT eatIn_fk1  FOREIGN KEY (tableNum) REFERENCES tableInfo (tableNum),
  CONSTRAINT eatIn_fk2  FOREIGN KEY (orderID) REFERENCES orders(orderID)
);

CREATE TABLE partTimeStaff(
  eID                          VARCHAR(20) NOT NULL,
  hourlyRate                   FLOAT(4,2) NOT NULL,
  hoursWorkedPerWeek           FLOAT(4,2),
  CONSTRAINT partTimeStaff_pk  PRIMARY KEY (eID),
  CONSTRAINT partTimeStaff_fk  FOREIGN KEY (eid) REFERENCES employee (eID)
);





