-- CREATE DATABASE
CREATE DATABASE report_analytics_portal_db;
USE report_analytics_portal_db;

-- CREATE TABLES
CREATE TABLE Admin(admin_id int, username varchar(50), password varchar(100), primary key(admin_id, username, password));

CREATE TABLE Industry(industry_id int, name varchar(50), primary key(industry_id), index idx_industry_id(industry_id));

CREATE TABLE Region(region_id varchar(50), region_name varchar(50), primary key (region_id));

CREATE TABLE School(industry_id int, school_id varchar(50), name varchar(100), region_id varchar(50), contact varchar(50), email varchar(50), index idx_school_id(school_id), primary key (industry_id, school_id), foreign key (industry_id) references Industry(industry_id) on update cascade on delete cascade , foreign key (region_id) references Region(region_id) on update cascade on delete cascade );

CREATE TABLE Course(course_id varchar(50), course_name varchar(50), primary key(course_id), index idx_course_id(course_id));

CREATE TABLE Student(student_id varchar(50), school_id varchar(50), course_id varchar(50), student_name varchar(100), birthdate varchar(50), gender varchar(50), contact varchar(50), address varchar(100), primary key (student_id), foreign key (school_id) references School(school_id) on update cascade on delete cascade , foreign key (course_id) references Course(course_id) on update cascade on delete cascade );

CREATE TABLE Enrollment(enrollment_id varchar(50), student_id varchar(50), num_units int, school_year int, semester varchar(50), payment_status varchar(50), primary key (enrollment_id), foreign key (student_id) references Student (student_id) on update cascade on delete cascade );

CREATE TABLE locatedIn(region_id varchar(50), school_id varchar(50), primary key (region_id, school_id), foreign key (region_id) references Region(region_id) on update cascade on delete cascade , foreign key (school_id) references School(school_id) on update cascade on delete cascade );

CREATE TABLE studiesIn(school_id varchar(50), student_id varchar(50), primary key (school_id, student_id), foreign key (school_id) references School(school_id) on update cascade on delete cascade , foreign key (student_id) references Student(student_id) on update cascade on delete cascade );

CREATE TABLE majorsIn(student_id varchar(50), course_id varchar(50), primary key ( student_id, course_id), foreign key (student_id) references Student(student_id) on update cascade on delete cascade , foreign key (course_id) references Course(course_id) on update cascade on delete cascade );

CREATE TABLE enrolled(student_id varchar(50), enrollment_id varchar(50), status varchar(50), primary key ( student_id, enrollment_id),  foreign key (student_id) references Student(student_id) on update cascade on delete cascade , foreign key (enrollment_id) references Enrollment(enrollment_id) on update cascade on delete cascade );

CREATE TABLE costPerStudent(enrollment_id varchar(50), school_id varchar(50), cost real, num_students int, primary key ( enrollment_id, school_id), foreign key (enrollment_id) references Enrollment(enrollment_id) on update cascade on delete cascade ,  foreign key (school_id) references School(school_id) on update cascade on delete cascade );

CREATE TABLE Public_Elementary_School(industry_id int, elementary_school_id int, school_name varchar(50), no_of_students int, index idx_elementary_school_id(elementary_school_id), primary key ( industry_id, elementary_school_id), foreign key (industry_id) references Industry(industry_id) on update cascade on delete cascade );

CREATE TABLE Grade_Level(level_name varchar(50), no_of_students int, primary key (level_name));

CREATE TABLE Offers(elementary_school_id int, level_name varchar(50), primary key (elementary_school_id,level_name), foreign key (elementary_school_id) references Public_Elementary_School(elementary_school_id) on update cascade on delete cascade );

CREATE TABLE Trader(trader_no int, name varchar(50), primary key (trader_no), index idx_trader_no(trader_no));

CREATE TABLE Importer(importer_no int, name varchar(50), primary key (importer_no), index idx_importer_no(importer_no));

CREATE TABLE Distributor(dist_no int, name varchar(50), primary key (dist_no), index idx_dist_no(dist_no));

