import java.sql.SQLException;
import java.util.*;
import java.util.stream.Stream;

public class WebshopApp {

    RepositoryInterface repo = new Repository();
    Scanner scanner = new Scanner(System.in);
    Customer currentCustomer;

    WebshopApp() {
        currentCustomer = login();

        while (true) {
            displayMenu();
            String menuChoice = scanner.nextLine();

            switch (menuChoice) {
                case "1" -> productSelection();
                case "2" -> checkout();
                case "3" -> System.exit(0);
            }
        }
    }

    public Customer login() {
        System.out.println("Welcome to The Shoe Store!");
        System.out.println("Please log in to continue\n");
        while (true) {
            try {
                System.out.println("Username:");
                String username = scanner.nextLine().trim();
                System.out.println("Password:");
                String password = scanner.nextLine().trim();

                currentCustomer = repo.retrieveCustomer(username, password);

                System.out.println("\nHello " + currentCustomer.firstName + ", welcome back!\n");

                break;
            } catch (NullPointerException | SQLException e) {
                System.out.println("Invalid username or password, please try again.\n");
            }
        }
        return currentCustomer;
    }

    private void displayMenu() {
        System.out.println("Main menu. Make your choice by entering its number:");
        System.out.println("1: View all products");
        System.out.println("2: Go to shopping cart");
        System.out.println("3: Exit the shop");
    }

    public void productSelection() {
            System.out.println("Choose a product by entering its number:");
        while (true) {
            System.out.println("------------------------------------------------------------------------------");
            Map<Integer, Shoe> allProducts = repo.listProducts();
            Stream<Integer> stream = allProducts.keySet().stream();
            stream.forEach((key) -> {
                System.out.println(key + ": " + allProducts.get(key));
            });
            System.out.println("------------------------------------------------------------------------------");

            try {
                Shoe chosenProduct = allProducts.get(Integer.parseInt(scanner.nextLine().trim()));
                repo.addToCart(currentCustomer.getCustomerID(), chosenProduct.getId());
                System.out.println("Added to cart:\n" + chosenProduct + "\n");
                break;
            } catch (NumberFormatException e) {
                System.out.println("That's not a number. Please try again:");
            } catch (NullPointerException e) {
                System.out.println("That number is not in the list. Please enter a valid number:");
            } catch (SQLException e) {
                if (e.getSQLState().equals("45001")) {
                    System.out.println("Error code " + e.getErrorCode() + ": " + e.getMessage());
                    System.exit(0);
                }
                System.out.println("Error code " + e.getErrorCode() + ": " + e.getMessage());
            }
        }
    }

    public void checkout() {
        while (true) {
            CustomerOrder currentOrder;
            try {
                currentOrder = repo.retrieveOrder(currentCustomer.customerID);
            }
            catch (NullPointerException e) {
                System.out.println("You have no products in your shopping cart.\n");
                return;
            }

            System.out.println(currentOrder.toString());
            System.out.println("Do you want place the order (y/n)?");

            if (scanner.nextLine().trim().equalsIgnoreCase("y")) {
                System.out.println("Where do you want the order delivered? Write city name and press enter.");
                String city = scanner.nextLine().trim();

                try {
                    repo.placeOrder(currentOrder.getOrderId(), city);
                    System.out.println("Order placed. Thank you for shopping!\n");
                    System.out.println("Press enter to exit the shop.");
                    scanner.nextLine();
                    System.exit(0);
                }
                catch (SQLException e) {
                    if (e.getSQLState().equals("45002")) {
                        System.out.println("Error code " + e.getErrorCode() + ": " + e.getMessage() + "\n");
                        break;
                    }
                    System.out.println("Error code " + e.getErrorCode() + ": " + e.getMessage());
                }
            }
            else {
                break;
            }
        }
    }

    public static void main(String[] args) {
        WebshopApp ws = new WebshopApp();
    }
}
