//
//  Smoothie.swift
//  Smoothie
//
//  Created by Katsuya Nakagawa on 2021/08/12.
//

import Foundation

struct Smoothie: Identifiable, Codable {
    var id: String
    var title: String
    var description: AttributedString
    var measuredIngredients: [MeasuredIngredient]
}

extension Smoothie {
    init?(for id: Smoothie.ID) {
        guard let smoothie = Smoothie.all().first(where: { $0.id == id }) else { return nil }
        self = smoothie
    }
    
    var kilocalories: Int {
        let value = measuredIngredients.reduce(0) { total, ingredient in total + ingredient.kilocalories }
        return Int(round(Double(value) / 10.0) * 10)
    }

    var energy: Measurement<UnitEnergy> {
        return Measurement<UnitEnergy>(value: Double(kilocalories), unit: .kilocalories)
    }

    // The nutritional information for the combined ingredients
    var nutritionFact: NutritionFact {
        let facts = measuredIngredients.compactMap { $0.nutritionFact }
        guard let firstFact = facts.first else {
            print("Could not find nutrition facts for \(title) — using `banana`'s nutrition facts.")
            return .banana
        }
        return facts.dropFirst().reduce(firstFact, +)
    }
    
    var menuIngredients: [MeasuredIngredient] {
        measuredIngredients.filter { $0.id != Ingredient.water.id }
    }
    
    func matches(_ string: String) -> Bool {
        string.isEmpty ||
        title.localizedCaseInsensitiveContains(string) ||
        menuIngredients.contains {
            $0.ingredient.name.localizedCaseInsensitiveContains(string)
        }
    }
}

extension Smoothie {
    @SmoothieArrayBuilder
    static func all(includingPaid: Bool = true) -> [Smoothie] {
        Smoothie(id: "berry-blue", title:  "Berry Blue") {
            AttributedString("*Filling* and *refreshing*, this smoothie will fill you with joy!")

            Ingredient.orange.measured(with: .cups).scaled(by: 1.5)
            Ingredient.blueberry.measured(with: .cups)
            Ingredient.avocado.measured(with: .cups).scaled(by: 0.2)
        }

        Smoothie(id: "carrot-chops", title: "Carrot Chops") {
            AttributedString("*Packed* with vitamin A and C, Carrot Chops is a great way to start your day!")

            Ingredient.orange.measured(with: .cups).scaled(by: 1.5)
            Ingredient.carrot.measured(with: .cups).scaled(by: 0.5)
            Ingredient.mango.measured(with: .cups).scaled(by: 0.5)
        }
        
        if includingPaid {
            Smoothie(id: "pina-y-coco", title: "Piña y Coco") {
                AttributedString("Enjoy the *tropical* flavors of coconut and pineapple!")
                
                Ingredient.pineapple.measured(with: .cups).scaled(by: 1.5)
                Ingredient.almondMilk.measured(with: .cups)
                Ingredient.coconut.measured(with: .cups).scaled(by: 0.5)
            }

            Smoothie(id: "hulking-lemonade", title: "Hulking Lemonade") {
                AttributedString("This is not just *any* lemonade. It will give you *powers* you'll struggle to control!")
                
                Ingredient.lemon.measured(with: .cups).scaled(by: 1.5)
                Ingredient.spinach.measured(with: .cups)
                Ingredient.avocado.measured(with: .cups).scaled(by: 0.2)
                Ingredient.water.measured(with: .cups).scaled(by: 0.2)
            }

            Smoothie(id: "kiwi-cutie", title: "Kiwi Cutie") {
                AttributedString("Kiwi Cutie is beautiful *inside* ***and*** *out*! Packed with nutrients to start your day!")
                
                Ingredient.kiwi.measured(with: .cups)
                Ingredient.orange.measured(with: .cups)
                Ingredient.spinach.measured(with: .cups)
            }

            Smoothie( id: "lemonberry", title: "Lemonberry") {
                AttributedString("A refreshing blend that's a *real kick*!")

                Ingredient.raspberry.measured(with: .cups)
                Ingredient.strawberry.measured(with: .cups)
                Ingredient.lemon.measured(with: .cups).scaled(by: 0.5)
                Ingredient.water.measured(with: .cups).scaled(by: 0.5)
            }

            Smoothie(id: "love-you-berry-much", title: "Love You Berry Much") {
                AttributedString("If you *love* berries berry berry much, you will love this one!")

                Ingredient.strawberry.measured(with: .cups).scaled(by: 0.75)
                Ingredient.blueberry.measured(with: .cups).scaled(by: 0.5)
                Ingredient.raspberry.measured(with: .cups).scaled(by: 0.5)
                Ingredient.water.measured(with: .cups).scaled(by: 0.5)
            }

            Smoothie(id: "mango-jambo", title: "Mango Jambo") {
                AttributedString("Dance around with this *delicious* tropical blend!")

                Ingredient.mango.measured(with: .cups)
                Ingredient.pineapple.measured(with: .cups).scaled(by: 0.5)
                Ingredient.water.measured(with: .cups).scaled(by: 0.5)
            }

            Smoothie(id: "one-in-a-melon", title: "One in a Melon") {
                AttributedString("Feel special this summer with the *coolest* drink in our menu!")

                Ingredient.watermelon.measured(with: .cups).scaled(by: 2)
                Ingredient.raspberry.measured(with: .cups)
                Ingredient.water.measured(with: .cups).scaled(by: 0.5)
            }

            Smoothie(id: "papas-papaya", title: "Papa's Papaya") {
                AttributedString("Papa would be proud of you if he saw you drinking this!")

                Ingredient.orange.measured(with: .cups)
                Ingredient.mango.measured(with: .cups).scaled(by: 0.5)
                Ingredient.papaya.measured(with: .cups).scaled(by: 0.5)
            }

            Smoothie(id: "peanut-butter-cup", title: "Peanut Butter Cup") {
                AttributedString("Ever wondered what it was like to *drink a peanut butter cup*? Wonder no more!")

                Ingredient.almondMilk.measured(with: .cups)
                Ingredient.banana.measured(with: .cups).scaled(by: 0.5)
                Ingredient.chocolate.measured(with: .tablespoons).scaled(by: 2)
                Ingredient.peanutButter.measured(with: .tablespoons)
            }

            Smoothie(id: "sailor-man", title: "Sailor Man") {
                AttributedString("*Get strong* with this delicious spinach smoothie!")

                Ingredient.orange.measured(with: .cups).scaled(by: 1.5)
                Ingredient.spinach.measured(with: .cups)
            }

            Smoothie(id: "thats-a-smore", title: "That's a Smore!") {
                AttributedString("When the world seems to rock like you've had too much choc, that's *a smore*!")

                Ingredient.almondMilk.measured(with: .cups)
                Ingredient.coconut.measured(with: .cups).scaled(by: 0.5)
                Ingredient.chocolate.measured(with: .tablespoons)
            }
        }

        Smoothie(id: "thats-berry-bananas", title: "That's Berry Bananas!") {
            AttributedString("You'll go *crazy* with this classic!")

            Ingredient.almondMilk.measured(with: .cups)
            Ingredient.banana.measured(with: .cups)
            Ingredient.strawberry.measured(with: .cups)
        }

        if includingPaid {
            Smoothie(id: "tropical-blue", title: "Tropical Blue") {
                AttributedString("A delicious blend of *tropical fruits and blueberries* will have you sambaing around like you never knew you could!")
                Ingredient.almondMilk.measured(with: .cups)
                Ingredient.banana.measured(with: .cups).scaled(by: 0.5)
                Ingredient.blueberry.measured(with: .cups).scaled(by: 0.5)
                Ingredient.mango.measured(with: .cups).scaled(by: 0.5)
            }
        }
    }

