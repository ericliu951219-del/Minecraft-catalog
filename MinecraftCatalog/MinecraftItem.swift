import Foundation
struct MinecraftItem: Identifiable, Hashable {
 let id: String
 let name: String
 let englishName: String
 let category: String
 let symbol: String
 let summary: String
 let obtaining: String

    var imageName: String {
        switch id {
        case "Steak": return "item_cooked_beef"
        case "Redstone Dust": return "item_redstone"
        default: return "item_" + id.lowercased().replacingOccurrences(of: " ", with: "_")
        }
    }
}
enum Catalog {
 static let categories = ["方塊", "工具", "武器與護甲", "食物", "材料", "紅石與運輸"]
 static let items: [MinecraftItem] = [
MinecraftItem(id: "Dirt", name: "泥土", englishName: "Dirt", category: "方塊", symbol: "cube.fill", summary: "常見地表方塊，可用來填補地形或搭建臨時道路。", obtaining: "在地表挖掘取得；使用鏟子較方便。"),
MinecraftItem(id: "Stone", name: "石頭", englishName: "Stone", category: "方塊", symbol: "cube.fill", summary: "常見的地下方塊，適合建築與加工。", obtaining: "以一般鎬挖掘通常取得鵝卵石；可熔煉鵝卵石取得石頭。"),
MinecraftItem(id: "Oak Log", name: "橡木原木", englishName: "Oak Log", category: "方塊", symbol: "cube.fill", summary: "木質建築與合成材料的起點。", obtaining: "砍伐橡木取得，可加工成木材。"),
MinecraftItem(id: "Oak Planks", name: "橡木木材", englishName: "Oak Planks", category: "方塊", symbol: "cube.fill", summary: "可用於建築，也能製作工作台與木棒。", obtaining: "由橡木原木合成。"),
MinecraftItem(id: "Glass", name: "玻璃", englishName: "Glass", category: "方塊", symbol: "cube.fill", summary: "透明建材，適合窗戶與採光。", obtaining: "將沙子放入熔爐熔煉。"),
MinecraftItem(id: "Crafting Table", name: "工作台", englishName: "Crafting Table", category: "方塊", symbol: "cube.fill", summary: "提供較大的合成介面。", obtaining: "使用四個木材合成。"),
MinecraftItem(id: "Wooden Pickaxe", name: "木鎬", englishName: "Wooden Pickaxe", category: "工具", symbol: "hammer.fill", summary: "生存初期的採礦工具。", obtaining: "使用木材與木棒合成，先收集石材升級工具。"),
MinecraftItem(id: "Stone Pickaxe", name: "石鎬", englishName: "Stone Pickaxe", category: "工具", symbol: "hammer.fill", summary: "入門採礦工具，可開採鐵礦石。", obtaining: "使用鵝卵石與木棒合成。"),
MinecraftItem(id: "Iron Pickaxe", name: "鐵鎬", englishName: "Iron Pickaxe", category: "工具", symbol: "hammer.fill", summary: "用途廣泛的採礦工具，可開採鑽石礦石。", obtaining: "使用鐵錠與木棒合成。"),
MinecraftItem(id: "Diamond Pickaxe", name: "鑽石鎬", englishName: "Diamond Pickaxe", category: "工具", symbol: "hammer.fill", summary: "耐用的高階採礦工具，可開採黑曜石。", obtaining: "使用鑽石與木棒合成。"),
MinecraftItem(id: "Iron Axe", name: "鐵斧", englishName: "Iron Axe", category: "工具", symbol: "hammer.fill", summary: "用來快速砍伐木質方塊。", obtaining: "使用鐵錠與木棒合成。"),
MinecraftItem(id: "Iron Shovel", name: "鐵鏟", englishName: "Iron Shovel", category: "工具", symbol: "hammer.fill", summary: "適合挖掘泥土、沙子與礫石。", obtaining: "使用鐵錠與木棒合成。"),
MinecraftItem(id: "Shears", name: "剪刀", englishName: "Shears", category: "工具", symbol: "hammer.fill", summary: "可剪取綿羊羊毛，也能採集部分植物方塊。", obtaining: "使用兩個鐵錠合成。"),
MinecraftItem(id: "Fishing Rod", name: "釣竿", englishName: "Fishing Rod", category: "工具", symbol: "hammer.fill", summary: "用於水中釣魚。", obtaining: "使用木棒與線合成。"),
MinecraftItem(id: "Iron Sword", name: "鐵劍", englishName: "Iron Sword", category: "武器與護甲", symbol: "shield.fill", summary: "近戰武器，適合對抗敵對生物。", obtaining: "使用鐵錠與木棒合成。"),
MinecraftItem(id: "Bow", name: "弓", englishName: "Bow", category: "武器與護甲", symbol: "shield.fill", summary: "消耗箭矢進行遠距離攻擊。", obtaining: "使用木棒與線合成。"),
MinecraftItem(id: "Arrow", name: "箭矢", englishName: "Arrow", category: "武器與護甲", symbol: "shield.fill", summary: "弓使用的彈藥。", obtaining: "可由燧石、木棒與羽毛合成。"),
MinecraftItem(id: "Shield", name: "盾牌", englishName: "Shield", category: "武器與護甲", symbol: "shield.fill", summary: "可用來阻擋部分攻擊。", obtaining: "使用木材與鐵錠合成；操作依遊戲版本而異。"),
MinecraftItem(id: "Iron Chestplate", name: "鐵胸甲", englishName: "Iron Chestplate", category: "武器與護甲", symbol: "shield.fill", summary: "穿戴後提供護甲保護。", obtaining: "使用鐵錠合成，放入胸甲裝備欄。"),
MinecraftItem(id: "Apple", name: "蘋果", englishName: "Apple", category: "食物", symbol: "carrot.fill", summary: "可食用的基礎食物。", obtaining: "橡木等樹種的樹葉可能掉落。"),
MinecraftItem(id: "Bread", name: "麵包", englishName: "Bread", category: "食物", symbol: "carrot.fill", summary: "適合農耕後大量準備的食物。", obtaining: "使用三個小麥合成。"),
MinecraftItem(id: "Baked Potato", name: "烤馬鈴薯", englishName: "Baked Potato", category: "食物", symbol: "carrot.fill", summary: "烹調後的農作物食物。", obtaining: "將馬鈴薯放入熔爐烹調。"),
MinecraftItem(id: "Steak", name: "熟牛肉", englishName: "Steak", category: "食物", symbol: "carrot.fill", summary: "可補充飢餓值的熟食。", obtaining: "烹調生牛肉取得。"),
MinecraftItem(id: "Golden Apple", name: "金蘋果", englishName: "Golden Apple", category: "食物", symbol: "carrot.fill", summary: "具有特殊效果的食物。", obtaining: "使用蘋果與金錠合成；效果細節依版本確認。"),
MinecraftItem(id: "Coal", name: "煤炭", englishName: "Coal", category: "材料", symbol: "diamond.fill", summary: "常見燃料，也可用來製作火把。", obtaining: "開採煤礦石取得。"),
MinecraftItem(id: "Iron Ingot", name: "鐵錠", englishName: "Iron Ingot", category: "材料", symbol: "diamond.fill", summary: "製作鐵製工具、護甲與設備的材料。", obtaining: "熔煉粗鐵取得。"),
MinecraftItem(id: "Gold Ingot", name: "金錠", englishName: "Gold Ingot", category: "材料", symbol: "diamond.fill", summary: "可用於合成與交易等用途。", obtaining: "熔煉粗金取得。"),
MinecraftItem(id: "Diamond", name: "鑽石", englishName: "Diamond", category: "材料", symbol: "diamond.fill", summary: "高階裝備與附魔台的材料。", obtaining: "用鐵鎬或更高階的適當鎬開採鑽石礦石。"),
MinecraftItem(id: "Stick", name: "木棒", englishName: "Stick", category: "材料", symbol: "diamond.fill", summary: "工具與許多配方的基礎材料。", obtaining: "使用木材合成。"),
MinecraftItem(id: "String", name: "線", englishName: "String", category: "材料", symbol: "diamond.fill", summary: "可用來製作弓與釣竿。", obtaining: "擊敗蜘蛛等方式取得。"),
MinecraftItem(id: "Redstone Dust", name: "紅石粉", englishName: "Redstone Dust", category: "紅石與運輸", symbol: "bolt.fill", summary: "可傳遞紅石訊號，建立機關。", obtaining: "使用適當鎬開採紅石礦石取得。"),
MinecraftItem(id: "Lever", name: "拉桿", englishName: "Lever", category: "紅石與運輸", symbol: "bolt.fill", summary: "手動控制紅石訊號的開關。", obtaining: "使用木棒與鵝卵石合成。"),
MinecraftItem(id: "Piston", name: "活塞", englishName: "Piston", category: "紅石與運輸", symbol: "bolt.fill", summary: "接收訊號時推動可移動的方塊。", obtaining: "使用木材、鵝卵石、鐵錠與紅石粉合成。"),
MinecraftItem(id: "Rail", name: "鐵軌", englishName: "Rail", category: "紅石與運輸", symbol: "bolt.fill", summary: "讓礦車行駛的軌道。", obtaining: "使用鐵錠與木棒合成。"),
MinecraftItem(id: "Minecart", name: "礦車", englishName: "Minecart", category: "紅石與運輸", symbol: "bolt.fill", summary: "可放在鐵軌上使用的交通工具。", obtaining: "使用鐵錠合成。"),
MinecraftItem(id: "Oak Boat", name: "橡木船", englishName: "Oak Boat", category: "紅石與運輸", symbol: "bolt.fill", summary: "可在水上移動的交通工具。", obtaining: "以橡木木材製作；配方請依版本確認。")
 ]
}
