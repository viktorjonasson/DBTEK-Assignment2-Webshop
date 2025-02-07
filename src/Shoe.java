public class Shoe {
    private int Id;
    private String Brand;
    private String Name;
    private int Size;
    private String Color;
    private double Price;

    public Shoe(int id, String brand, String name, int size, String color, double price) {
        this.Id = id;
        this.Brand = brand;
        this.Name = name;
        this.Size = size;
        this.Color = color;
        this.Price = price;
    }

    public Shoe() {
    }

    public int getId() {
        return Id;
    }

    public String getBrand() {
        return Brand;
    }

    public String getName() {
        return Name;
    }

    public int getSize() {
        return Size;
    }

    public String getColor() {
        return Color;
    }

    public double getPrice() {
        return Price;
    }

    @Override
    public String toString() {
        return Brand + ", " + Name +
                ", Size: " + Size +
                ", Color: " + Color +
                ", Price: " + Price + "kr";
    }
}
