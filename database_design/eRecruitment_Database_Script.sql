-- Made and Edit By Nguyễn Thái Hòa
-- Review by Members of team 404NotFound
USE [master]

--Use this query when error "Cannot drop database because it is currently in use."
ALTER DATABASE eRecruitment SET SINGLE_USER WITH ROLLBACK IMMEDIATE

GO
DROP DATABASE IF EXISTS eRecruitment

GO
CREATE DATABASE eRecruitment

GO
USE eRecruitment
-- ===================================================================================================================
-- ==================== 1 SỐ THÔNG TIN CẦN LƯU Ý KHI TẠO APP (DTO & DAO, REQUEST PARAMETERS, ...) ====================
-- * Các bảng đa số sử dụng ID là các khóa chính - những ID này sẽ được database tự động add thêm theo thứ tự tăng dần
--	-> khi ADD thêm thông tin vào bảng có sử dụng ID -> KO TẠO CÂU QUERY CÓ THÊM ID 

-- * Đa số các bảng có giá trị thời gian thì sử dụng DATE (năm/tháng/ngày), trừ các bảng liên quan tới Interview thì sử
--	dụng SMALLDATETIME (năm/tháng/ngày/giờ/phút/giây)

-- * Các bảng sẽ được các bảng khác tham chiếu tới rất nhiều (đặc biệt bảng User, ApplicationPost). Cần lưu ý trong việc
--	DELETE thông tin.

-- * Các cột như NAME, DESCRIPTION,... đa số sử dụng kiểu dữ liệu NVARCHAR -> Lưu ý khi viết các Class DAO (getNString)
--	và bắt các request parameter.

-- * Các cột chứa ĐƯỜNG DẪN (LINK) sử dụng VARCHAR

-- * Mức lương của vị trí sử dụng NVARCHAR - giúp cho người tạo bài đăng có customize được mức lương (1 - 10$, Arround 10$, 
--	Negotiatable,...)

-- * Database chưa có Trigger để auto-update các giá trị khi có giá trị khác thay đổi (vd: HiringQuantity) -> Sẽ update
--	thêm (Nếu có thêm thời gian) -> Cần phải viết câu query để update

-- * BẢNG User_Role: Theo SRS thì chỉ có user với role HR Staff thì mới có 2 Role cùng 1 lúc (HR Staff + Interviewer), các 
--	user với các role còn lại sẽ chỉ có 1 role 
-- ===================================================================================================================

--------------------------
-- Account/User Section --
--------------------------

-- Bảng chứa danh sách các role cho người dùng
-- bao gồm RoleID: ID của role; RoleName: Tên của role.
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

-- Bảng chứa các status (trạng thái) của tài khoản người dùng (user)
-- bao gồm StatusID: ID của status;
--	StatusName: Tên của status.
GO
CREATE TABLE UserStatus(
	StatusID INT IDENTITY(1,1) NOT NULL,
	StatusName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_UserStatus PRIMARY KEY (StatusID)
)

GO
INSERT INTO UserStatus(StatusName) VALUES('Active')
INSERT INTO UserStatus(StatusName) VALUES('inActive')

-- Bảng chưa danh sách các giới tính
-- bao gồm GenderID: ID của giới tính;
--	GenderName: Tên giới tính.
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

-- Bảng chứa danh sách người dùng
-- bao gồm UserID: ID của người dùng; 
--	Email: email của người dùng (dùng để đăng kí tài khoản và đăng nhập| Ko được trùng);
--	Password: Mật khẩu của người dùng; 
--	Avatar: Chứa link dẫn tới ảnh đại diện của người dùng (ảnh được lưu trong folder của app);
--	FirstName: tên của người dùng
--	LastName: Họ (và tên đệm) của người dùng
--		Khóa ngoại:
--	Gender: Chứa ID giới tính tham chiếu tới bảng Gender
--	Status: Chứa ID status tham chiếu tới bảng UserStatus
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
INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) VALUES ('testCandidate1@gmail.com', '111111', NULL, N'Candidate 1', N'Test', 1, 1)
INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) VALUES ('testCandidate2@gmail.com', '111111', NULL, N'Candidate 2', N'Test', 1, 1)

INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) VALUES ('testHRStaff@gmail.com', '111111', NULL, N'HR Staff', N'Test', 1, 1)
INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) VALUES ('testHRManager@gmail.com', '111111', NULL, N'HR Manager', N'Test', 1, 1)
INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) VALUES ('testInterviewer@gmail.com', '111111', NULL, N'Interviewer', N'Test', 1, 1)
INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) VALUES ('testSystemAdmin@gmail.com', '111111', NULL, N'System Admin', N'Test', 1, 1)

