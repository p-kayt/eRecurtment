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

	CONSTRAINT PK_Role PRIMARY KEY (RoleID)
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

	CONSTRAINT PK_UserRole PRIMARY KEY (UserID, RoleID),
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
	FirstName NVARCHAR(50) NULL,
	LastName NVARCHAR(50) NULL,
	Avatar VARCHAR(512) NULL,
	Dob DATE NULL,
	Introduction NVARCHAR(1000) NULL,
	Email VARCHAR(254) UNIQUE NULL,
	PhoneNumber VARCHAR(15) NULL,
	[Address] NVARCHAR(100) NULL,
	City NVARCHAR(100) NULL,

	Gender INT NULL,
	UserID INT NULL,

	CONSTRAINT PK_CV PRIMARY KEY (CVID),
	CONSTRAINT FK_CV_from_Gender FOREIGN KEY (Gender)
		REFERENCES Gender(GenderID),
	CONSTRAINT FK_CV_from_User FOREIGN KEY (UserID)
		REFERENCES [User](UserID),
	CONSTRAINT Email_Check_CV CHECK(Email LIKE '%___@___%')
)
--SELECT FirstName, LastName, Avatar, Dob, Introduction, Email, PhoneNumber, [Address], City, GenderName, UserID FROM CV INNER JOIN Gender ON Gender = GenderID WHERE CVID = 1;
GO
INSERT INTO CV(FirstName, LastName, Avatar, Dob, Introduction, Email, PhoneNumber, [Address], City, Gender, UserID)
	VALUES(N'Test Candidate', N'Curriculum Vitae', NULL, '2000-01-01', N'This is a test CV for the web application eRecruitment. The purpose of this CV is testing functions of the web application such as: View CV, update CV,...', 'testCandidate@gmail.com', '0911111222', N'1 D2 Khu Cong Nghe Cao', N'Ho Chi Minh', 1, 1)