    // Used in previews.
    static var berryBlue: Smoothie { Smoothie(for: "berry-blue")! }
    static var kiwiCutie: Smoothie { Smoothie(for: "kiwi-cutie")! }
    static var hulkingLemonade: Smoothie { Smoothie(for: "hulking-lemonade")! }
    static var mangoJambo: Smoothie { Smoothie(for: "mango-jambo")! }
    static var tropicalBlue: Smoothie { Smoothie(for: "tropical-blue")! }
    static var lemonberry: Smoothie { Smoothie(for: "lemonberry")! }
    static var oneInAMelon: Smoothie { Smoothie(for: "one-in-a-melon")! }
    static var thatsASmore: Smoothie { Smoothie(for: "thats-a-smore")! }
    static var thatsBerryBananas: Smoothie { Smoothie(for: "thats-berry-bananas")! }
}

extension Smoothie {
    init(id: Smoothie.ID, title: String, @SmoothieBuilder _ makeIngredients: () -> (AttributedString, [MeasuredIngredient])) {
        let (description, ingredients) = makeIngredients()
        self.init(id: id, title: title, description: description, measuredIngredients: ingredients)
    }
}

@resultBuilder
enum SmoothieBuilder {
    static func buildBlock(_ description: AttributedString, _ ingredients: MeasuredIngredient...) -> (AttributedString, [MeasuredIngredient]) {
        return (description, ingredients)
    }

    @available(*, unavailable, message: "first statement of SmoothieBuilder must be its description String")
    static func buildBlock(_ ingredients: MeasuredIngredient...) -> (String, [MeasuredIngredient]) {
        fatalError()
    }
}

@resultBuilder
enum SmoothieArrayBuilder {
    static func buildEither(first component: [Smoothie]) -> [Smoothie] {
        return component
    }

    static func buildEither(second component: [Smoothie]) -> [Smoothie] {
        return component
    }

    static func buildOptional(_ component: [Smoothie]?) -> [Smoothie] {
        return component ?? []
    }

    static func buildExpression(_ expression: Smoothie) -> [Smoothie] {
        return [expression]
    }

    static func buildExpression(_ expression: ()) -> [Smoothie] {
        return []
    }

    static func buildBlock(_ smoothies: [Smoothie]...) -> [Smoothie] {
        return smoothies.flatMap { $0 }
    }
}

