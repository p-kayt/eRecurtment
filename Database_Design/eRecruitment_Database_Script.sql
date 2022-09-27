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
	RoleID INT IDENTITY(1,1) NOT NULL,
	RoleName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_UserRole PRIMARY KEY (RoleID)
)

GO
INSERT INTO [Role](RoleName) VALUES('Candidate')
INSERT INTO [Role](RoleName) VALUES('HR Staff')
INSERT INTO [Role](RoleName) VALUES('HR Manager')
INSERT INTO [Role](RoleName) VALUES('Interviewer')
INSERT INTO [Role](RoleName) VALUES('System Admin')

GO
CREATE TABLE UserStatus(
	StatusID INT IDENTITY(1,1) NOT NULL,
	StatusName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_UserStatus PRIMARY KEY (StatusID)
)

GO
INSERT INTO UserStatus(StatusName) VALUES('Active')
INSERT INTO UserStatus(StatusName) VALUES('inActive')

GO
CREATE TABLE Gender(
	GenderID INT IDENTITY(1,1) NOT NULL,
	GenderName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_Gender PRIMARY KEY (GenderID)
)

GO
INSERT INTO Gender(GenderName) VALUES('Male')
INSERT INTO Gender(GenderName) VALUES('Female')
INSERT INTO Gender(GenderName) VALUES('Other')

GO
CREATE TABLE [User](
	UserID INT IDENTITY(1,1) NOT NULL,
	Email VARCHAR(254) UNIQUE NOT NULL,
	[Password] VARCHAR(32) NOT NULL,
	Avatar VARCHAR(512) NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,

	Gender INT NOT NULL,
	[Status] INT NOT NULL,

	CONSTRAINT PK_User PRIMARY KEY (UserID),
	CONSTRAINT FK_User_from_Gender FOREIGN KEY (Gender)
		REFERENCES Gender(GenderID),
	CONSTRAINT FK_User_from_UserStatus FOREIGN KEY ([Status])
		REFERENCES UserStatus(StatusID),
	CONSTRAINT Email_Check_User CHECK(Email LIKE '%___@___%')
)

GO
INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) VALUES ('testCandidate@gmail.com', '111111', NULL, N'Candidate', N'Test', 1, 1)
INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) VALUES ('testHRStaff@gmail.com', '111111', NULL, N'HR Staff', N'Test', 1, 1)
INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) VALUES ('testHRManager@gmail.com', '111111', NULL, N'HR Manager', N'Test', 1, 1)
INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) VALUES ('testInterviewer@gmail.com', '111111', NULL, N'Interviewer', N'Test', 1, 1)
INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) VALUES ('testSystemAdmin@gmail.com', '111111', NULL, N'System Admin', N'Test', 1, 1)

GO
CREATE TABLE User_Role(
	UserID INT NOT NULL,
	RoleID INT NOT NULL,

	CONSTRAINT FK_UserRole_from_User FOREIGN KEY (UserID)
		REFERENCES [User](UserID),
	CONSTRAINT FK_UserRole_from_Role FOREIGN KEY (RoleID)
		REFERENCES [Role](RoleID),
)
GO
INSERT INTO User_Role(UserID, RoleID) VALUES (1, 1)
INSERT INTO User_Role(UserID, RoleID) VALUES (2, 2)
INSERT INTO User_Role(UserID, RoleID) VALUES (3, 3)
INSERT INTO User_Role(UserID, RoleID) VALUES (4, 4)
INSERT INTO User_Role(UserID, RoleID) VALUES (5, 5)

--------------------------
-- CV Section --
--------------------------
GO
CREATE TABLE CV(
	CVID INT IDENTITY(1,1) NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Avatar VARCHAR(512) NULL,
	Dob DATE NOT NULL,
	Introduction NVARCHAR(1000) NOT NULL,
	Email VARCHAR(254) UNIQUE NOT NULL,
	PhoneNumber VARCHAR(15) NOT NULL,
	[Address] NVARCHAR(100) NOT NULL,
	City NVARCHAR(100) NOT NULL,

	Gender INT NOT NULL,
	UserID INT NOT NULL,

	CONSTRAINT PK_CV PRIMARY KEY (CVID),
	CONSTRAINT FK_CV_from_Gender FOREIGN KEY (Gender)
		REFERENCES Gender(GenderID),
	CONSTRAINT FK_CV_from_User FOREIGN KEY (UserID)
		REFERENCES [User](UserID),
	CONSTRAINT Email_Check_CV CHECK(Email LIKE '%___@___%')
)