CREATE TABLE Manufacturer(manu_no int, name varchar(50), primary key (manu_no), index idx_manu_no(manu_no));

CREATE TABLE Drug(industry_id int, cpr_no varchar(50), dr_no varchar(50), country varchar(50), rsn varchar(50),validity_date date,generic_name varchar(50),brand_name varchar(50),strength varchar(50),form varchar(50), index idx_cpr_no(cpr_no), primary key (industry_id, cpr_no), foreign key (industry_id) references Industry(industry_id) on update cascade on delete cascade );

CREATE TABLE Food(industry_id int, cpr_no varchar(50), food_name varchar(100), dr_no varchar(50), country varchar(50), rsn varchar(50),validity_date date,index idx_cpr_no(cpr_no), primary key (industry_id, cpr_no), foreign key (industry_id) references Industry(industry_id) on update cascade on delete cascade );

CREATE TABLE Trades(drug_cpr_no varchar(50), food_cpr_no varchar(50), trader_no int, primary key (drug_cpr_no, food_cpr_no, trader_no), foreign key (drug_cpr_no) references Drug(cpr_no) on update cascade on delete cascade , foreign key (food_cpr_no) references Food(cpr_no) on update cascade on delete cascade , foreign key (trader_no) references Trader(trader_no) on update cascade on delete cascade );

CREATE TABLE Imports(drug_cpr_no varchar(50), food_cpr_no varchar(50), importer_no int, primary key (drug_cpr_no, food_cpr_no, importer_no), foreign key (drug_cpr_no) references Drug(cpr_no) on update cascade on delete cascade , foreign key (food_cpr_no) references Food(cpr_no) on update cascade on delete cascade , foreign key (importer_no) references Importer(importer_no) on update cascade on delete cascade );

CREATE TABLE Distributes(drug_cpr_no varchar(50), food_cpr_no varchar(50), dist_no int, primary key (drug_cpr_no, food_cpr_no, dist_no), foreign key (drug_cpr_no) references Drug(cpr_no) on update cascade on delete cascade , foreign key (food_cpr_no) references Food(cpr_no) on update cascade on delete cascade , foreign key (dist_no) references Distributor(dist_no) on update cascade on delete cascade );

CREATE TABLE Manufactures(drug_cpr_no varchar(50), food_cpr_no varchar(50), manu_no int, primary key (drug_cpr_no, food_cpr_no, manu_no), foreign key (drug_cpr_no) references Drug(cpr_no) on update cascade on delete cascade , foreign key (food_cpr_no) references Food(cpr_no) on update cascade on delete cascade , foreign key (manu_no) references Manufacturer(manu_no) on update cascade on delete cascade );


-- INSERT VALUES
INSERT INTO Admin VALUES (1, 'admin', '21232f297a57a5a743894a0e4a801fc3');

INSERT INTO Industry VALUES (1, 'Drug');
INSERT INTO Industry VALUES (2, 'Food');
INSERT INTO Industry VALUES (3, 'School');
INSERT INTO Industry VALUES (4, 'Public_Elementary_School');