GO
CREATE TABLE CV_Skill(
	SkillID INT IDENTITY(1,1) NOT NULL,
	SkillName NVARCHAR(100) NULL,
	SkillDescription NVARCHAR(200) NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Skill PRIMARY KEY (SkillID),
	CONSTRAINT FK_CV_Skill_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
INSERT INTO CV_Skill(SkillName, SkillDescription, CVID) VALUES (N'Java', N'Intermediate Level', 1)
INSERT INTO CV_Skill(SkillName, SkillDescription, CVID) VALUES (N'C#', N'Beginer Level', 1)
INSERT INTO CV_Skill(SkillName, SkillDescription, CVID) VALUES (N'Chicken Herding', N'Professor Level', 1)


GO
CREATE TABLE CV_Interest(
	InterestID INT IDENTITY(1,1) NOT NULL,
	InterestName NVARCHAR(100) NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Interest PRIMARY KEY (InterestID),
	CONSTRAINT FK_CV_Interest_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
INSERT INTO CV_Interest(InterestName, CVID) VALUES (N'Game', 1)
INSERT INTO CV_Interest(InterestName, CVID) VALUES (N'Manga', 1)
INSERT INTO CV_Interest(InterestName, CVID) VALUES (N'Anime', 1)
INSERT INTO CV_Interest(InterestName, CVID) VALUES (N'Food', 1)

GO
CREATE TABLE CV_Certificate(
	CertificateID INT IDENTITY(1,1) NOT NULL,
	CertificateName NVARCHAR(100) NULL,
	CertificateLink VARCHAR(512) NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Certificate PRIMARY KEY (CertificateID),
	CONSTRAINT FK_CV_Certificate_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
INSERT INTO CV_Certificate(CertificateName, CertificateLink, CVID) VALUES (N'Ielts', 'https://ielts.idp.com/results/check-your-result', 1)
INSERT INTO CV_Certificate(CertificateName, CertificateLink, CVID) VALUES (N'Business Advisor', 'https://thanhnien.vn/dung-de-bi-lua-ga-post1481000.html', 1)

GO
CREATE TABLE CV_Achievement(
	AchievementID INT IDENTITY(1,1) NOT NULL,
	AchievementName NVARCHAR(100) NULL,
	AchievementDescription NVARCHAR(200) NULL,
	AchievementLink VARCHAR(512) NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Achievement PRIMARY KEY (AchievementID),
	CONSTRAINT FK_CV_Achievement_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
INSERT INTO CV_Achievement(AchievementName, AchievementDescription, AchievementLink, CVID) VALUES (N'Manga Hub', N'A website for reading manga online', 'https://github.com/MHTteam/Read-Manga-Online-Website', 1)


GO
CREATE TABLE CV_Experience(
	ExperienceID INT IDENTITY(1,1) NOT NULL,
	JobTitle NVARCHAR(100) NULL,
	OrganizationName NVARCHAR(100) NULL,
	ExperienceDescription NVARCHAR(1000) NULL,
	ExperienceDuration NVARCHAR(100) NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Experience PRIMARY KEY (ExperienceID),
	CONSTRAINT FK_CV_Experience_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
INSERT INTO CV_Experience(JobTitle, OrganizationName, ExperienceDescription, ExperienceDuration, CVID) VALUES (N'Chicken Herding', N'University Of F', N'Herding young, inexperience, newly born chicken into the world of Incident Technology (IT) at the University of F (UF)', N'20 Years', 1)

GO
CREATE TABLE CV_Language(
	LanguageID INT IDENTITY(1,1) NOT NULL,
	LanguageName NVARCHAR(50) NULL,
	LanguageDescription NVARCHAR(200) NULL,

	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Language PRIMARY KEY (LanguageID),
	CONSTRAINT FK_CV_Language_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
INSERT INTO CV_Language(LanguageName, LanguageDescription, CVID) VALUES (N'English', N'Ielts 10 Cham', 1)

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
	EducationName NVARCHAR(100) NULL,
	OrganizationName NVARCHAR(100) NULL,

	StatusID INT NOT NULL,
	CVID INT NOT NULL,

	CONSTRAINT PK_CV_Education PRIMARY KEY (EducationID),
	CONSTRAINT FK_CV_Education_from_EducationStatus FOREIGN KEY (StatusID)
		REFERENCES EducationStatus(StatusID),
	CONSTRAINT FK_CV_Education_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
INSERT INTO CV_Education(EducationName, OrganizationName, StatusID, CVID) VALUES (N'Bachelor of Chicken Herding', N'University of F', 1, 1)
INSERT INTO CV_Education(EducationName, OrganizationName, StatusID, CVID) VALUES (N'Bachelor of Incedent Technology', N'University of F', 2, 1)

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
INSERT INTO [Platform](PlatformName) VALUES('Personal Website')

GO
CREATE TABLE CV_SocialMedia(
	SocialMediaID INT IDENTITY(1,1) NOT NULL,
	SocialMediaLink VARCHAR(512) NULL,

	PlatformID INT NOT NULL,
	CVID INT NOT NULL,

	CONSTRAINT PK_CV_SocialMedia PRIMARY KEY (SocialMediaID),
	CONSTRAINT FK_CV_SocialMedia_from_Platform FOREIGN KEY (PlatformID)
		REFERENCES [Platform](PlatformID),
	CONSTRAINT FK_CV_SocialMedia_from_CV FOREIGN KEY (CVID)
		REFERENCES CV(CVID)
)

GO
INSERT INTO CV_SocialMedia(SocialMediaLink, PlatformID, CVID) VALUES ('https://github.com/HoaNT3010', 4, 1)

----------------------------------
-- Application Position Section --
----------------------------------
GO
CREATE TABLE PositionStatus(
	StatusID INT IDENTITY(1,1) NOT NULL,
	StatusName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_PositionStatus PRIMARY KEY (StatusID)
)

GO
INSERT INTO PositionStatus(StatusName) VALUES ('inActive')
INSERT INTO PositionStatus(StatusName) VALUES ('Pending')
INSERT INTO PositionStatus(StatusName) VALUES ('Hiring')
INSERT INTO PositionStatus(StatusName) VALUES ('Closed')

GO
CREATE TABLE ApplicationPosition(
	PositionID INT IDENTITY(1,1) NOT NULL,
	PositionName NVARCHAR(100) NULL,
	PositionDescription NVARCHAR(1000) NULL,
	HiringQuantity INT NULL,
	CreatedDate DATE NULL,

	StatusID INT NOT NULL, 

	CONSTRAINT PK_ApplicationPosition PRIMARY KEY (PositionID),
	CONSTRAINT FK_ApplicationPosition_from_PositionStatus FOREIGN KEY (StatusID)
		REFERENCES PositionStatus(StatusID)
)

----------------------------------
-- Application Post Section --
----------------------------------

GO
CREATE TABLE WorkingForm(
	FormID INT IDENTITY(1,1) NOT NULL,
	FormName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_WorkingForm PRIMARY KEY (FormID)
)

GO
INSERT INTO WorkingForm(FormName) VALUES ('Full Time - Offline')
INSERT INTO WorkingForm(FormName) VALUES ('Full Time - Online')
INSERT INTO WorkingForm(FormName) VALUES ('Full Time - Hybrid')
INSERT INTO WorkingForm(FormName) VALUES ('Part Time - Offline')
INSERT INTO WorkingForm(FormName) VALUES ('Part Time - Online')
INSERT INTO WorkingForm(FormName) VALUES ('Part Time - Hybrid')



GO
CREATE TABLE ApplicationPost(
	PostID INT IDENTITY(1,1) NOT NULL,
	PostDescription NVARCHAR(1000) NULL,
	Benefit NVARCHAR(1000) NULL,
	Salary NVARCHAR(30) NULL,
	HiringQuantity INT NULL,
	CreateDate DATE NULL,
	StartDate DATE NULL,
	ExpiredDate DATE NULL,

	PositionID INT NOT NULL,
	FormID INT NOT NULL DEFAULT 1,
	StatusID INT NOT NULL DEFAULT 1,

	CONSTRAINT PK_ApplicationPost PRIMARY KEY (PostID),
	CONSTRAINT FK_ApplicationPost_from_ApplicationPosition FOREIGN KEY (PositionID)
		REFERENCES ApplicationPosition (PositionID),
	CONSTRAINT FK_ApplicationPost_from_WorkingForm FOREIGN KEY (FormID)
		REFERENCES WorkingForm (FormID),
	CONSTRAINT FK_ApplicationPost_from_PositionStatus FOREIGN KEY (StatusID)
		REFERENCES PositionStatus (StatusID)
)

GO
CREATE TABLE ApplicationSkill(
	SkillID INT IDENTITY(1,1) NOT NULL,
	SkillName NVARCHAR(100) NULL,
	SkillDescription NVARCHAR(200) NULL,

	PostID INT NOT NULL, 

	CONSTRAINT PK_ApplicationSkill PRIMARY KEY (SkillID),
	CONSTRAINT FK_ApplicationSkill_from_ApplicationPost FOREIGN KEY (PostID)
		REFERENCES ApplicationPost(PostID)
)

GO
CREATE TABLE ApplicationRequirement(
	RequirementID INT IDENTITY(1,1) NOT NULL,
	Requirement NVARCHAR(200) NULL,

	PostID INT NOT NULL, 

	CONSTRAINT PK_ApplicationRequirement PRIMARY KEY (RequirementID),
	CONSTRAINT FK_ApplicationRequirement_from_ApplicationPost FOREIGN KEY (PostID)
		REFERENCES ApplicationPost(PostID)
)

GO
CREATE TABLE Stage(
	StageID INT IDENTITY(1,1) NOT NULL,
	StageName VARCHAR(30) NOT NULL,

	CONSTRAINT PK_Stage PRIMARY KEY (StageID)
)

GO
INSERT INTO Stage(StageName) VALUES('CV Applying')
INSERT INTO Stage(StageName) VALUES('Interview')

GO
CREATE TABLE Application_Stage(
	ID INT IDENTITY(1,1) NOT NULL,
	[Description] NVARCHAR(200) NULL,

	PostID INT NOT NULL,
	StageID INT NOT NULL,

	CONSTRAINT PK_Application_Stage PRIMARY KEY (ID),
	CONSTRAINT FK_Application_Stage_from_ApplicationPost FOREIGN KEY (PostID)
		REFERENCES ApplicationPost(PostID),
	CONSTRAINT FK_Application_Stage_from_Stage FOREIGN KEY (StageID)
		REFERENCES Stage (StageID)
)

GO
CREATE TABLE ApplicationStatus(
	StatusID INT IDENTITY(1,1) NOT NULL,
	StatusName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_ApplicationStatus PRIMARY KEY (StatusID)
)

GO
INSERT INTO ApplicationStatus(StatusName) VALUES ('In-progress')
INSERT INTO ApplicationStatus(StatusName) VALUES ('Cancelled')
INSERT INTO ApplicationStatus(StatusName) VALUES ('Fail')
INSERT INTO ApplicationStatus(StatusName) VALUES ('Success')

GO
CREATE TABLE [Application](
	ApplicationID INT IDENTITY(1,1) NOT NULL,
	ApplyDate DATE NOT NULL,

	StatusID INT NOT NULL DEFAULT 1,
	UserID INT NOT NULL,
	PostID INT NOT NULL,

	CONSTRAINT PK_Application PRIMARY KEY (ApplicationID),
	CONSTRAINT FK_Application_from_ApplicationStatus FOREIGN KEY (StatusID)
		REFERENCES ApplicationStatus (StatusID),
	CONSTRAINT FK_Application_from_User FOREIGN KEY (UserID)
		REFERENCES [User] (UserID),
	CONSTRAINT FK_Application_from_ApplicationPost FOREIGN KEY (PostID)
		REFERENCES ApplicationPost (PostID)
)

----------------------------------
-- Interview Section --
----------------------------------
GO
CREATE TABLE InterviewStatus(
	StatusID INT IDENTITY(1,1) NOT NULL,
	StatusName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_InterviewStatus PRIMARY KEY (StatusID)
)

GO 
INSERT INTO InterviewStatus(StatusName) VALUES ('Booked')
INSERT INTO InterviewStatus(StatusName) VALUES ('Cancelled')
INSERT INTO InterviewStatus(StatusName) VALUES ('Have Occurred')

GO
CREATE TABLE InterviewFormat(
	FormatID INT IDENTITY(1,1) NOT NULL,
	FormatName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_InterviewFormat PRIMARY KEY (FormatID)
)

GO
INSERT INTO InterviewFormat(FormatName) VALUES ('Offline')
INSERT INTO InterviewFormat(FormatName) VALUES ('Online')

GO
CREATE TABLE Interview(
	InterviewID INT IDENTITY(1,1) NOT NULL,
	[Description] NVARCHAR(200) NULL,
	OnlineLink VARCHAR(512) NULL,
	[Address] NVARCHAR(200) NULL,
	InterviewTime SMALLDATETIME NULL,

	StageID INT NOT NULL,
	PostID INT NOT NULL,
	FormatID INT NOT NULL DEFAULT 1,
	StatusID INT NOT NULL DEFAULT 1,
	BookerID INT NOT NULL,

	CONSTRAINT PK_Interview PRIMARY KEY (InterviewID),
	CONSTRAINT FK_Interview_from_Stage FOREIGN KEY (StageID)
		REFERENCES Stage (StageID),
	CONSTRAINT FK_Interview_from_ApplicationPost FOREIGN KEY (PostID)
		REFERENCES ApplicationPost (PostID),
	CONSTRAINT FK_Interview_from_InterviewFormat FOREIGN KEY (FormatID)
		REFERENCES InterviewFormat (FormatID),
	CONSTRAINT FK_Interview_from_InterviewStatus FOREIGN KEY (StatusID)
		REFERENCES InterviewStatus (StatusID),
	CONSTRAINT FK_Interview_from_User FOREIGN KEY (BookerID)
		REFERENCES [User] (UserID)
)

GO
CREATE TABLE Interviewer(
	UserID INT NOT NULL,
	InterviewID INT NOT NULL,

	CONSTRAINT FK_Interviewer_from_User FOREIGN KEY (UserID)
		REFERENCES [User] (UserID),
	CONSTRAINT FK_Interviewer_from_Interview FOREIGN KEY (InterviewID)
		REFERENCES Interview (InterviewID)
)

GO
CREATE TABLE Participant(
	UserID INT NOT NULL,
	InterviewID INT NOT NULL,

	CONSTRAINT FK_Participant_from_User FOREIGN KEY (UserID)
		REFERENCES [User] (UserID),
	CONSTRAINT FK_Participant_from_Interview FOREIGN KEY (InterviewID)
		REFERENCES Interview (InterviewID)
)

GO
CREATE TABLE Evaluation(
	EvaluationID INT IDENTITY(1,1) NOT NULL,
	EvaluationDescription NVARCHAR(1000) NULL,
	Score INT NOT NULL DEFAULT 5,

	InterviewerID INT NOT NULL,
	ParticipantID INT NOT NULL,
	InterviewID INT NOT NULL,

	CONSTRAINT PK_Evaluation PRIMARY KEY (EvaluationID),
	CONSTRAINT FK_Evaluation_from_Interviewer_User FOREIGN KEY (InterviewerID)
		REFERENCES [User] (UserID),
	CONSTRAINT FK_Evaluation_from_Participant_User FOREIGN KEY (ParticipantID)
		REFERENCES [User] (UserID),
	CONSTRAINT FK_Evaluation_from_Interview FOREIGN KEY (InterviewID)
		REFERENCES Interview (InterviewID),
	CONSTRAINT Score_Range_Check CHECK(Score >= 0 AND Score <= 10)
)