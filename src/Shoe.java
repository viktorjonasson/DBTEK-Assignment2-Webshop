public class Shoe {
    private int Id;
    private String Brand;
    private String Name;
    private int Size;
    private String Color;
    private double Price;

    public Shoe() {
    }

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public String getBrand() {
        return Brand;
    }

    public void setBrand(String brand) {
        this.Brand = brand;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        this.Name = name;
    }

    public int getSize() {
        return Size;
    }

    public void setSize(int size) {
        this.Size = size;
    }

    public String getColor() {
        return Color;
    }

    public void setColor(String color) {
        this.Color = color;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double price) {
        this.Price = price;
    }

    @Override
    public String toString() {
        return Brand + ", " + Name +
                ", Size: " + Size +
                ", Color: " + Color +
                ", Price: " + Price + "kr";
    }
}
