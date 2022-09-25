USE [master]

GO
DROP DATABASE IF EXISTS eRecruitment

GO
CREATE DATABASE eRecruitment

GO
USE eRecruitment

--------------------------
-- Account/User Section --
--------------------------
GO
CREATE TABLE [Role](
	roleID INT IDENTITY(1,1) NOT NULL,
	roleName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_UserRole PRIMARY KEY (roleID)
)

GO
INSERT INTO [Role](roleName) VALUES('Candidate')
INSERT INTO [Role](roleName) VALUES('HR Staff')
INSERT INTO [Role](roleName) VALUES('HR Manager')
INSERT INTO [Role](roleName) VALUES('Interviewer')
INSERT INTO [Role](roleName) VALUES('System Admin')

GO
CREATE TABLE UserStatus(
	statusID INT IDENTITY(1,1) NOT NULL,
	statusName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_UserStatus PRIMARY KEY (statusID)
)

GO
INSERT INTO UserStatus(statusName) VALUES('Active')
INSERT INTO UserStatus(statusName) VALUES('inActive')

GO
CREATE TABLE Gender(
	genderID INT IDENTITY(1,1) NOT NULL,
	genderName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_Gender PRIMARY KEY (genderID)
)

GO
INSERT INTO Gender(genderName) VALUES('Male')
INSERT INTO Gender(genderName) VALUES('Female')
INSERT INTO Gender(genderName) VALUES('Other')

GO
CREATE TABLE [User](
	userID INT IDENTITY(1,1) NOT NULL,
	email VARCHAR(254) UNIQUE NOT NULL,
	[password] VARCHAR(32) NOT NULL,
	avatar VARCHAR(512) NULL,
	firstName NVARCHAR(50) NOT NULL,
	lastName NVARCHAR(50) NOT NULL,

	gender INT NOT NULL,
	[status] INT NOT NULL,

	CONSTRAINT PK_User PRIMARY KEY (userID),
	CONSTRAINT FK_User_from_Gender FOREIGN KEY (gender)
		REFERENCES Gender(genderID),
	CONSTRAINT FK_User_from_UserStatus FOREIGN KEY ([status])
		REFERENCES UserStatus(statusID),
	CONSTRAINT Email_Check_User CHECK(email LIKE '%___@___%')
)

GO
INSERT INTO [User](email, [password], avatar, firstName, lastName, gender, [status]) VALUES ('testCandidate@gmail.com', '111111', NULL, N'Candidate', N'Test', 1, 1)
INSERT INTO [User](email, [password], avatar, firstName, lastName, gender, [status]) VALUES ('testHRStaff@gmail.com', '111111', NULL, N'HR Staff', N'Test', 1, 1)
INSERT INTO [User](email, [password], avatar, firstName, lastName, gender, [status]) VALUES ('testHRManager@gmail.com', '111111', NULL, N'HR Manager', N'Test', 1, 1)
INSERT INTO [User](email, [password], avatar, firstName, lastName, gender, [status]) VALUES ('testInterviewer@gmail.com', '111111', NULL, N'Interviewer', N'Test', 1, 1)
INSERT INTO [User](email, [password], avatar, firstName, lastName, gender, [status]) VALUES ('testSystemAdmin@gmail.com', '111111', NULL, N'System Admin', N'Test', 1, 1)

GO
CREATE TABLE User_Role(
	userID INT NOT NULL,
	roleID INT NOT NULL,

	CONSTRAINT FK_UserRole_from_User FOREIGN KEY (userID)
		REFERENCES [User](userID),
	CONSTRAINT FK_UserRole_from_Role FOREIGN KEY (roleID)
		REFERENCES [Role](roleID),
)
GO
INSERT INTO User_Role(userID, roleID) VALUES (1, 1)
INSERT INTO User_Role(userID, roleID) VALUES (2, 2)
INSERT INTO User_Role(userID, roleID) VALUES (3, 3)
INSERT INTO User_Role(userID, roleID) VALUES (4, 4)
INSERT INTO User_Role(userID, roleID) VALUES (5, 5)

--------------------------
-- CV Section --
--------------------------
GO
CREATE TABLE CV(
	CVID INT IDENTITY(1,1) NOT NULL,
	firstName NVARCHAR(50) NOT NULL,
	lastName NVARCHAR(50) NOT NULL,
	avatar VARCHAR(512) NULL,
	dob DATE NOT NULL,
	introduction NVARCHAR(1000) NOT NULL,
	email VARCHAR(254) UNIQUE NOT NULL,
	phoneNumber VARCHAR(15) NOT NULL,
	[address] NVARCHAR(100) NOT NULL,
	city NVARCHAR(100) NOT NULL,

	gender INT NOT NULL,
	userID INT NOT NULL,

	CONSTRAINT PK_CV PRIMARY KEY (CVID),
	CONSTRAINT FK_CV_from_Gender FOREIGN KEY (gender)
		REFERENCES Gender(genderID),
	CONSTRAINT FK_CV_from_User FOREIGN KEY (userID)
		REFERENCES [User](userID),
	CONSTRAINT Email_Check_CV CHECK(email LIKE '%___@___%')
)

