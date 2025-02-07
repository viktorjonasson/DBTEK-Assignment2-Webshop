public class OrderDetail {
    private int lineQuantity;
    private double subTotal;
    Shoe shoe;

    public OrderDetail(Shoe shoe, int lineQuantity, double subTotal) {
        this.shoe = shoe;
        this.lineQuantity = lineQuantity;
        this.subTotal = subTotal;
    }

    public int getLineQuantity() {
        return lineQuantity;
    }

    public double getSubTotal() {
        return subTotal;
    }

    public Shoe getShoe() {
        return shoe;
    }

    @Override
    public String toString() {
        return  shoe.toString() + "\n" +
                "Quantity: " + lineQuantity + ", Subtotal: " + subTotal + "kr";
    }
}