INSERT INTO Drug VALUES (1,"0",null,null,null,null,null,null,null,null);
INSERT INTO Drug VALUES (1,"NO-004746","DRP-1228-01",null,"20100000000000",'2020-10-10',"Purified Water (Distilled Water)",null,null,null);
INSERT INTO Drug VALUES (1,"DE-000331","DR-XY13892","Australia","05A-1915",'2020-8-11',"Budesonide",'Budecort Respules',"250 mg/mL",'Nebulizing Suspension (Sterile)');
INSERT INTO Drug VALUES (1,"NO-004749","DRP-924-01",null,"20100000000000",'2020-5-29',"Sodium Chloride",null,"450 mg/50 mL (0.9% w/v)","Solution for IV Infusion");
INSERT INTO Drug VALUES (1,"DC-000195","DR-XY30762",null,"04A-1251",'2020-5-17',"Cefalexin (As Monohydrate)",'Felfalex',"250 mg/5 mL","Granules for Suspension");
INSERT INTO Drug VALUES (1,"NO-004748","DRP-944-01",null,"20100000000000",'2020-2-3',"Sterile Water for Injection",null,null,"Solution for Injection");
INSERT INTO Drug VALUES(1,"NO-004391","DRP-825-01","India","20100000000000","2020-1-3","Ranitidine (as Hydrochloride)","Rentsan","25 mg/mL","Solution for Injection IM/IV");
INSERT INTO Drug VALUES(1,"NO-004756","DRP-3196-01","India","20100000000000","2019-12-29","Cefuroxime (as Sodium)","Dinoxime","750 mg","Powder for Injection IM/IV");
INSERT INTO Drug VALUES(1,"NO-004633","DRP-3707-04","India","20100000000000","2019-12-21","Cetirizine Hydrochloride","Qualcet","5 mg/5 mL","Syrup");
INSERT INTO Drug VALUES(1,"NO-004673","DRP-3707-01","India","20100000000000","2019-12-21","Cetirizine Hydrochloride",null,"5 mg/5 mL","Syrup");
INSERT INTO Drug VALUES(1,"NO-004710","DRP-076-02","Korea","20100000000000","2019-12-21","Cefuroxime (as Sodium)","Ceft","750 mg","Powder for Injection IM/IV");
INSERT INTO Drug VALUES(1,"NO-004706","DRP-076-09","Korea","20100000000000","2019-12-21","Cefuroxime (as Sodium)","Fuzef","750 mg","Powder for Injection IM/IV");
INSERT INTO Drug VALUES(1,"NO-004708","DRP-076-08","Korea","20100000000000","2019-12-21","Cefuroxime (as Sodium)","Rucef","750 mg","Powder for Injection IM/IV");
INSERT INTO Drug VALUES(1,"NO-004707","DRP-076-01","Korea","20100000000000","2019-12-21","Cefuroxime (as Sodium)","Altoxime","750 mg","Powder for Injection IM/IV");
INSERT INTO Drug VALUES(1,"NO-004721","DRP-076-05","Korea","20100000000000","2019-12-21","Cefuroxime (as Sodium)","Zefur","750 mg","Powder for Ijection IM/IV");
INSERT INTO Drug VALUES(1,"NO-004723","DRP-076-10","Korea","20100000000000","2019-12-21","Cefuroxime (as Sodium)","Furoxen","750 mg","Powder for Injection IM/IV");
INSERT INTO Drug VALUES(1,"NO-004755","DRP-076-03","Korea","20100000000000","2019-12-21","Cefuroxime (as Sodium)","Cefurax","750 mg","Powder for Injection IM/IV");
INSERT INTO Drug VALUES(1,"NO-004639","DRP-5073-02","India","20100000000000","2019-12-20","Dichlorobenzyl Alcohol + Amylmetacresol","Muracept","1.2 mg/600 mcg","Lozenge");
INSERT INTO Drug VALUES(1,"NO-004486","DRP-1505-02",null,"20100000000000","2019-12-13","Phenylephrine Hydrochloride / Brompheniramine","Sinulif","12.5 mg/4 mg per 5 mL","Syrup");
INSERT INTO Drug VALUES(1,"NO-004487","DRP-1505-01",null,"20100000000000","2019-12-13","Phenylephrine Hydrochloride / Brompheniramine Maleate","Cold-Aid","12.5 mg/4 mg per 5 mL","Syrup");
INSERT INTO Drug VALUES(1,"NO-004537","DRP-3416-04","India","20140903120756,20150223145719","2019-12-8","Piperacillin (As Sodium) + Tazobactam (As Sodiuim)","Nazovac","4 g/500 mg","Powder for Injection IM/IV");
INSERT INTO Drug VALUES(1,"NO-004538","DRP-3416-03","India","20100000000000","2019-12-8","Piperacillin (As Sodium) + Tazobactam (As Sodiuim)","Tazmar","4 g/500 mg","Powder for Injection IM/IV");