GO
CREATE TABLE CV_Skill(
	skillID INT IDENTITY(1,1) NOT NULL,
	skillName NVARCHAR(50) NOT NULL,
	skillDescription NVARCHAR(100) NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Skill PRIMARY KEY (skillID),
	CONSTRAINT FK_CV_Skill_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE CV_Interest(
	interestID INT IDENTITY(1,1) NOT NULL,
	interestName NVARCHAR(50) NOT NULL,
	interestDescription NVARCHAR(100) NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Interest PRIMARY KEY (interestID),
	CONSTRAINT FK_CV_Interest_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE CV_Certificate(
	certificateID INT IDENTITY(1,1) NOT NULL,
	certificateName NVARCHAR(100) NOT NULL,
	certificateLink VARCHAR(512) NOT NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Certificate PRIMARY KEY (certificateID),
	CONSTRAINT FK_CV_Certificate_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE CV_Achievement(
	achievementID INT IDENTITY(1,1) NOT NULL,
	achievementName NVARCHAR(100) NOT NULL,
	achievementDescription NVARCHAR(200) NOT NULL,
	achievementLink VARCHAR(512) NOT NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Achievement PRIMARY KEY (achievementID),
	CONSTRAINT FK_CV_Achievement_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE CV_Experience(
	experienceID INT IDENTITY(1,1) NOT NULL,
	jobTitle NVARCHAR(100) NOT NULL,
	organizationName NVARCHAR(100) NOT NULL,
	experienceDescription NVARCHAR(200) NOT NULL,
	experienceDuration NVARCHAR(30) NOT NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Experience PRIMARY KEY (experienceID),
	CONSTRAINT FK_CV_Experience_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE CV_Language(
	languageID INT IDENTITY(1,1) NOT NULL,
	languageName NVARCHAR(50) NOT NULL,
	languageDescription NVARCHAR(100) NOT NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Language PRIMARY KEY (languageID),
	CONSTRAINT FK_CV_Language_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE EducationStatus(
	statusID INT IDENTITY(1,1) NOT NULL,
	statusName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_EducationStatus PRIMARY KEY (statusID)
)

GO
INSERT INTO EducationStatus(statusName) VALUES('Complete')
INSERT INTO EducationStatus(statusName) VALUES('In-progress')

GO
CREATE TABLE CV_Education(
	educationID INT IDENTITY(1,1) NOT NULL,
	educationName NVARCHAR(100) NOT NULL,
	organizationName NVARCHAR(100) NOT NULL,

	statusID INT NOT NULL,
	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Education PRIMARY KEY (educationID),
	CONSTRAINT FK_CV_Education_from_EducationStatus FOREIGN KEY (statusID)
		REFERENCES EducationStatus(statusID),
	CONSTRAINT FK_CV_Education_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE [Platform](
	platformID INT IDENTITY(1,1) NOT NULL,
	platformName VARCHAR(30) NOT NULL,

	CONSTRAINT PK_Platform PRIMARY KEY (platformID)
)

GO
INSERT INTO [Platform](platformName) VALUES('LinkedIn')
INSERT INTO [Platform](platformName) VALUES('Facebook')
INSERT INTO [Platform](platformName) VALUES('Twitter')
INSERT INTO [Platform](platformName) VALUES('GitHub')
INSERT INTO [Platform](platformName) VALUES('GitLab')

GO
CREATE TABLE CV_SocialMedia(
	socialMediaID INT IDENTITY(1,1) NOT NULL,
	socialMediaLink VARCHAR(512) NOT NULL,

	platformID INT NOT NULL,
	CVID INT NOT NULL,

	CONSTRAINT PK_CV_SocialMedia PRIMARY KEY (socialMediaID),
	CONSTRAINT FK_CV_SocialMedia_from_Platform FOREIGN KEY (platformID)
		REFERENCES [Platform](platformID),
	CONSTRAINT FK_CV_SocialMedia_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

----------------------------------
-- Application Position Section --
----------------------------------
GO
CREATE TABLE Application_Position_Status(
	statusID INT IDENTITY(1,1) NOT NULL,
	statusName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_Application_Position_Status PRIMARY KEY (statusID)
)

