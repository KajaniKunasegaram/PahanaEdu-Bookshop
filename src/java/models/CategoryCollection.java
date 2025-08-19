/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.List;

/**
 *
 * @author HP
 */
public class CategoryCollection {
    private List<CategoryModel> categories;

    public CategoryCollection(List<CategoryModel> categories) {
        this.categories = categories;
    }

    public CategoryIterator iterator() {
        return new CategoryIterator(categories);
    }
}
