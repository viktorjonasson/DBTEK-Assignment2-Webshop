public class Customer {
    int customerID;
    String firstName;
    boolean signedIn;

    public Customer(int customerID, String firstName) {
        this.customerID = customerID;
        this.firstName = firstName;
        this.signedIn = true;
    }

    public int getCustomerID() {
        return customerID;
    }

    public String getFirstName() {
        return firstName;
    }

    public boolean isSignedIn() {
        return signedIn;
    }
}
