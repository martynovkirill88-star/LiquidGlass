import SwiftUI

struct ContentView: View {
    @State private var counter: Int = 0
    @State private var selectedTab: Int = 0
    @State private var toggleState1: Bool = true
    @State private var toggleState2: Bool = false
    @State private var dynamicFlow: Bool = false
    
    private let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    private let selectionFeedback = UISelectionFeedbackGenerator()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Background Wallpaper with Real Dynamic Blobs underneath the glass
                FluidLiquidUnderlay(dynamicFlow: $dynamicFlow)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .clipped()
                
                // Content Layer
                VStack(spacing: 0) {
                    // 1. Top Translucent Frosted Glass Island / Header
                    HStack {
                        HStack(spacing: 8) {
                            Image(systemName: "drop.fill")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.cyan, .white],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                            Text("Liquid Glass")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        // Glass Indicator
                        HStack(spacing: 6) {
                            Circle()
                                .fill(toggleState1 ? Color.green : Color.orange)
                                .frame(width: 8, height: 8)
                                .shadow(color: toggleState1 ? .green.opacity(0.8) : .clear, radius: 4)
                            Text(toggleState1 ? "Fluid" : "Static")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(GlassPillBackground())
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(GlassContainerBackground(cornerRadius: 24))
                    .padding(.horizontal, 16)
                    .padding(.top, proxy.safeAreaInsets.top > 0 ? proxy.safeAreaInsets.top : 20)
                    
                    // 2. Liquid Glass Segmented Pill Switcher (System iOS Control Center Style)
                    HStack(spacing: 6) {
                        SegmentGlassTab(title: "Счётчик", icon: "gauge.with.needle", isSelected: selectedTab == 0) {
                            selectionFeedback.selectionChanged()
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.72)) { selectedTab = 0 }
                        }
                        SegmentGlassTab(title: "Тумблеры", icon: "switch.2", isSelected: selectedTab == 1) {
                            selectionFeedback.selectionChanged()
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.72)) { selectedTab = 1 }
                        }
                    }
                    .padding(5)
                    .background(GlassContainerBackground(cornerRadius: 30))
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    
                    Spacer()
                    
                    // 3. Middle Dynamic Glass Stage
                    if selectedTab == 0 {
                        VStack(spacing: 14) {
                            Text("СЧЁТЧИК")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .tracking(2)
                                .foregroundColor(.white.opacity(0.65))
                            
                            Text("\(counter)")
                                .font(.system(size: 78, weight: .heavy, design: .rounded))
                                .foregroundColor(.white)
                                .shadow(color: .cyan.opacity(0.4), radius: 20)
                                .contentTransition(.numericText())
                            
                            Text("Настоящее стекло: прозрачное тело с преломлением капель фона, белая кромка света и мягкая тень.")
                                .font(.system(size: 13, weight: .regular))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white.opacity(0.75))
                                .padding(.horizontal, 16)
                        }
                        .padding(.vertical, 28)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .background(GlassContainerBackground(cornerRadius: 32))
                        .padding(.horizontal, 20)
                        .transition(.scale(scale: 0.95).combined(with: .opacity))
                    } else {
                        VStack(spacing: 18) {
                            Text("ПЕРЕКЛЮЧАТЕЛИ СТЕКЛА")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .tracking(2)
                                .foregroundColor(.white.opacity(0.65))
                            
                            // Glass Switch 1
                            HStack {
                                Label("Анимация жидкости", systemImage: "sparkles")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                Spacer()
                                SystemLiquidSwitch(isOn: $dynamicFlow)
                            }
                            .padding(.horizontal, 14)
                            
                            Divider().background(Color.white.opacity(0.2))
                            
                            // Glass Switch 2
                            HStack {
                                Label("Глянцевый блеск", systemImage: "sun.max.fill")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                Spacer()
                                SystemLiquidSwitch(isOn: $toggleState1)
                            }
                            .padding(.horizontal, 14)
                        }
                        .padding(.vertical, 24)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .background(GlassContainerBackground(cornerRadius: 32))
                        .padding(.horizontal, 20)
                        .transition(.scale(scale: 0.95).combined(with: .opacity))
                    }
                    
                    Spacer()
                    
                    // 4. Bottom Liquid Glass Buttons (Капсулы со светом)
                    VStack(spacing: 12) {
                        SystemGlassActionButton(
                            title: "Добавить +1",
                            icon: "plus.circle.fill",
                            accent: .cyan
                        ) {
                            impactFeedback.impactOccurred()
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
                                counter += 1
                            }
                        }
                        
                        HStack(spacing: 12) {
                            SystemGlassActionButton(
                                title: "Сброс",
                                icon: "arrow.counterclockwise",
                                accent: .pink,
                                isCompact: true
                            ) {
                                impactFeedback.impactOccurred()
                                withAnimation(.spring()) {
                                    counter = 0
                                }
                            }
                            
                            SystemGlassActionButton(
                                title: "Капли",
                                icon: "waveform",
                                accent: .purple,
                                isCompact: true
                            ) {
                                impactFeedback.impactOccurred()
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    dynamicFlow.toggle()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, proxy.safeAreaInsets.bottom > 0 ? proxy.safeAreaInsets.bottom + 10 : 25)
                }
            }
            .ignoresSafeArea(.all)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
                dynamicFlow = true
            }
        }
    }
}

// MARK: - Authentic Glass Container Background
// Прозрачное стекло с ультратонким размытием, скошенной светящейся кромкой и реалистичной прозрачностью
struct GlassContainerBackground: View {
    var cornerRadius: CGFloat = 24
    
