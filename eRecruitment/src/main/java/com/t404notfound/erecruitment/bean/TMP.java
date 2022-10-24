//public void saveAchievement(ArrayList<AchievementDTO> achievementList, int CVID) {
//        String sql = "INSERT INTO CV_Achievement( "
//                + "AchievementName, "
//                + "AchievementLink, "
//                + "CVID "
//                + ") VALUES (?,?,?) ";
//        try {
//            for (AchievementDTO x : achievementList) {
//                Connection con = DBUtil.getConnection();
//                PreparedStatement ps = con.prepareStatement(sql);
//                ps.setString(1, x.getAchievementName());
//                ps.setString(2, x.getAchievementLink());
//                ps.setInt(3, CVID);
//
//                ps.execute();
//            }
//
//        } catch (SQLException e) {
//            System.out.print("CV save error: " + e.getMessage());
//        }
//    }

//public int saveCV(String firstName, String lastName, String avatar, Date dob, String introduction, String email, String phoneNumber, String address, String city, String gender, int userID, ArrayList skills, ArrayList interests, ArrayList certificates, ArrayList achivements, ArrayList experiences, ArrayList languages, ArrayList educations, ArrayList socialMedias) {
//        String sql = "INSERT INTO CV(FirstName, "
//                + "LastName, "
//                + "Avatar, "
//                + "Dob, "
//                + "Introduction, "
//                + "Email, "
//                + "PhoneNumber, "
//                + "[Address], "
//                + "City, "
//                + "Gender, "
//                + "UserID) "
//                + " VALUES (?,?,?,?,?,?,?,?,?,?,?) ";
//        int result = 0;
//        try {
//            Connection con = DBUtil.getConnection();
//            PreparedStatement ps = con.prepareStatement(sql);
//            ps.setNString(1, firstName);
//            ps.setNString(2, lastName);
//            ps.setNString(3, avatar);
//            ps.setDate(4, dob);
//            ps.setNString(5, introduction);
//            ps.setString(6, email);
//            ps.setString(7, phoneNumber);
//            ps.setNString(8, address);
//            ps.setNString(9, city);
//            int genderID = 1;
//            switch (gender.toLowerCase()) {
//                case "female":
//                    genderID = 2;
//                    break;
//                case "other":
//                    genderID = 3;
//                    break;
//                default:
//                    genderID = 1;
//                    break;
//            }
//            ps.setInt(10, genderID);
//            ps.setInt(11, userID);
//            result = ps.executeUpdate();
//
//            int CVID = getHighestCVID();
//            System.out.println(getHighestCVID());
//            saveSkill(skills, CVID);
//            saveInterest(interests, CVID);
//            saveCertificate(certificates, CVID);
//            saveAchievement(achivements, CVID);
//
//            return result;
//        } catch (SQLException e) {
//            System.out.print("CV save error: " + e.getMessage());
//        }
//        return result;
//    }
//