GO
CREATE TABLE CV_Skill(
	SkillID INT IDENTITY(1,1) NOT NULL,
	SkillName NVARCHAR(50) NOT NULL,
	SkillDescription NVARCHAR(100) NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Skill PRIMARY KEY (SkillID),
	CONSTRAINT FK_CV_Skill_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE CV_Interest(
	InterestID INT IDENTITY(1,1) NOT NULL,
	InterestName NVARCHAR(50) NOT NULL,
	InterestDescription NVARCHAR(100) NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Interest PRIMARY KEY (InterestID),
	CONSTRAINT FK_CV_Interest_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE CV_Certificate(
	CertificateID INT IDENTITY(1,1) NOT NULL,
	CertificateName NVARCHAR(100) NOT NULL,
	CertificateLink VARCHAR(512) NOT NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Certificate PRIMARY KEY (CertificateID),
	CONSTRAINT FK_CV_Certificate_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE CV_Achievement(
	AchievementID INT IDENTITY(1,1) NOT NULL,
	AchievementName NVARCHAR(100) NOT NULL,
	AchievementDescription NVARCHAR(200) NOT NULL,
	AchievementLink VARCHAR(512) NOT NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Achievement PRIMARY KEY (AchievementID),
	CONSTRAINT FK_CV_Achievement_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE CV_Experience(
	ExperienceID INT IDENTITY(1,1) NOT NULL,
	JobTitle NVARCHAR(100) NOT NULL,
	OrganizationName NVARCHAR(100) NOT NULL,
	ExperienceDescription NVARCHAR(200) NOT NULL,
	ExperienceDuration NVARCHAR(30) NOT NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Experience PRIMARY KEY (ExperienceID),
	CONSTRAINT FK_CV_Experience_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE CV_Language(
	LanguageID INT IDENTITY(1,1) NOT NULL,
	LanguageName NVARCHAR(50) NOT NULL,
	LanguageDescription NVARCHAR(100) NOT NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Language PRIMARY KEY (LanguageID),
	CONSTRAINT FK_CV_Language_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE EducationStatus(
	StatusID INT IDENTITY(1,1) NOT NULL,
	StatusName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_EducationStatus PRIMARY KEY (StatusID)
)

GO
INSERT INTO EducationStatus(StatusName) VALUES('Complete')
INSERT INTO EducationStatus(StatusName) VALUES('In-progress')

GO
CREATE TABLE CV_Education(
	EducationID INT IDENTITY(1,1) NOT NULL,
	EducationName NVARCHAR(100) NOT NULL,
	OrganizationName NVARCHAR(100) NOT NULL,

	StatusID INT NOT NULL,
	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Education PRIMARY KEY (EducationID),
	CONSTRAINT FK_CV_Education_from_EducationStatus FOREIGN KEY (StatusID)
		REFERENCES EducationStatus(StatusID),
	CONSTRAINT FK_CV_Education_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
CREATE TABLE [Platform](
	PlatformID INT IDENTITY(1,1) NOT NULL,
	PlatformName VARCHAR(30) NOT NULL,

	CONSTRAINT PK_Platform PRIMARY KEY (PlatformID)
)

GO
INSERT INTO [Platform](PlatformName) VALUES('LinkedIn')
INSERT INTO [Platform](PlatformName) VALUES('Facebook')
INSERT INTO [Platform](PlatformName) VALUES('Twitter')
INSERT INTO [Platform](PlatformName) VALUES('GitHub')
INSERT INTO [Platform](PlatformName) VALUES('GitLab')

GO
CREATE TABLE CV_SocialMedia(
	SocialMediaID INT IDENTITY(1,1) NOT NULL,
	SocialMediaLink VARCHAR(512) NOT NULL,

	PlatformID INT NOT NULL,
	CVID INT NOT NULL,

	CONSTRAINT PK_CV_SocialMedia PRIMARY KEY (SocialMediaID),
	CONSTRAINT FK_CV_SocialMedia_from_Platform FOREIGN KEY (PlatformID)
		REFERENCES [Platform](PlatformID),
	CONSTRAINT FK_CV_SocialMedia_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

----------------------------------
-- Application Position Section --
----------------------------------
GO
CREATE TABLE Application_Position_Status(
	StatusID INT IDENTITY(1,1) NOT NULL,
	StatusName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_Application_Position_Status PRIMARY KEY (StatusID)
)

