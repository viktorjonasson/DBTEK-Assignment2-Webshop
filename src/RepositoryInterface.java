import java.sql.SQLException;
import java.util.Map;

public interface RepositoryInterface {

    Customer retrieveCustomer(String username, String password) throws NullPointerException, SQLException;
    Map<Integer, Shoe> listProducts();
    void addToCart(int customerId, int shoeId) throws SQLException;
    CustomerOrder retrieveOrder(int customerId);
    void placeOrder(int orderId, String city) throws SQLException;
}
