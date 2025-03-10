package models;

public class Customer {
    private int customerID;
    private String name;
    private String email;
    private String password;
    private String phone;

    // Constructor
    public Customer(int customerID, String name, String email, String password, String phone) {
        this.customerID = customerID;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
    }

    // Getters and Setters
    public int getCustomerID() { return customerID; }
    public void setCustomerID(int customerID) { this.customerID = customerID; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}