insert into Food values(2,"FDA-0049904","Chowking Chicken Marinade Xbm51 (For Export Market)","FR-105694","Philippines","20100000000000","2020-12-10");
insert into Food values(2,"FDA-0057527","My-Marvel Taheebo Herbal Dietary Supplement Tea","FR-19018","Philippines","20100000000000","2020-11-12");
insert into Food values(2,"FDA-0058293","Kgc Kgc Korean Red Ginseng","FR-128825","Korea","20200000000000","2020-10-12");
insert into Food values(2,"FDA-0056539","Fresenius Kabi Supportan Drink - Cappucinno Flavor Reformulated (Food For Special Medical Purpose)","FR-103810","Germany","20100000000000","2020-10-03");
insert into Food values(2,"FDA-0058278","Falcon's Valley Falcon's Valley Choice Whole Young Corn","FR-87500","Thailand","20100000000000","2020-09-28");
insert into Food values(2,"FDA-0055616","Calciday Calcium Carbonate + Vitamin D Food Supplement Tablet","FR-103883","Philippines","20100000000000","2020-09-13");
insert into Food values(2,"FDA-0057528","Interhealthcare Pharmaceuticals Inc. Green Juice (Wheat Grass + Barley Grass) Food Supplement Powder","FR-103682","Philippines","20100000000000","2020-09-11");
insert into Food values(2,"FDA-0054728","App-Essentials A To Z Kid's Vitamin C Dietary Supplement Tablet - Strawberry Flavor","FR-103449","Malaysia","20100000000000","2020-08-24");
insert into Food values(2,"FDA-0048937","Maya All Purpose Flour (With Corn Nuggets Recipe On The Back Panel)","FR-85997","Philippines","20100000000000","2020-07-01");
insert into Food values(2,"FDA-0048936","Maya All Purpose Flour (With Seafood Tempura Recipe On The Back Panel)","FR-85998","Philippines","20100000000000","2020-07-01");
insert into Food values(2,"FDA-0048935","Maya All Purpose Flour (With Strawberry Jam, Muffins and Fudge-Filled Shortbread Recipes On The Back Panel)","FR-85999","Philippines","20100000000000","2020-07-01");
insert into Food values(2,"FDA-0048934","Maya All Purpose Flour (With Siopao Recipe On The Back Panel)","FR-86000","Philippines","20100000000000","2020-07-01");
insert into Food values(2,"FDA-0058295","Nestle Nestvit Omega Plus Actitol Nestle Nestvit Omega Plus Actitol Adult Nutritional Beverage (Exclusive For Export To Singapore And Malaysia","FR-78778","Philippines","20100000000000","2020-06-30");
insert into Food values(2,"FDA-0053789","Century Quality Bangus Fillet - Spanish Style","FR-72662","Philippines","20100000000000","2020-06-24");
insert into Food values(2,"FDA-0053790","Century Quality Bangus Fillet With Tausi","FR-72661","Philippines","20100000000000","2020-06-24");
insert into Food values(2,"FDA-0058046","Lucky Me! Special Instant Curly Spaghetti With Yummy Red Sauce","FR-92652","Philippines","20100000000000","2020-05-30");
insert into Food values(2,"FDA-0053824","Homesoy Soya Milk Brown Sugar","FR-110025","Malaysia","20100000000000","2020-05-03");
insert into Food values(2,"FDA-0053823","Homesoy Soya Milk Original","FR-110024","Malaysia","20100000000000","2020-05-03");
insert into Food values(2,"FDA-0055552","Schoko Compound Chocolate - Milk Compound","FR-100353","USA","20100000000000","2020-04-19");
insert into Food values(2,"FDA-0058267","La Preferida La Preferida Tortilla Chips - Yellow Corn","FR-21234","USA","20100000000000","2020-03-11");
insert into Food values(2,"FDA-0058266","La Preferida La Preferida Salsa Picante Mild - Dip and Sauce","FR-21230","USA","20100000000000","2020-03-11");
insert into Manufacturer values(1,"Edward Keller (Philippines) Inc.");
insert into Manufacturer values(2,"Herbs and Natures Corporation");
insert into Manufacturer values(3,"Korean Ginseng Group");
insert into Manufacturer values(4,"Fresenius Kabi Deutschland GmbH");
insert into Manufacturer values(5,"Majestic Food Indsutry Co., Ltd.");
insert into Manufacturer values(6,"Novagen Pharmaceutical Co. Inc.");
insert into Manufacturer values(7,"Northfield Laboratories Inc.");
insert into Manufacturer values(8,"Kontra Pharma (M) Sdn. Bhd.");
insert into Manufacturer values(9,"Liberty Flour Mills, Inc.");
insert into Manufacturer values(10,"Nestle Philippines, Inc.");
insert into Manufacturer values(11,"General Tuna Corporation");
insert into Manufacturer values(12,"Monde Nissin Corporation");
insert into Manufacturer values(13,"Ace Canning Corporation Sdn. Bhd.");
insert into Manufacturer values(14,"PT. Wahana Interfood Nusantra");
insert into Manufacturer values(15,"LP International Inc.");
insert into Trader values(1,"Edward Keller (Philippines) Inc.");
insert into Trader values(2,"Herbs and Natures Corporation");
insert into Trader values(3,"Richie Import and Export Trading Ltd., Inc.");
insert into Trader values(4,"Fresenius Kabi Philippines Inc.");
insert into Trader values(5,"Link Import Export Enterprise Inc.");
insert into Trader values(6,"Wert Philippines Inc.");
insert into Trader values(7,"Northfield Laboratories, Inc.");
insert into Trader values(8,"Tokagawa Global Corporation");
insert into Trader values(9,"Liberty Flour Mills, Inc.");
insert into Trader values(10,"Nestle Philippines, Inc.");
insert into Trader values(11,"Century Canning Corporation");
insert into Trader values(12,"Monde Nissin Corporation");
insert into Trader values(13,"JIA2 Corp.");
insert into Trader values(14,"Romar's Manufacturing (Food Dept.)");
insert into Manufactures values("0","FDA-0049904",1);
insert into Manufactures values("0","FDA-0057527",2);
insert into Manufactures values("0","FDA-0058293",3);
insert into Manufactures values("0","FDA-0056539",4);
insert into Manufactures values("0","FDA-0058278",5);
insert into Manufactures values("0","FDA-0055616",6);
insert into Manufactures values("0","FDA-0057527",7);
insert into Manufactures values("0","FDA-0057528",8);
insert into Manufactures values("0","FDA-0048937",9);
insert into Manufactures values("0","FDA-0048936",9);
insert into Manufactures values("0","FDA-0048935",9);
insert into Manufactures values("0","FDA-0048934",9);
insert into Manufactures values("0","FDA-0058295",10);
insert into Manufactures values("0","FDA-0053789",11);
insert into Manufactures values("0","FDA-0053790",11);
insert into Manufactures values("0","FDA-0058046",12);
insert into Manufactures values("0","FDA-0053824",13);
insert into Manufactures values("0","FDA-0053823",13);
insert into Manufactures values("0","FDA-0055552",14);
insert into Manufactures values("0","FDA-0058266",15);
insert into Manufactures values("0","FDA-0058267",15);
insert into Trades values("0","FDA-0049904",1);
insert into Trades values("0","FDA-0057527",2);
insert into Trades values("0","FDA-0058293",3);
insert into Trades values("0","FDA-0056539",4);
insert into Trades values("0","FDA-0058278",5);
insert into Trades values("0","FDA-0055616",6);
insert into Trades values("0","FDA-0057527",7);
insert into Trades values("0","FDA-0057528",8);
insert into Trades values("0","FDA-0048937",9);
insert into Trades values("0","FDA-0048936",9);
insert into Trades values("0","FDA-0048935",9);
insert into Trades values("0","FDA-0048934",9);
insert into Trades values("0","FDA-0058295",10);
insert into Trades values("0","FDA-0053789",11);
insert into Trades values("0","FDA-0053790",11);
insert into Trades values("0","FDA-0058046",12);
insert into Trades values("0","FDA-0053824",13);
insert into Trades values("0","FDA-0053823",13);
insert into Trades values("0","FDA-0055552",5);
insert into Trades values("0","FDA-0058266",14);
insert into Trades values("0","FDA-0058267",14);

