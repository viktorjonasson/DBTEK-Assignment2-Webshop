import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.*;


public class Repository implements RepositoryInterface {

    private Properties prop = new Properties();

    public Repository() {
        try {
            prop.load(new FileInputStream("src/WebshopDBSettings.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Customer retrieveCustomer(String userName, String password) throws NullPointerException, SQLException {

        Customer currentCustomer = null;
        try (Connection DBcon = DriverManager.getConnection(
                prop.getProperty("connectionString"),
                prop.getProperty("name"),
                prop.getProperty("password"));

             CallableStatement stmt = DBcon.prepareCall("call ValidateCustomer(?, ?)")
        ) {

            stmt.setString(1, userName);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                currentCustomer = new Customer(rs.getInt("Id"), rs.getString("FirstName"));
            }
        }
        return currentCustomer;
    }

    public Map<Integer, Shoe> listProducts() {

        List<Shoe> tempList = new ArrayList<>();
        Map<Integer, Shoe> allProducts = new TreeMap<>();

        try (Connection DBcon = DriverManager.getConnection(
                prop.getProperty("connectionString"),
                prop.getProperty("name"),
                prop.getProperty("password"));

             Statement stmt = DBcon.createStatement();
             ResultSet rs = stmt.executeQuery("select * from Shoe where Shoe.Stock > 0")
        ){
            while (rs.next()) {
                Shoe thisShoe = new Shoe(
                        rs.getInt("Id"),
                        rs.getString("Brand"),
                        rs.getString("Name"),
                        rs.getInt("Size"),
                        rs.getString("Color"),
                        rs.getDouble("Price"));
                tempList.add(thisShoe);
            }

            for (int i = 0; i < tempList.size(); i++) {
                allProducts.put(i+1, tempList.get(i));
            }

        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
        }
        return allProducts;
    }

    public void addToCart(int customerId, int shoeId) throws SQLException {

        try (Connection DBcon = DriverManager.getConnection(
                prop.getProperty("connectionString"),
                prop.getProperty("name"),
                prop.getProperty("password"));

             CallableStatement stmt = DBcon.prepareCall("call AddToCart(?, ?)")
        ) {

            stmt.setInt(1, customerId);
            stmt.setInt(2, shoeId);
            stmt.executeQuery();
        }
    }

    public CustomerOrder retrieveOrder(int customerId) {
        List<OrderDetail> orderEntries = new ArrayList<>();
        CustomerOrder thisCustomerOrder = null;

        try (Connection DBcon = DriverManager.getConnection(
                prop.getProperty("connectionString"),
                prop.getProperty("name"),
                prop.getProperty("password"));

            CallableStatement stmt = DBcon.prepareCall("call GetOrder(?,?)")) {
            stmt.setInt(1, customerId);
            stmt.registerOutParameter(2, Types.DOUBLE);
            ResultSet rs = stmt.executeQuery();
            double orderSum = stmt.getDouble(2);
            int orderId;

            if (!rs.next()) {
                throw new NullPointerException();
            }
            do {
                Shoe thisShoe = new Shoe(
                        rs.getInt("Id"),
                        rs.getString("Brand"),
                        rs.getString("Name"),
                        rs.getInt("Size"),
                        rs.getString("Color"),
                        rs.getDouble("Price"));
                OrderDetail thisOrderDetail = new OrderDetail(
                        thisShoe,
                        rs.getInt("Quantity"),
                        rs.getDouble("SubTotal"));
                orderEntries.add(thisOrderDetail);
                orderId = rs.getInt("CustomerOrderId");
            } while (rs.next());

            thisCustomerOrder = new CustomerOrder(orderId, orderSum, orderEntries);

        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
        }
        return thisCustomerOrder;
    }

    public void placeOrder(int orderId, String city) throws SQLException {

        try (Connection DBcon = DriverManager.getConnection(
                prop.getProperty("connectionString"),
                prop.getProperty("name"),
                prop.getProperty("password"));

             CallableStatement stmt = DBcon.prepareCall("call PlaceOrder(?, ?)")
        ) {
            stmt.setInt(1, orderId);
            stmt.setString(2, city);
            stmt.executeUpdate();
        }
    }
}