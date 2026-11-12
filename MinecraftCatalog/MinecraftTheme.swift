import SwiftUI

enum MinecraftTheme {
    static let background = Color(red: 0.08, green: 0.10, blue: 0.08)
    static let panel = Color(red: 0.20, green: 0.22, blue: 0.19)
    static let green = Color(red: 0.65, green: 0.88, blue: 0.34)
    static let muted = Color(red: 0.73, green: 0.77, blue: 0.68)
    static let ink = Color(red: 0.04, green: 0.06, blue: 0.03)

    static func color(for category: String) -> Color {
        switch category {
        case "工具": return Color(red: 0.37, green: 0.86, blue: 0.85)
        case "武器與護甲": return Color(red: 0.78, green: 0.77, blue: 0.96)
        case "食物": return Color(red: 0.98, green: 0.68, blue: 0.34)
        case "材料": return Color(red: 0.96, green: 0.86, blue: 0.42)
        case "紅石與運輸": return Color(red: 1, green: 0.46, blue: 0.42)
        default: return green
        }
    }
}

struct PixelBackground: View {
    var body: some View {
        Canvas { context, size in
            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(MinecraftTheme.background))
            for y in stride(from: 0, to: Int(size.height), by: 24) {
                for x in stride(from: 0, to: Int(size.width), by: 24) {
                    let shade = (x / 24 * 7 + y / 24 * 13) % 5
                    context.fill(
                        Path(CGRect(x: x, y: y, width: 24, height: 24)),
                        with: .color(.white.opacity(Double(shade) * 0.009))
                    )
                }
            }
        }
        .ignoresSafeArea()
        .accessibilityHidden(true)
        .allowsHitTesting(false)
    }
}

struct BlockPanel: ViewModifier {
    var color: Color = MinecraftTheme.panel

    func body(content: Content) -> some View {
        content
            .background(color)
            .overlay {
                Rectangle().strokeBorder(.black.opacity(0.85), lineWidth: 2)
                    .overlay(alignment: .top) { Rectangle().fill(.white.opacity(0.22)).frame(height: 2).padding(.horizontal, 2) }
                    .overlay(alignment: .leading) { Rectangle().fill(.white.opacity(0.14)).frame(width: 2).padding(.vertical, 2) }
                    .overlay(alignment: .bottom) { Rectangle().fill(.black.opacity(0.4)).frame(height: 4).padding(.horizontal, 2) }
                    .allowsHitTesting(false)
            }
    }
}

extension View {
    func blockPanel(_ color: Color = MinecraftTheme.panel) -> some View {
        modifier(BlockPanel(color: color))
    }

    func minecraftScreen() -> some View {
        background { PixelBackground() }
            .toolbarBackground(MinecraftTheme.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct BlockButtonStyle: ButtonStyle {
    var selected = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(selected ? MinecraftTheme.ink : .white)
            .blockPanel(selected ? MinecraftTheme.green : MinecraftTheme.panel)
            .offset(y: configuration.isPressed ? 2 : 0)
            .brightness(configuration.isPressed ? -0.08 : 0)
    }
}

/// Original pixel illustration, drawn on an integer grid to keep hard block edges.
struct GrassBlockArt: View {
    var body: some View {
        Canvas { context, size in
            let unit = min(size.width, size.height) / 16
            for row in 0..<16 {
                for column in 0..<16 {
                    let seed = (row * 7 + column * 11) % 5
                    let grass = row < 4 || (row < 6 && column % 3 == 0)
                    let color = grass
                        ? Color(red: 0.27 + Double(seed) * 0.055, green: 0.48 + Double(seed) * 0.055, blue: 0.12)
                        : Color(red: 0.30 + Double(seed) * 0.045, green: 0.19 + Double(seed) * 0.03, blue: 0.10 + Double(seed) * 0.02)
                    context.fill(Path(CGRect(x: CGFloat(column) * unit, y: CGFloat(row) * unit, width: unit, height: unit)), with: .color(color))
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .overlay { Rectangle().strokeBorder(.black.opacity(0.6), lineWidth: 3) }
        .accessibilityHidden(true)
    }
}

struct CatalogHero: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("MINECRAFT").font(.system(.title, design: .monospaced, weight: .black))
                        .tracking(2).foregroundStyle(MinecraftTheme.green)
                        .shadow(color: .black, radius: 0, x: 2, y: 3)
                    Text("冒險者的物品圖鑑").font(.title2.bold())
                    Text("從第一塊木頭，開始你的世界。")
                        .font(.subheadline).foregroundStyle(MinecraftTheme.muted)
                }
                Spacer(minLength: 0)
                GrassBlockArt().frame(width: 64, height: 64)
            }
            Text("\(Catalog.items.count) 種物品  /  \(Catalog.categories.count) 大分類")
                .font(.system(.caption, design: .monospaced, weight: .bold))
                .foregroundStyle(MinecraftTheme.green)
            Rectangle().fill(MinecraftTheme.green).frame(height: 5)
        }
        .padding(20)
        .blockPanel(Color(red: 0.16, green: 0.23, blue: 0.12))
    }
}

struct ItemSlot: View {
    let item: MinecraftItem
    var large = false

    var body: some View {
        Image(item.imageName)
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .frame(width: large ? 96 : 40, height: large ? 96 : 40)
            .shadow(color: .black.opacity(0.6), radius: 0, x: 3, y: 3)
            .frame(width: large ? 132 : 58, height: large ? 132 : 58)
            .background(MinecraftTheme.ink)
            .overlay { Rectangle().strokeBorder(MinecraftTheme.muted.opacity(0.45), lineWidth: 3) }
            .accessibilityHidden(true)
    }
}

struct InventoryCard: View {
    let item: MinecraftItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                ItemSlot(item: item)
                Spacer(minLength: 0)
                Image(systemName: "chevron.right").font(.caption.bold())
                    .foregroundStyle(MinecraftTheme.muted)
            }
            Text(item.name).font(.headline).foregroundStyle(.white)
            Text(item.englishName).font(.system(.caption, design: .monospaced))
                .foregroundStyle(MinecraftTheme.muted)
                .fixedSize(horizontal: false, vertical: true)
            Text(item.category).font(.caption2.bold())
                .foregroundStyle(MinecraftTheme.color(for: item.category))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .frame(maxHeight: .infinity, alignment: .top)
        .contentShape(Rectangle())
    }
}