-- Bảng chứa các Role tương ứng với User
-- Thiết kế theo nguyên tắc mỗi User có thể có nhiều Role (mqh N_N)
-- bao gồm:
--		Khóa ngoại:
--	UserID: Chứa ID của người dùng tham chiếu tới bảng User
--	RoleID: Chứa ID của role tham chiếu tới bảng Role
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
INSERT INTO User_Role(UserID, RoleID) VALUES (2, 1)
INSERT INTO User_Role(UserID, RoleID) VALUES (3, 1)
INSERT INTO User_Role(UserID, RoleID) VALUES (4, 2)
INSERT INTO User_Role(UserID, RoleID) VALUES (5, 3)
INSERT INTO User_Role(UserID, RoleID) VALUES (6, 4)
INSERT INTO User_Role(UserID, RoleID) VALUES (7, 5)

--------------------------
-- CV Section --
--------------------------

-- Bảng chứa thông tin CV của người dùng
-- CV sẽ gồm các bảng phụ chứa thêm thông tin của CV
-- Mỗi 1 người dùng chỉ có 1 CV (1 Candidate -> 1 CV)
-- Chỉ có candidate thì mới có CV
-- bao gồm: CVID: ID của CV
--	FirstName: tên của ứng viên
--	LastName: Họ (và tên đệm) của ứng viên
--	Avatar: Link dẫn tới ảnh đại diện của ứng viên (ảnh đại diện được lưu trong folder của app)
--	Dob: Ngày sinh của ứng viên
--	Introduction: Giới thiệu ngắn về ứng viên
--	Email: Email của ứng viên. Ko được trùng
--	PhoneNumber: Số điện thoại của ứng viên
--	 Address: Địa chỉ của ứng viên (Số nhà, Đường, Phường\Xã\Huyện)
--	City: thành phố của ứng viên
--		Khóa ngoại:
--	Gender: Chứa ID giới tính tham chiếu tới bảng Gender
--	UserID: Chứa ID của người dùng (ứng viên) tham chiếu tới bảng User
GO
CREATE TABLE CV(
	CVID INT IDENTITY(1,1) NOT NULL,
	FirstName NVARCHAR(50) NULL,
	LastName NVARCHAR(50) NULL,
	Avatar NVARCHAR(512) NULL,
	Dob DATE NULL,
	Introduction NVARCHAR(1000) NULL,
	Email VARCHAR(254) NULL,
	PhoneNumber VARCHAR(15) NULL,
	[Address] NVARCHAR(100) NULL,
	City NVARCHAR(100) NULL,

	Gender INT NULL,
	UserID INT NULL,

	CONSTRAINT PK_CV PRIMARY KEY (CVID),
	CONSTRAINT FK_CV_from_Gender FOREIGN KEY (Gender)
		REFERENCES Gender(GenderID),
	CONSTRAINT FK_CV_from_User FOREIGN KEY (UserID)
		REFERENCES [User](UserID)
)

GO
INSERT INTO CV(FirstName, LastName, Avatar, Dob, Introduction, Email, PhoneNumber, [Address], City, Gender, UserID)
	VALUES(N'Test Candidate', N'Curriculum Vitae', NULL, '2000-01-01', N'This is a test CV for the web application eRecruitment. The purpose of this CV is testing functions of the web application such as: View CV, update CV,...', 'testCandidate@gmail.com', '0911111222', N'1 D2 Khu Cong Nghe Cao', N'Ho Chi Minh', 1, 1)

INSERT INTO CV(FirstName, LastName, Avatar, Dob, Introduction, Email, PhoneNumber, [Address], City, Gender, UserID)
	VALUES(N'Test Candidate', N'Curriculum Vitae', NULL, '2000-01-01', N'This is a test CV for the web application eRecruitment. The purpose of this CV is testing functions of the web application such as: View CV, update CV,...', 'testCandidate2@gmail.com', '0911111222', N'1 D2 Khu Cong Nghe Cao', N'Ho Chi Minh', 1, 1)

-- Bảng phụ của CV chứa thông tin kỹ năng của ứng viên
-- bao gồm: SkilID: ID của kỹ năng
--	SkillName: Tên kỹ năng
--	SkillDescription: Mô tả của kỹ năng
--		Khóa ngoại: 
--	CVID: ID của CV tham chiếu tới bảng CV
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

-- Bảng phụ của CV chứa sở thích của ứng viên
-- bao gồm: InterestID: ID của sở thích
--	InterestName: Tên của sở thích
--		Khóa ngoại: 
--	CVID: ID của CV tham chiếu tới bảng CV
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

-- Bảng phụ của CV chứa các chứng chỉ của ứng viên
-- bao gồm: CertificateID: ID của chứng chỉ
--	CertificateName: tên chứng chỉ
--	CertificateLink: đường link dẫn đến chứng chỉ
--		Khóa ngoại: 
--	CVID: ID của CV tham chiếu tới bảng CV
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

