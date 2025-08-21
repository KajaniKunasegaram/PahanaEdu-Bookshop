/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import Interface.ICategoryIterator;
import java.util.List;

public class CategoryIterator implements ICategoryIterator {
    private List<CategoryModel> categories;
    private int position = 0;

    public CategoryIterator(List<CategoryModel> categories) {
        this.categories = categories;
    }

    @Override
    public boolean hasNext() {
        return position < categories.size();
    }

    @Override
    public CategoryModel next() {
        return categories.get(position++);
    }
}
