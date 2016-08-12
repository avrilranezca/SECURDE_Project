package model;

/**
 * Created by rissa on 8/10/2016.
 */
public class CartEntry {
    private Product prod;
    private int item;

    public CartEntry(Product prod, int item){
        this.prod=prod;
        this.item=item;
    }

    public Product getProd() {
        return prod;
    }

    public int getItem() {
        return item;
    }
}