-- Bảng phụ của CV chứa các thành tựu của ứng viên (Project, giải thưởng)
-- bao gồm: AchievementID: ID của thành tựu
--	AchievementName: tên của thành tựu
--	AchievementDescription: Mô tả của thành tựu
--	AchievementLink: Đường link dẫn tới thành tựu của ứng viên
--		Khóa ngoại: 
--	CVID: ID của CV tham chiếu tới bảng CV
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


-- Bảng phụ của CV chứa kinh nghiệm làm việc của ứng viên
-- bao gồm: ExperienceID: ID của kinh nghiệm
--	JobtTitle: chức danh của công việc
--	OrganizationName: tên của tổ chức
--	ExperienceDescription: Mô tả của kinh nghiệm làm việc
--	ExperienceDuration: thời gian làm công việc
--		Khóa ngoại: 
--	CVID: ID của CV tham chiếu tới bảng CV
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

-- Bảng phụ của CV chứa kỹ năng ngôn ngữ của ứng viên
-- bao gồm: LanguageID: ID của ngôn ngữ
--	LanguageName: tên ngôn ngữ
--	LanguageDescription: Mô tả ngôn ngữ (trình độ,...)
--		Khóa ngoại: 
--	CVID: ID của CV tham chiếu tới bảng CV
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

-- Bảng phụ gồm các tình trạng học vấn
-- Dùng để bảng CV_Education tham chiếu tới - là 1 bảng phụ dùng phục vụ cho CV
-- bao gồm: StatusID: ID của status
--	StatusName: tên của status
GO
CREATE TABLE EducationStatus(
	StatusID INT IDENTITY(1,1) NOT NULL,
	StatusName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_EducationStatus PRIMARY KEY (StatusID)
)

GO
INSERT INTO EducationStatus(StatusName) VALUES('Complete')
INSERT INTO EducationStatus(StatusName) VALUES('In-progress')

-- Bảng phụ của CV chứa thông tin học vấn của ứng viên
-- bao gồm: EducationID: ID của mức học vấn
--	EducationName: tên của mức học vấn
--	OrganizationName: tên của tổ chức mà ứng viên tham gia học vấn
--		Khóa ngoại: 
--	StatusID: Chứa ID của tình trạng học vấn, tham chiếu tới bảng EducationStatus
--	CVID: ID của CV tham chiếu tới bảng CV
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

-- Bảng phụ gồm các nền tảng Website mạng xã hội
-- Dùng để bảng CV_SocialMedia tham chiếu tới - là 1 bảng phụ dùng phục vụ cho CV
-- bao gồm: PlatformID: ID của nền tảng
--	PlatformName: tên của nền tảng
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

-- Bảng phụ của CV chứa thông tin liên quan tới mạng xã hội của ứng viên
-- bao gồm: SocialMediaID: ID của thông tin mxh
--	SocialMediaLink: đường link dẫn tới trang mxh của ứng viên
--		Khóa ngoại: 
--	PlatformID: chứa ID thông tin của nền tảng mxh, tham chiếu tới bảng Platform
--	CVID: ID của CV tham chiếu tới bảng CV
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

-- Bảng chứa status của các vị trí công việc (Application Position) và bài post tuyển dụng cho vị trí tương ứng (Application Post)
-- Dùng để bảng ApplicationPosition và ApplicationPost tham chiếu để lấy status
-- bao gồm: StatusID: ID của status
--	StatusName: tên của status
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

-- Bảng chứa các vị trí công việc (Application Position) mà công ty cần tuyển dụng
-- bao gồm: PositionID: ID của vị trí 
--	PositionName: tên vị trí
--	PositionDescription: Mô tả vị trí
--	HiringQuantity: Số lượng mà vị trí đó cần yêu cầu
--	CreatedDate: Ngày khởi tạo vị trí
--		Khóa ngoại:
--	StatusID: Chứa ID status của vị trí, tham chiếu tới bảng PositionStatus
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

GO
INSERT INTO ApplicationPosition(PositionName, PositionDescription, HiringQuantity, CreatedDate, StatusID) VALUES(N'Front-end Developer', N'Lập trình viên Front-end là người tập trung phát triển phía Client Side, nói một cách đơn giản dễ hiểu là tập trung vào mảng phát triển xây dựng giao diện và trải nghiệm cho người dùng, là người phụ trách phát triển hiển thị và trải nghiệm người dùng cho ứng dụng web. Front-end Developer chính là người quyết định cái nhìn đầu tiên của người dùng về trang web, đồng thời mang lại một trang web dễ dàng thao tác và sử dụng.', 20, '2022-10-7', 3)
INSERT INTO ApplicationPosition(PositionName, PositionDescription, HiringQuantity, CreatedDate, StatusID) VALUES(N'Front-end Developer test', N'Lập trình viên Front-end là người tập trung phát triển phía Client Side, nói một cách đơn giản dễ hiểu là tập trung vào mảng phát triển xây dựng giao diện và trải nghiệm cho người dùng, là người phụ trách phát triển hiển thị và trải nghiệm người dùng cho ứng dụng web. Front-end Developer chính là người quyết định cái nhìn đầu tiên của người dùng về trang web, đồng thời mang lại một trang web dễ dàng thao tác và sử dụng.', 10, '2022-10-7', 3)

