//
//  Item.swift
//  Brocade
//
//  Created by Ryan Cohen on 3/31/20.
//

import Foundation

public struct Item: Codable {
    
    // MARK: - Attributes -
    
    /// Item's GTIN-14 code
    public let gtin14: String
    
    /// Item's name
    public let name: String?
    
    /// Item's brand name
    public let brandName: String?
    
    /// Item's size
    public let size: String?
    
    /// Item's serving size
    public let servingSize: String?
    
    /// Item's servings per container
    public let servingsPerContainer: String?
    
    /// Item's ingredients
    public let ingredients: String?
    
    /// Item's amount of fiber
    public let fiber: String?
    
    /// Item's amount of sodium
    public let sodium: String?
    
    /// Item's amount of sugar
    public let sugars: String?
    
    /// Item's amount of protein
    public let protein: String?
    
    /// Item's number of calories
    public let calories: String?
    
    /// Item's amount of cholesterol
    public let cholesterol: String?
    
    /// Item's amount of carbohydrates
    public let carbohydrates: String?
    
    /// Item's amount of fat in grams
    public let fat: String?
    
    /// Item's amount of fat calories
    public let fatCalories: String?
    
    /// Item's amount of saturated fat
    public let saturatedFat: String?
    
    /// Item's amount of trans fats
    public let transFat: String?
    
    /// Item summary
    public var itemSummary: String {
        return """
        GTIN-14: \(gtin14)
        Name: \(name ?? "N/A")
        Brand: \(brandName ?? "N/A")
        Size: \(size ?? "N/A")
        Serving size: \(servingSize ?? "N/A")
        Servings per container: \(servingsPerContainer ?? "N/A")
        Ingredients: \(ingredients ?? "N/A")
        Fiber: \(fiber ?? "N/A")
        Sodium: \(sodium ?? "N/A")
        Sugars: \(sugars ?? "N/A")
        Protein: \(protein ?? "N/A")
        Calories: \(calories ?? "N/A")
        Cholesterol: \(cholesterol ?? "N/A")
        Carbohydrates: \(carbohydrates ?? "N/A")
        Fat: \(fat ?? "N/A")
        Fat calories: \(fatCalories ?? "N/A")
        Saturated fat: \(saturatedFat ?? "N/A")
        Trans fat: \(transFat ?? "N/A")
        """
    }
    
    // MARK: - CodingKeys -
    
    private enum CodingKeys: String, CodingKey {
        case gtin14, name, fat, size, fiber, sodium, sugars, protein, calories, ingredients, cholesterol
        case carbohydrates = "carbohydrate"
        case brandName = "brand_name"
        case transFat = "trans_fat"
        case fatCalories = "fat_calories"
        case servingSize = "serving_size"
        case saturatedFat = "saturated_fat"
        case servingsPerContainer = "servings_per_container"
    }
}
