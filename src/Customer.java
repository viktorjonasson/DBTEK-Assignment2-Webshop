public class Customer {
    int customerID;
    String firstName;
    boolean signedIn = false;

    public Customer(int customerID, String firstName) {
        this.customerID = customerID;
        this.firstName = firstName;
        this.signedIn = true;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public boolean isSignedIn() {
        return signedIn;
    }

    public void setSignedIn(boolean signedIn) {
        this.signedIn = signedIn;
    }
}