----------------------------------
-- Application Post Section --
----------------------------------

-- Bảng chứa các hình thức làm việc của công việc (Fulltime, partime,...)
-- bao gồm: FormID: ID của hình thức
--	FormName: tên hình thức làm việc
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


-- Bảng chứa các bài đăng tuyển dụng của 1 vị trí làm việc (Application Position)
-- Bảng có những bảng phụ chứa thêm các thông tin của bài đăng
-- Mỗi vị trí có thể có nhiều bài đăng
-- bao gồm: PostID: ID của bài đăng
--	PostDescription: Mô tả bài đăng
--	Salary: Mức lương - nhập bằng chữ
--	HiringQuantity: Số lượng người tuyển dụng - Ko được lớn hơn so với số người tuyển dụng của vị trí
--	CreateDate: Ngày khởi tạo bài đăng
--	StartDate: Ngày bắt đầu tuyển dụng - đến ngày này thì ứng viên mới được apply vào bài đăng này
--	ExpiredDate: Ngày kết thúc tuyển dụng - qua ngày này sẽ ko nhận thêm ứng viên nào apply vào bài đăng này
--		Khóa ngoại:
--	PosiotionID: Chứa ID vị trí công việc tương ứng của bài đăng, tham chiếu tới bảng ApplicationPosition
--	FormID: Chứa ID hình thức làm việc tương ứng của bài đăng, tham chiếu tới bảng WorkingForm
--	StatusID: Chứa ID status của bài đăng, tham chiếu tới bảng PositionStatus
GO
CREATE TABLE ApplicationPost(
	PostID INT IDENTITY(1,1) NOT NULL,
	PostDescription NVARCHAR(1000) NULL,
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
INSERT INTO ApplicationPost(PostDescription, Salary, HiringQuantity, CreateDate, StartDate, ExpiredDate, PositionID, FormID, StatusID) 
VALUES (N'Tham gia phát triển các dự án về Web, xây dựng các chức năng front-end của Website, Web application.

Triển khai giao diện HTML/CSS Javascript theo yêu cầu của khách hàng trên hệ thống website xây dựng sẵn

Phối hợp với các back-end developers và web designers để cải thiện tính khả dụng

Đảm bảo tiêu chuẩn đồ họa chất lượng cao và sự thống nhất trong brand

Thu thập ý kiến phản hồi và xây dựng các hướng giải quyết cho người sử dụng và khách hàng

Nghiên cứu, tìm hiểu các công nghệ về HTML/CSS Javascript mới nhất để áp dụng cái tiến sản phẩm', 
N'Around $3000', 10, '2022-10-7', '2022-10-10', '2023-10-10', 1, 1, 3)

INSERT INTO ApplicationPost(PostDescription, Salary, HiringQuantity, CreateDate, StartDate, ExpiredDate, PositionID, FormID, StatusID) 
VALUES (N' CLOSED - Tham gia phát triển các dự án về Web, xây dựng các chức năng front-end của Website, Web application.

Triển khai giao diện HTML/CSS Javascript theo yêu cầu của khách hàng trên hệ thống website xây dựng sẵn

Phối hợp với các back-end developers và web designers để cải thiện tính khả dụng

Đảm bảo tiêu chuẩn đồ họa chất lượng cao và sự thống nhất trong brand

Thu thập ý kiến phản hồi và xây dựng các hướng giải quyết cho người sử dụng và khách hàng

Nghiên cứu, tìm hiểu các công nghệ về HTML/CSS Javascript mới nhất để áp dụng cái tiến sản phẩm', 
N'Around $3000', 5, '2022-10-7', '2022-10-10', '2022-10-13', 1, 1, 4)

INSERT INTO ApplicationPost(PostDescription, Salary, HiringQuantity, CreateDate, StartDate, ExpiredDate, PositionID, FormID, StatusID) 
VALUES (N' CLOSED - Tham gia phát triển các dự án về Web, xây dựng các chức năng front-end của Website, Web application.

Triển khai giao diện HTML/CSS Javascript theo yêu cầu của khách hàng trên hệ thống website xây dựng sẵn

Phối hợp với các back-end developers và web designers để cải thiện tính khả dụng

Đảm bảo tiêu chuẩn đồ họa chất lượng cao và sự thống nhất trong brand

Thu thập ý kiến phản hồi và xây dựng các hướng giải quyết cho người sử dụng và khách hàng

Nghiên cứu, tìm hiểu các công nghệ về HTML/CSS Javascript mới nhất để áp dụng cái tiến sản phẩm', 
N'Around $3000', 10, '2022-10-7', '2022-10-10', '2022-10-13', 2, 1, 4)

-- Bảng phụ chứa thêm thông tin cho các bài đăng tuyển dụng (Application Post)
-- Chứa thông tin phúc lợi của bài đăng tuyển dụng
-- bao gồm: BenefitID: ID của phúc lơi
--	Benefit: mô tả phúc lợi
--		Khóa ngoại:
--	PostID: Chứa ID của bài đăng tương ứng, tham chiếu tới bảng ApplicationPost
 GO
CREATE TABLE ApplicationBenefit(
	BenefitID INT IDENTITY(1,1) NOT NULL,
	Benefit NVARCHAR(200) NULL,

	PostID INT NOT NULL, 

	CONSTRAINT PK_ApplicationBenefit PRIMARY KEY (BenefitID),
	CONSTRAINT FK_ApplicationBenefit_from_ApplicationPost FOREIGN KEY (PostID)
		REFERENCES ApplicationPost(PostID)
)

GO
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Attractive salary package and 100% Gross Salary in probation period', 1)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'13th-month salary', 1)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Monthly performance bonus. (over $600 on average and over $2000 for top performers)', 1)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'18 days of annual leaves (cashback allowed if not used) and plus 4 days for an oversea company trip', 1)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Multiple allowances (Lunch, Gym, Parking, Birthday/Tet/Wedding voucher... )', 1)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Full social, healthy and unemployment insurance', 1)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Premium healthcare insurance', 1)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Annual company trip abroad', 1)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Monthly team-building activities (Bowling, Go-Kart,....) and special celebrations on Autumn Festival, Halloween, Christmas, Tet, ...', 1)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Monthly happy lunch/birthday celebration and happy hours every day with free snacks, soft drinks, fruit, and coffee', 1)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Sports activities (Badminton, Ping Pong, etc...)', 1)

INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Attractive salary package and 100% Gross Salary in probation period', 2)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'13th-month salary', 2)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Monthly performance bonus. (over $600 on average and over $2000 for top performers)', 2)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'18 days of annual leaves (cashback allowed if not used) and plus 4 days for an oversea company trip', 2)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Multiple allowances (Lunch, Gym, Parking, Birthday/Tet/Wedding voucher... )', 2)
INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Full social, healthy and unemployment insurance', 2)

INSERT INTO ApplicationBenefit(Benefit, PostID) VALUES(N'Attractive salary package and 100% Gross Salary in probation period', 3)

-- Bảng phụ chứa thêm thông tin cho các bài đăng tuyển dụng (Application Post)
-- Chứa các kỹ năng mà bài đăng tuyển dụng yêu cầu
-- bao gồm: SkillID: ID của kỹ năng
--	SkillName: tên kỹ năng
--	SkillDescription: Mô tả kỹ năng
--		Khóa ngoại:
--	PostID: Chứa ID của bài đăng tương ứng, tham chiếu tới bảng ApplicationPost
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
INSERT INTO ApplicationSkill(SkillName, SkillDescription, PostID) VALUES (N'Front-End', N'5+ Years', 1)
INSERT INTO ApplicationSkill(SkillName, SkillDescription, PostID) VALUES (N'JavaScript', N'Advance Knowledge', 1)
INSERT INTO ApplicationSkill(SkillName, SkillDescription, PostID) VALUES (N'TypeScript', N'Advance Knowledge', 1)
INSERT INTO ApplicationSkill(SkillName, SkillDescription, PostID) VALUES (N'ReactJS', N'5+ Years', 1)

INSERT INTO ApplicationSkill(SkillName, SkillDescription, PostID) VALUES (N'Front-End', N'5+ Years', 2)
INSERT INTO ApplicationSkill(SkillName, SkillDescription, PostID) VALUES (N'JavaScript', N'Advance Knowledge', 2)

INSERT INTO ApplicationSkill(SkillName, SkillDescription, PostID) VALUES (N'Front-End', N'5+ Years', 3)

-- Bảng phụ chứa thêm thông tin cho các bài đăng tuyển dụng (Application Post)
-- Chứa các yêu cầu của bài đăng tuyển dụng cần cho vị trí tương ứng
-- bao gồm: RequirementID: ID của yêu cầu
--	Requirement: mô tả yêu cầu
--		Khóa ngoại:
--	PostID: Chứa ID của bài đăng tương ứng, tham chiếu tới bảng ApplicationPost
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
INSERT INTO ApplicationRequirement(Requirement, PostID) VALUES(N'A Bachelor’s Degree in any relevant major (e.g. Information Technology, Computer Science, etc.)', 1)
INSERT INTO ApplicationRequirement(Requirement, PostID) VALUES(N'Proficiency in English (both verbal and written)', 1)
INSERT INTO ApplicationRequirement(Requirement, PostID) VALUES(N'Having experience in leading software development projects', 1)
INSERT INTO ApplicationRequirement(Requirement, PostID) VALUES(N'Having previous full-stack/ backend experience is a strong plus', 1)
INSERT INTO ApplicationRequirement(Requirement, PostID) VALUES(N'A strong fundamental understanding of software development', 1)
INSERT INTO ApplicationRequirement(Requirement, PostID) VALUES(N'Strong self-discipline for delivering well-tested, complete features/modules under a tight schedule and the capability for rational thinking', 1)

