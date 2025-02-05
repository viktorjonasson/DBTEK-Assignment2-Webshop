public class OrderDetail {
    private int lineQuantity;
    private double subTotal;
    Shoe shoe = new Shoe();

    public OrderDetail(Shoe shoe, int lineQuantity, double subTotal) {
        this.shoe = shoe;
        this.lineQuantity = lineQuantity;
        this.subTotal = subTotal;
    }

    public int getLineQuantity() {
        return lineQuantity;
    }

    public void setLineQuantity(int lineQuantity) {
        this.lineQuantity = lineQuantity;
    }

    public double getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }

    public Shoe getShoe() {
        return shoe;
    }

    public void setShoe(Shoe shoe) {
        this.shoe = shoe;
    }

    @Override
    public String toString() {
        return  shoe.toString() + "\n" +
                "Quantity: " + lineQuantity + ", Subtotal: " + subTotal + "kr";
    }
}
