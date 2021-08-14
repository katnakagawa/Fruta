//
//  Ingredient+NutritionFacts.swift
//  Ingredient+NutritionFacts
//
//  Created by Katsuya Nakagawa on 2021/08/12.
//

extension Ingredient {
    var nutritionFact: NutritionFact? {
        NutritionFact.lookupFoodItem(id, forVolume: .cups(1))
    }
}