INSERT INTO ApplicationRequirement(Requirement, PostID) VALUES(N'A Bachelor’s Degree in any relevant major (e.g. Information Technology, Computer Science, etc.)', 2)
INSERT INTO ApplicationRequirement(Requirement, PostID) VALUES(N'Proficiency in English (both verbal and written)', 2)

INSERT INTO ApplicationRequirement(Requirement, PostID) VALUES(N'A Bachelor’s Degree in any relevant major (e.g. Information Technology, Computer Science, etc.)', 3)


-- Bảng phụ chứa các vòng của quá trình tuyển dụng
-- Sử dụng để các bảng tham chiếu
-- để biết được quá trình tuyển dụng gồm những vòng nào
-- bao gồm: StageID: ID của vòng
--	StageName: Tên của vòng
GO
CREATE TABLE Stage(
	StageID INT IDENTITY(1,1) NOT NULL,
	StageName VARCHAR(30) NOT NULL,

	CONSTRAINT PK_Stage PRIMARY KEY (StageID)
)

GO
INSERT INTO Stage(StageName) VALUES('CV Applying')
INSERT INTO Stage(StageName) VALUES('Interview')
INSERT INTO Stage(StageName) VALUES('Finish')
INSERT INTO Stage(StageName) VALUES('Final Evaluation')

-- Bảng phụ chứa thêm thông tin cho các bài đăng tuyển dụng (Application Post)
-- Chứa thông tin các vòng mà ứng viên cần phải trải qua của bài đăng ứng tuyển tương ứng
-- bao gồm: ID: ID vòng của bài đăng tương ứng
--	Description: Mô tả thông tin của vòng tương ứng
--		Khóa ngoại:
--	PostID: Chứa ID của bài đăng tương ứng, tham chiếu tới bảng ApplicationPost
--	StageID: chứa ID của vòng, tham chiếu tới bảng Stage
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
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Applying CV and Waiting For Approval', 1, 1)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Candidate''s Skills and Knowledge', 1, 2)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Contract Negotiation', 1, 2)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Final Evalution of Candidate', 1, 4)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Kết thúc quá trình tuyển dụng. Candidate nhân kết quả cuối cùng', 1, 3)

INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Ứng tuyển và chờ xét duyệt CV', 2, 1)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Candidate''s Skills and Knowledge', 2, 2)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Contract Negotiation', 2, 2)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Final Evalution of Candidate', 2, 4)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Kết thúc quá trình tuyển dụng. Candidate nhân kết quả cuối cùng', 2, 3)

INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Ứng tuyển và chờ xét duyệt CV', 3, 1)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Phỏng vấn kiến thức và kỹ năng của ứng viên', 3, 2)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Phòng vấn về hợp đồng lao động', 3, 2)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Đánh giá tổng kết quá trình tuyển dụng', 3, 4)
INSERT INTO Application_Stage([Description], PostID, StageID) VALUES(N'Kết thúc quá trình tuyển dụng. Candidate nhân kết quả cuối cùng', 3, 3)

-- Bảng chứa các status của quá trình ứng tuyển của ứng viên
-- bao gồm: StatusID: ID của status
--	StatusName: tên của status
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

-- Bảng chứa quá trình ứng tuyển của ứng viên với các bài đăng tuyển dụng
-- bao gồm: ApplicationID: ID của quá trình tuyển dụng
--	ApplyDate: ngày ứng tuyển
--		Khóa ngoại:
--	StatusID: Chứa ID status của quá trình tuyển dụng, tham chiếu tới bảng ApplicationStatus - Sẽ được update theo quá trình ứng viên đậu, hủy, phỏng vấn pass/fail,...
--	StageID: Chứa ID của vòng ứng tuyển mà ứng viên đang ở trong quá trình tuyển dụng - tương ứng với các vòng của bài đăng tuyển dụng tương ứng, tham chiếu tới bảng Stage
--	UserID: Chứa ID của ứng viên (người dùng), tham chiếu tới bảng User
-- PostID: Chứa ID của bài đăng tuyển dụng tương ứng, tham chiếu tới bảng ApplicationPost
GO
CREATE TABLE [Application](
	ApplicationID INT IDENTITY(1,1) NOT NULL,
	ApplyDate DATE NOT NULL,

	StatusID INT NOT NULL DEFAULT 1,
	StageID INT NOT NULL DEFAULT 1,
	UserID INT NOT NULL,
	PostID INT NOT NULL,

	CONSTRAINT PK_Application PRIMARY KEY (ApplicationID),
	CONSTRAINT FK_Application_from_ApplicationStatus FOREIGN KEY (StatusID)
		REFERENCES ApplicationStatus (StatusID),
	CONSTRAINT FK_Application_from_Application_Stage FOREIGN KEY (StageID)
		REFERENCES Application_Stage (ID),
	CONSTRAINT FK_Application_from_User FOREIGN KEY (UserID)
		REFERENCES [User] (UserID),
	CONSTRAINT FK_Application_from_ApplicationPost FOREIGN KEY (PostID)
		REFERENCES ApplicationPost (PostID)
)