    var body: some View {
        ZStack {
            // 1. Фирменный блюр iOS
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(.ultraThinMaterial)
            
            // 2. Полупрозрачное молочно-стеклянное тело (пропускает свет сзади!)
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        stops: [
                            .init(color: Color.white.opacity(0.18), location: 0.0),
                            .init(color: Color.white.opacity(0.04), location: 0.3),
                            .init(color: Color.clear, location: 0.7)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            // 3. Верхний скошенный световой блик (Specular Reflection)
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(
                    LinearGradient(
                        stops: [
                            .init(color: Color.white.opacity(0.7), location: 0.0),
                            .init(color: Color.white.opacity(0.2), location: 0.25),
                            .init(color: Color.white.opacity(0.05), location: 0.6),
                            .init(color: Color.white.opacity(0.3), location: 1.0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.2
                )
        }
        .shadow(color: Color.black.opacity(0.25), radius: 18, x: 0, y: 10)
    }
}

// MARK: - Glass Action Button with Real Press Depth
struct SystemGlassActionButton: View {
    let title: String
    let icon: String
    let accent: Color
    var isCompact: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: isCompact ? 16 : 18, weight: .bold))
                Text(title)
                    .font(.system(size: isCompact ? 15 : 17, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, isCompact ? 14 : 17)
        }
        .buttonStyle(SystemGlassButtonStyle(accent: accent))
    }
}

struct SystemGlassButtonStyle: ButtonStyle {
    let accent: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    Capsule()
                        .fill(.ultraThinMaterial)
                    
                    // Glass Accent Glow
                    Capsule()
                        .fill(accent.opacity(configuration.isPressed ? 0.35 : 0.18))
                    
                    // Glass Top Highlight
                    Capsule()
                        .fill(
                            LinearGradient(
                                stops: [
                                    .init(color: Color.white.opacity(configuration.isPressed ? 0.2 : 0.45), location: 0.0),
                                    .init(color: Color.clear, location: 0.65)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .padding(1)
                    
                    // Glass Edge Stroke
                    Capsule()
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(configuration.isPressed ? 0.4 : 0.75),
                                    Color.white.opacity(0.15)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 1.1
                        )
                }
            )
            .clipShape(Capsule())
            .shadow(color: accent.opacity(configuration.isPressed ? 0.1 : 0.3), radius: 10, y: 4)
            .shadow(color: Color.black.opacity(0.2), radius: 8, y: 3)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.28, dampingFraction: 0.68), value: configuration.isPressed)
    }
}

// MARK: - Native Liquid Glass Toggle Switch (Переключатель)
struct SystemLiquidSwitch: View {
    @Binding var isOn: Bool
    private let impact = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            // Track
            Capsule()
                .fill(.ultraThinMaterial)
                .overlay(
                    Capsule().fill(isOn ? Color.cyan.opacity(0.4) : Color.white.opacity(0.08))
                )
                .overlay(
                    Capsule().stroke(
                        LinearGradient(
                            colors: [Color.white.opacity(isOn ? 0.7 : 0.3), Color.white.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                )
                .frame(width: 56, height: 32)
            
            // Glass Knob
            Circle()
                .fill(.ultraThinMaterial)
                .overlay(
                    Circle().fill(Color.white.opacity(0.95))
                        .padding(2)
                )
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 1)
                )
                .frame(width: 28, height: 28)
                .shadow(color: Color.black.opacity(0.25), radius: 4, y: 2)
                .padding(.horizontal, 2)
        }
        .onTapGesture {
            impact.impactOccurred()
            withAnimation(.spring(response: 0.32, dampingFraction: 0.68)) {
                isOn.toggle()
            }
        }
    }
}

// MARK: - Segment Tab
struct SegmentGlassTab: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .bold))
                Text(title)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            .foregroundColor(isSelected ? .white : .white.opacity(0.6))
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(
                Group {
                    if isSelected {
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .overlay(Capsule().fill(Color.white.opacity(0.2)))
                            .overlay(Capsule().stroke(Color.white.opacity(0.65), lineWidth: 1))
                            .shadow(color: .black.opacity(0.2), radius: 6, y: 2)
                    }
                }
            )
        }
        .buttonStyle(.plain)
    }
}

struct GlassPillBackground: View {
    var body: some View {
        Capsule()
            .fill(.ultraThinMaterial)
            .overlay(Capsule().stroke(Color.white.opacity(0.4), lineWidth: 0.8))
    }
}

// MARK: - Dynamic Fluid Liquid Wallpaper
struct FluidLiquidUnderlay: View {
    @Binding var dynamicFlow: Bool
    
    var body: some View {
        ZStack {
            Color(red: 0.03, green: 0.04, blue: 0.07)
            
            // Flowing organic fluid lights
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.purple.opacity(0.9), Color.purple.opacity(0)],
                        center: .center,
                        startRadius: 20,
                        endRadius: 200
                    )
                )
                .frame(width: 420, height: 420)
                .blur(radius: 65)
                .offset(x: dynamicFlow ? -90 : 80, y: dynamicFlow ? -220 : -100)
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.cyan.opacity(0.85), Color.blue.opacity(0)],
                        center: .center,
                        startRadius: 20,
                        endRadius: 210
                    )
                )
                .frame(width: 390, height: 390)
                .blur(radius: 60)
                .offset(x: dynamicFlow ? 100 : -80, y: dynamicFlow ? 120 : 240)
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.pink.opacity(0.75), Color.clear],
                        center: .center,
                        startRadius: 10,
                        endRadius: 170
                    )
                )
                .frame(width: 320, height: 320)
                .blur(radius: 50)
                .offset(x: dynamicFlow ? -70 : 80, y: dynamicFlow ? 280 : 70)
        }
    }
}
