
package model;


public class User {
    private long user_id;
    private String name;
    private String contact_number;
    private String email;
    
    public User(){}
    
    public User(long user_id,String name,String contact_number,String email){
        this.user_id = user_id;
        this.contact_number = contact_number;
        this.name = name;
        this.email = email;
    }
    
    
    public long getUser_id() {
        return user_id;
    }

    public void setUser_id(long user_id) {
        this.user_id = user_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContact_number() {
        return contact_number;
    }

    public void setContact_number(String contact_number) {
        this.contact_number = contact_number;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
}
