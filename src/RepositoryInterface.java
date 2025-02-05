import java.util.List;
import java.util.Map;

public interface RepositoryInterface {

    Customer retrieveCustomer(String username, String password);
    Map<Integer, Shoe> listProducts();
    void addToCart(int customerId, int shoeId);
    CustomerOrder retrieveOrder(int customerId);
    void placeOrder(int orderId, String city);
}
