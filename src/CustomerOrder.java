import java.util.List;

public class CustomerOrder {
    private int orderId;
    private String city;
    private double orderSum;
    List<OrderDetail> orderEntries;

    public CustomerOrder(int orderId, double orderSumTotal, List<OrderDetail> orderEntries) {
        this.orderId = orderId;
        this.orderSum = orderSumTotal;
        this.orderEntries = orderEntries;
    }

    public int getOrderId() {
        return orderId;
    }

    public String getCity() {
        return city;
    }

    public double getOrderSum() {
        return orderSum;
    }

    public List<OrderDetail> getOrderEntries() {
        return orderEntries;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Your shopping cart:\n");
        for (OrderDetail entry : this.orderEntries) {
            sb.append(entry.toString()).append("\n");
        }
        sb.append("------------------------------------------------------------------------------\n");
        sb.append("Order sum: ").append(this.orderSum).append("kr\n");
        return sb.toString();
    }
}