GO
INSERT INTO [Application](ApplyDate, StatusID, StageID, UserID, PostID) VALUES('2022-10-12', 1, 4, 2, 2)
INSERT INTO [Application](ApplyDate, StatusID, StageID, UserID, PostID) VALUES('2022-10-13', 1, 4, 3, 2)
INSERT INTO [Application](ApplyDate, StatusID, StageID, UserID, PostID) VALUES('2022-10-12', 1, 9, 1, 3)

----------------------------------
-- Interview Section --
----------------------------------
-- Bảng chứa status của buổi phỏng vấn
-- bao gồm: StatusID: ID của status
--	StatusName: Tên của status
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

-- Bảng chứa các hình thức phỏng vấn (On/Off)
-- bao gồm: FormatID: ID format
--	FormatName: tên format
GO
CREATE TABLE InterviewFormat(
	FormatID INT IDENTITY(1,1) NOT NULL,
	FormatName VARCHAR(20) NOT NULL,

	CONSTRAINT PK_InterviewFormat PRIMARY KEY (FormatID)
)

GO
INSERT INTO InterviewFormat(FormatName) VALUES ('Offline')
INSERT INTO InterviewFormat(FormatName) VALUES ('Online')

-- Bảng chứa thông tin buổi phỏng vấn 
-- Gồm các bảng phụ chứa thêm thông tin của những người tham gia buổi PV
-- bao gồm: InterviewID: ID của buổi phỏng vấn
--	Description: Mô tả buổi PV
--	OnlineLink: Link của buổi PV (Nếu PV qua hình thức Online)
--	Address: Địa chỉ của buổi PV (Nếu PV qua hình thức Offline)
--	InterviewTIme: thời gian bắt đầu PV
--		Khóa ngoại:
--	StageID: Chứa ID vòng của buổi PV, tham chiếu tới bảng Stage
--	PostID: Chứa ID của bài đăng tuyển dụng tương ứng, tham chiếu tới bảng ApplicationPost
--	FormatID: Chứa ID hình thức của buổi PV, tham chiếu tới bảng InterviewFormat
--	StatusID: Chứa ID status của buổi PV, tham chiếu tới bảng InterviewStatus
--	BookerID: Chứa ID của người lên lịch buổi PV (HR Staff), tham chiếu tới bảng User
GO
CREATE TABLE Interview(
	InterviewID INT IDENTITY(1,1) NOT NULL,
	[Description] NVARCHAR(200) NULL,
	OnlineLink VARCHAR(512) NULL,
	[Address] NVARCHAR(200) NULL,
	InterviewTime SMALLDATETIME NULL,
	MaxCandidate INT NOT NULL,

	StageID INT NOT NULL,
	PostID INT NOT NULL,
	FormatID INT NOT NULL DEFAULT 1,
	StatusID INT NOT NULL DEFAULT 1,
	BookerID INT NOT NULL,

	CONSTRAINT PK_Interview PRIMARY KEY (InterviewID),
	CONSTRAINT FK_Interview_from_Stage FOREIGN KEY (StageID)
		REFERENCES Application_Stage (ID),
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
INSERT INTO Interview([Description], OnlineLink, [Address], InterviewTime, MaxCandidate, StageID, PostID, FormatID, StatusID, BookerID)
	VALUES(N'Candidate''s Skills and Knowledge', 'https://meet.google.com/', NULL, '2022-10-20 10:00',10, 8, 3, 2, 3, 4);

INSERT INTO Interview([Description], OnlineLink, [Address], InterviewTime, MaxCandidate, StageID, PostID, FormatID, StatusID, BookerID)
	VALUES(N'Contract Negotiation', 'https://meet.google.com/', NULL, '2022-10-25 22:00',10, 9, 3, 2, 1, 4)


-- Bảng chứa thông tin thêm của buổi PV (Interview)
-- chứa thông tin của những người sẽ PV ứng viên
-- bao gồm:	InterviewerID: ID của người PV
--		Khóa ngoại:
--	UserID: ID của người PV, tham chiếu tới bảng User
--	InterviewID: ID của buổi PV, tham chiếu tới bảng Interview
GO
CREATE TABLE Interviewer(
	InterviewerID INT IDENTITY(1,1) NOT NULL,
	UserID INT NOT NULL,
	InterviewID INT NOT NULL,

	CONSTRAINT PK_Interviewer PRIMARY KEY (UserID, InterviewID),
	CONSTRAINT FK_Interviewer_from_User FOREIGN KEY (UserID)
		REFERENCES [User] (UserID),
	CONSTRAINT FK_Interviewer_from_Interview FOREIGN KEY (InterviewID)
		REFERENCES Interview (InterviewID)
)

GO
INSERT INTO Interviewer(UserID, InterviewID) VALUES(6, 1)
INSERT INTO Interviewer(UserID, InterviewID) VALUES(5, 1)

INSERT INTO Interviewer(UserID, InterviewID) VALUES(5, 2)
INSERT INTO Interviewer(UserID, InterviewID) VALUES(6, 2)

-- Bảng chứa thông tin thêm của buổi PV (Interview)
-- chứa thông tin của ứng viên tham gia buổi PV
-- bao gồm:	ParticipantID: ID của ứng viên
--	InterviewTime: thời gian bắt đầu PV của ứng viên - mỗi ứng viên trong cùng 1 buổi PV
--														có thể có thời gian PV khác nhau (cách nhau 30p,...)
--		Khóa ngoại:
--	UserID: ID của ứng viên, tham chiếu tới bảng User
--	InterviewID: ID của buổi PV, tham chiếu tới bảng Interview
GO

CREATE TABLE InterviewResult(
	ResultID INT NOT NULL PRIMARY KEY,
	ResultName NVARCHAR(20) NOT NULL
)
GO
-- Các ứng viên sẽ có trạng thái kèm theo buổi phỏng vấn
-- Đang chờ phỏng vấn, miễn phỏng vấn, pass, fail
INSERT INTO InterviewResult (ResultID, ResultName) VALUES (1,N'Chờ phỏng vấn')
GO
INSERT INTO InterviewResult (ResultID, ResultName) VALUES (2,N'Miễn phỏng vấn')
GO
INSERT INTO InterviewResult (ResultID, ResultName) VALUES (3,N'Đậu phỏng vấn')
GO
INSERT INTO InterviewResult (ResultID, ResultName) VALUES (4,N'Rớt phỏng vấn')
GO

CREATE TABLE Participant(
	ParticipantID INT IDENTITY(1,1) NOT NULL,
	UserID INT NOT NULL,
	InterviewID INT NOT NULL,
	InterviewTime SMALLDATETIME NULL,
	ResultID INT NOT NULL,

	CONSTRAINT PK_Participant PRIMARY KEY (UserID, InterviewID),
	CONSTRAINT FK_Participant_from_User FOREIGN KEY (UserID)
		REFERENCES [User] (UserID),
	CONSTRAINT FK_Participant_from_Interview FOREIGN KEY (InterviewID)
		REFERENCES Interview (InterviewID),
	CONSTRAINT FK_Participant_from_InterviewResult FOREIGN KEY (ResultID)
		REFERENCES InterviewResult (ResultID)
)

GO
INSERT INTO Participant(UserID, InterviewID, InterviewTime, ResultID) VALUES(1, 1, '2022-10-20 10:00', 3)
INSERT INTO Participant(UserID, InterviewID, InterviewTime, ResultID) VALUES(1, 2, '2022-10-25 22:00', 1)

-- Bảng chứa thông tin đánh giá ứng viên trong buổi PV
-- 1 kết quả đánh giá sẽ cho 1 ứng viên (Participant), do 1 người đánh giá (Interviewer) và trong 1 buổi PV
-- bao gồm: EvaluationID: ID của bản đánh giá viên
--	EvaluationDescription: mô tả đánh giá ứng viên
--	Score: Điểm đánh giá ứng viên - theo thang điểm 10
--		Khóa ngoại: 
--	InterviewerID: Chứa ID của người đánh giá (Interviewer), tham chiếu tới bảng Interviewer
--	ParticipantID: Chứa ID của ứng viên (Participant), tham chiếu tới bảng Participant
--	InterviewID: Chứa ID của buổi PV tương ứng, tham chiếu tới bảng Interview
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

GO
INSERT INTO Evaluation(EvaluationDescription, Score, InterviewerID, ParticipantID, InterviewID) 
	VALUES(N'Best Candidate Ever. Hire Immediately', 10, 5, 1, 1)
INSERT INTO Evaluation(EvaluationDescription, Score, InterviewerID, ParticipantID, InterviewID) 
	VALUES(N'Best Candidate Ever. Hire Immediately', 9, 6, 1, 1)

INSERT INTO Evaluation(EvaluationDescription, Score, InterviewerID, ParticipantID, InterviewID) 
	VALUES(N'Best Candidate Ever. Hire Immediately To The Company', 8, 5, 1, 2)
INSERT INTO Evaluation(EvaluationDescription, Score, InterviewerID, ParticipantID, InterviewID) 
	VALUES(N'Best Candidate Ever. Hire Immediately To The Company', 9, 6, 1, 2)
