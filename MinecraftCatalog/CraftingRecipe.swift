import Foundation

struct CraftingIngredient: Identifiable {
    let id: String
    let name: String
    let count: Int
    var imageName: String { "item_" + id }
}

struct CraftingRecipe: Identifiable {
    let id: String
    let count: Int
    let slots: [String?]
    let note: String

    var item: MinecraftItem? {
        Catalog.items.first { $0.imageName == "item_" + id }
    }

    var name: String { item?.name ?? id }

    var ingredients: [CraftingIngredient] {
        let counts = slots.compactMap { $0 }.reduce(into: [String: Int]()) { $0[$1, default: 0] += 1 }
        return counts.keys.sorted().map {
            CraftingIngredient(id: $0, name: Self.ingredientName($0), count: counts[$0, default: 0])
        }
    }

    static func ingredientName(_ id: String) -> String {
        switch id {
        case "cobblestone": return "鵝卵石"
        case "flint": return "燧石"
        case "feather": return "羽毛"
        case "wheat": return "小麥"
        default: return Catalog.items.first { $0.imageName == "item_" + id }?.name ?? id
        }
    }

    static func recipe(for item: MinecraftItem) -> CraftingRecipe? {
        all.first { "item_" + $0.id == item.imageName }
    }

    // Verified against vanilla Java Edition 1.21.4 recipe data.
    // Ingredient tags use one valid representative; slots preserve the original pattern.
    static let all: [CraftingRecipe] = [
        CraftingRecipe(id: "oak_planks", count: 4, slots: ["oak_log", nil, nil, nil, nil, nil, nil, nil, nil], note: "材料可放在任意格子。"),
        CraftingRecipe(id: "crafting_table", count: 1, slots: ["oak_planks", "oak_planks", nil, "oak_planks", "oak_planks", nil, nil, nil, nil], note: "依照格子擺放材料；空白格保持空白。 圖中使用一種可用材料示範。"),
        CraftingRecipe(id: "wooden_pickaxe", count: 1, slots: ["oak_planks", "oak_planks", "oak_planks", nil, "stick", nil, nil, "stick", nil], note: "依照格子擺放材料；空白格保持空白。 圖中使用一種可用材料示範。"),
        CraftingRecipe(id: "stone_pickaxe", count: 1, slots: ["cobblestone", "cobblestone", "cobblestone", nil, "stick", nil, nil, "stick", nil], note: "依照格子擺放材料；空白格保持空白。 圖中使用一種可用材料示範。"),
        CraftingRecipe(id: "iron_pickaxe", count: 1, slots: ["iron_ingot", "iron_ingot", "iron_ingot", nil, "stick", nil, nil, "stick", nil], note: "依照格子擺放材料；空白格保持空白。 圖中使用一種可用材料示範。"),
        CraftingRecipe(id: "diamond_pickaxe", count: 1, slots: ["diamond", "diamond", "diamond", nil, "stick", nil, nil, "stick", nil], note: "依照格子擺放材料；空白格保持空白。 圖中使用一種可用材料示範。"),
        CraftingRecipe(id: "iron_axe", count: 1, slots: ["iron_ingot", "iron_ingot", nil, "iron_ingot", "stick", nil, nil, "stick", nil], note: "依照格子擺放材料；空白格保持空白。 圖中使用一種可用材料示範。"),
        CraftingRecipe(id: "iron_shovel", count: 1, slots: ["iron_ingot", nil, nil, "stick", nil, nil, "stick", nil, nil], note: "依照格子擺放材料；空白格保持空白。 圖中使用一種可用材料示範。"),
        CraftingRecipe(id: "shears", count: 1, slots: [nil, "iron_ingot", nil, "iron_ingot", nil, nil, nil, nil, nil], note: "依照格子擺放材料；空白格保持空白。"),
        CraftingRecipe(id: "fishing_rod", count: 1, slots: [nil, nil, "stick", nil, "stick", "string", "stick", nil, "string"], note: "依照格子擺放材料；空白格保持空白。"),
        CraftingRecipe(id: "iron_sword", count: 1, slots: ["iron_ingot", nil, nil, "iron_ingot", nil, nil, "stick", nil, nil], note: "依照格子擺放材料；空白格保持空白。 圖中使用一種可用材料示範。"),
        CraftingRecipe(id: "bow", count: 1, slots: [nil, "stick", "string", "stick", nil, "string", nil, "stick", "string"], note: "依照格子擺放材料；空白格保持空白。"),
        CraftingRecipe(id: "arrow", count: 4, slots: ["flint", nil, nil, "stick", nil, nil, "feather", nil, nil], note: "依照格子擺放材料；空白格保持空白。"),
        CraftingRecipe(id: "shield", count: 1, slots: ["oak_planks", "iron_ingot", "oak_planks", "oak_planks", "oak_planks", "oak_planks", nil, "oak_planks", nil], note: "依照格子擺放材料；空白格保持空白。 圖中使用一種可用材料示範。"),
        CraftingRecipe(id: "iron_chestplate", count: 1, slots: ["iron_ingot", nil, "iron_ingot", "iron_ingot", "iron_ingot", "iron_ingot", "iron_ingot", "iron_ingot", "iron_ingot"], note: "依照格子擺放材料；空白格保持空白。"),
        CraftingRecipe(id: "bread", count: 1, slots: ["wheat", "wheat", "wheat", nil, nil, nil, nil, nil, nil], note: "依照格子擺放材料；空白格保持空白。"),
        CraftingRecipe(id: "golden_apple", count: 1, slots: ["gold_ingot", "gold_ingot", "gold_ingot", "gold_ingot", "apple", "gold_ingot", "gold_ingot", "gold_ingot", "gold_ingot"], note: "依照格子擺放材料；空白格保持空白。"),
        CraftingRecipe(id: "stick", count: 4, slots: ["oak_planks", nil, nil, "oak_planks", nil, nil, nil, nil, nil], note: "依照格子擺放材料；空白格保持空白。 圖中使用一種可用材料示範。"),
        CraftingRecipe(id: "lever", count: 1, slots: ["stick", nil, nil, "cobblestone", nil, nil, nil, nil, nil], note: "依照格子擺放材料；空白格保持空白。"),
        CraftingRecipe(id: "piston", count: 1, slots: ["oak_planks", "oak_planks", "oak_planks", "cobblestone", "iron_ingot", "cobblestone", "cobblestone", "redstone", "cobblestone"], note: "依照格子擺放材料；空白格保持空白。 圖中使用一種可用材料示範。"),
        CraftingRecipe(id: "rail", count: 16, slots: ["iron_ingot", nil, "iron_ingot", "iron_ingot", "stick", "iron_ingot", "iron_ingot", nil, "iron_ingot"], note: "依照格子擺放材料；空白格保持空白。"),
        CraftingRecipe(id: "minecart", count: 1, slots: ["iron_ingot", nil, "iron_ingot", "iron_ingot", "iron_ingot", "iron_ingot", nil, nil, nil], note: "依照格子擺放材料；空白格保持空白。"),
        CraftingRecipe(id: "oak_boat", count: 1, slots: ["oak_planks", nil, "oak_planks", "oak_planks", "oak_planks", "oak_planks", nil, nil, nil], note: "依照格子擺放材料；空白格保持空白。"),
    ]
}