--SCHOOL/SUC DB
INSERT INTO Region VALUES ('RID-01', 'NCR');
INSERT INTO Region VALUES ('RID-02', 'C A R');
INSERT INTO Region VALUES ('RID-03', 'REGION I');
INSERT INTO Region VALUES ('RID-04', 'REGION III');
INSERT INTO Region VALUES ('RID-05', 'REGION VI');
INSERT INTO Region VALUES ('RID-06', 'REGION VIII');
INSERT INTO Region VALUES ('RID-07', 'REGION XI');
INSERT INTO Region VALUES ('RID-08', 'REGION IX (ARMM)')
INSERT INTO Region VALUES ('RID-09', 'REGION X');
INSERT INTO Region VALUES ('RID-10', 'REGION XII (ARMM)');
INSERT INTO Region VALUES ('RID-11', 'REGION XII (Main)');

INSERT INTO School VALUES (3, 'SCID-0001', 'University of the Philippines System', 'RID-01', '(667) 2215286', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0002', 'Philippine Merchant Marine Academy', 'RID-04', '(628) 7754568', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0003', 'MSU - Tawi-Tawi College of Technology and Oceanography', 'RID-07', '(840) 4288563', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0004', 'Adiong Memorial Polytechnic State  College', 'RID-10', '(615) 3219112', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0005', 'Mindanao State University', 'RID-10', '(351) 6464825', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0006', 'Cotabato Foundation College of Science & Tech.', 'RID-11', '(574) 9812516', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0007', 'Don Mariano Marcos Memorial State University', 'RID-03', '(291) 5118210', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0008', 'Tarlac College of Agriculture', 'RID-04', '(710) 7166900', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0009', 'MSU - Iligan Institute of Technology', 'RID-08', '(979) 6378149', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0010', 'Samar State College of Agriculture and Forestry', 'RID-06', '(236) 3987540', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0011', 'Abra State Institute of Science and Technology', 'RID-02', '(355) 8760074', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0012', 'Central Luzon State University', 'RID-04', '(508) 4352459', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0013', 'Central Mindanao University', 'RID-08', '(301) 3824401', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0014', 'Southern Philippines Agri-Business & Marine & Aquatic School of Technology', 'RID-09', '(602) 3031724', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0015', 'Mariano Marcos State University', 'RID-03', '(745) 7906699', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0016', 'Benguet State University', 'RID-02', '(490) 1406782', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0017', 'Iloilo State College of Fisheries', 'RID-05', '(185) 1231843', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0018', 'Davao del Norte State College', 'RID-09', '(537) 7195222', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0019', 'Pampanga Agricultural College', 'RID-04', '(403) 1296490', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0020', 'Misamis Oriental State College of Agriculture & Tech.', 'RID-08', '(629) 2155842', 'info@suc.edu.ph');
INSERT INTO School VALUES (3, 'SCID-0021', 'Cotabato City State Polytechnic College', 'RID-11', '(230) 6201223', 'info@suc.edu.ph');


/**INSERT into <table_name> VALUES (<table_values>)

-- UPDATE VALUES

--UPDATE <table_name> SET <table_attribute> = <update_value> WHERE <condition>

-- DELETE VALUES

--DELETE FROM <table_name> where <condition>

-- DEFINITIONS
-- <table_name> -> one of the tables in the report_analytics_portal_db database
-- <table_values> -> depends on the preceding <table_name> and it follows the table's schema
-- <table_attribute> -> one of the attributes defined in the table's schema based on the preceding <table_name>
-- <update_value> -> valid value that follows the data type of the preceding <table_attribute>
-- <condition> -> condition about the update, often includes attributes of the preceding <table_name>**/
