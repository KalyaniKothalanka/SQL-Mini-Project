CREATE TABLE Region (ID INTEGER PRIMARY KEY,Name TEXT);
select * from region;

CREATE TABLE Sales_Rep (ID INTEGER PRIMARY KEY,Name TEXT,Region_ID INTEGER,
FOREIGN KEY (Region_ID) REFERENCES Region (ID));
select * from sales_rep;

CREATE TABLE Accounts (ID INTEGER PRIMARY KEY, Name TEXT,Website TEXT, LAT FLOAT,
LONG FLOAT, Primary_POC TEXT, Sales_Rep_ID INTEGER,
FOREIGN KEY (Sales_Rep_ID) REFERENCES Sales_Rep (ID));
select * from accounts;

CREATE TABLE Web_Events (ID INTEGER,Account_ID INTEGER,Occurred_at TIMESTAMP,Channel TEXT,
FOREIGN KEY (Account_ID) REFERENCES Accounts (ID),
PRIMARY KEY (ID));
select * from web_events;

CREATE TABLE Orders (ID INTEGER PRIMARY KEY,Account_ID INTEGER,Occurred_at TIMESTAMP,
Standard_qty INTEGER,Gloss_qty INTEGER,Poster_qty INTEGER,Total INTEGER,
Standard_amount_USD REAL,Gloss_amt_USD REAL,Poster_amt_USD REAL,Total_amt_USD REAL,
FOREIGN KEY (Account_ID) REFERENCES Accounts (ID));
select * from orders;

