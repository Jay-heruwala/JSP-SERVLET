package model;




public class User {
    private int userId;
    private String name;
    private String address;
    private String emailId;
    private String mobileNo;
    private int roleId;
    private String password;
    private String roleName;

    public User() {}

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getEmailId() { return emailId; }
    public void setEmailId(String emailId) { this.emailId = emailId; }
    public String getMobileNo() { return mobileNo; }
    public void setMobileNo(String mobileNo) { this.mobileNo = mobileNo; }
    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }
}