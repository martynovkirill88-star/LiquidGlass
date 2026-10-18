import SwiftUI

struct ContentView: View {
    @State private var counter: Int = 0
    @State private var selectedTab: Int = 0
    @State private var isLiquidEffectOn: Bool = true
    @State private var ambientGlow: Bool = true
    @State private var sliderValue: Double = 0.65
    
    private let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    private let selectionFeedback = UISelectionFeedbackGenerator()
    
    var body: some View {
        ZStack {
            // Edge-to-edge organic liquid background
            LiquidWallpaper(ambientGlow: $ambientGlow)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 20) {
                // Top System Liquid Glass Floating Navigation Bar
                HStack {
                    HStack(spacing: 8) {
                        Image(systemName: "drop.degreesign.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 20))
                        
                        Text("Liquid Glass")
                            .font(.system(size: 19, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    // Liquid Glass Switch / Status Pill
                    HStack(spacing: 6) {
                        Circle()
                            .fill(isLiquidEffectOn ? Color.green : Color.gray)
                            .frame(width: 8, height: 8)
                            .shadow(color: isLiquidEffectOn ? .green : .clear, radius: 4)
                        
                        Text(isLiquidEffectOn ? "Active" : "Paused")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .overlay(
                                Capsule().stroke(Color.white.opacity(0.35), lineWidth: 0.8)
                            )
                    )
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 26, style: .continuous)
                                .stroke(
                                    LinearGradient(
                                        colors: [Color.white.opacity(0.6), Color.white.opacity(0.1)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                        .shadow(color: .black.opacity(0.25), radius: 15, x: 0, y: 8)
                )
                .padding(.horizontal, 16)
                .padding(.top, 10)
                
                // Segmented Picker / Toggle Bar (настоящее системное жидкое стекло Apple)
                HStack(spacing: 4) {
                    LiquidSegmentItem(title: "Счётчик", icon: "gauge.with.needle", isSelected: selectedTab == 0) {
                        selectionFeedback.selectionChanged()
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) { selectedTab = 0 }
                    }
                    LiquidSegmentItem(title: "Опции", icon: "slider.horizontal.3", isSelected: selectedTab == 1) {
                        selectionFeedback.selectionChanged()
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) { selectedTab = 1 }
                    }
                }
                .padding(4)
                .background(
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .overlay(
                            Capsule().stroke(Color.white.opacity(0.25), lineWidth: 0.8)
                        )
                        .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 6)
                )
                .padding(.horizontal, 24)
                
                // Center Display Card
                if selectedTab == 0 {
                    VStack(spacing: 16) {
                        Text("ЭЛЕМЕНТ СТЕКЛА")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .tracking(2)
                            .foregroundColor(.white.opacity(0.6))
                        
                        Text("\(counter)")
                            .font(.system(size: 84, weight: .heavy, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.white, Color(white: 0.9)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .contentTransition(.numericText())
                            .shadow(color: Color.cyan.opacity(0.4), radius: 25)
                        
                        Text("Оригинальный системный материал с каустикой, плавным световым контуром и преломлением.")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.75))
                            .padding(.horizontal, 16)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
                    .padding(.horizontal, 20)
                    .background(
                        AppleLiquidGlassSurface(cornerRadius: 32)
                    )
                    .padding(.horizontal, 16)
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
                } else {
                    // Settings & Toggles Tab
                    VStack(spacing: 20) {
                        Text("ПЕРЕКЛЮЧАТЕЛИ СТЕКЛА")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .tracking(2)
                            .foregroundColor(.white.opacity(0.6))
                        
                        // Liquid Glass Toggle 1
                        HStack {
                            Label("Жидкая анимация", systemImage: "sparkles")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            LiquidGlassToggle(isOn: $ambientGlow)
                        }
                        .padding(.horizontal, 14)
                        
                        Divider().background(Color.white.opacity(0.2))
                        
                        // Liquid Glass Toggle 2
                        HStack {
                            Label("Статус эффекта", systemImage: "waveform.path")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            LiquidGlassToggle(isOn: $isLiquidEffectOn)
                        }
                        .padding(.horizontal, 14)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .padding(.horizontal, 20)
                    .background(
                        AppleLiquidGlassSurface(cornerRadius: 32)
                    )
                    .padding(.horizontal, 16)
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
                }
                
                Spacer()
                
                // Bottom Liquid Glass Action Buttons
                VStack(spacing: 14) {
                    // Main Capsule Action Button
                    AppleLiquidGlassButton(
                        title: "Добавить +1",
                        icon: "plus.circle.fill",
                        tint: .cyan.opacity(0.25)
                    ) {
                        impactFeedback.impactOccurred()
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
                            counter += 1
                        }
                    }
                    
                    HStack(spacing: 12) {
                        AppleLiquidGlassButton(
                            title: "Сбросить",
                            icon: "arrow.counterclockwise",
                            tint: .pink.opacity(0.22)
                        ) {
                            impactFeedback.impactOccurred()
                            withAnimation(.spring()) {
                                counter = 0
                            }
                        }
                        
                        AppleLiquidGlassButton(
                            title: "Импульс",
                            icon: "bolt.fill",
                            tint: .purple.opacity(0.25)
                        ) {
                            impactFeedback.impactOccurred()
                            withAnimation(.easeInOut(duration: 0.8)) {
                                ambientGlow.toggle()
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
                ambientGlow = true
            }
        }
    }
}

// MARK: - Native Apple System Liquid Glass Surface
struct AppleLiquidGlassSurface: View {
    var cornerRadius: CGFloat = 28
    
    var body: some View {
        ZStack {
            // Base Ultra Thin Material for actual blur of content behind
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(.ultraThinMaterial)
            
            // Specular Highlight (Light reflected off the top edge)
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        stops: [
                            .init(color: Color.white.opacity(0.38), location: 0.0),
                            .init(color: Color.white.opacity(0.08), location: 0.15),
                            .init(color: Color.clear, location: 0.6)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            // Optical Bevel Edge Rim (Apple's signature chamfered glass boundary)
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        stops: [
                            .init(color: Color.white.opacity(0.75), location: 0.0),
                            .init(color: Color.white.opacity(0.25), location: 0.3),
                            .init(color: Color.white.opacity(0.05), location: 0.7),
                            .init(color: Color.cyan.opacity(0.35), location: 1.0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.2
                )
        }
        .shadow(color: Color.black.opacity(0.3), radius: 24, x: 0, y: 12)
        .shadow(color: Color.cyan.opacity(0.12), radius: 30, x: 0, y: 10)
    }
}

// MARK: - Liquid Glass Button with Organic Elastic Touch
struct AppleLiquidGlassButton: View {
    let title: String
    let icon: String
    let tint: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 17, weight: .bold))
                
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
        }
        .buttonStyle(AppleLiquidGlassButtonStyle(tint: tint))
    }
}

struct AppleLiquidGlassButtonStyle: ButtonStyle {
    let tint: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    Capsule()
                        .fill(.ultraThinMaterial)
                    
                    Capsule()
                        .fill(tint)
                    
                    // Glass Light Reflection along upper half
                    Capsule()
                        .fill(
                            LinearGradient(
                                stops: [
                                    .init(color: Color.white.opacity(configuration.isPressed ? 0.2 : 0.45), location: 0.0),
                                    .init(color: Color.clear, location: 0.6)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .padding(1)
                    
                    // Delicate glass border stroke
                    Capsule()
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(configuration.isPressed ? 0.4 : 0.8),
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
            .shadow(color: tint.opacity(configuration.isPressed ? 0.2 : 0.4), radius: configuration.isPressed ? 6 : 14, x: 0, y: configuration.isPressed ? 2 : 6)
            .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.65), value: configuration.isPressed)
    }
}

// MARK: - Native Liquid Glass Toggle Switch (Переключатель)
struct LiquidGlassToggle: View {
    @Binding var isOn: Bool
    private let impact = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            // Track (Жидкая стеклянная дорожка)
            Capsule()
                .fill(.ultraThinMaterial)
                .overlay(
                    Capsule()
                        .fill(isOn ? Color.cyan.opacity(0.4) : Color.white.opacity(0.08))
                )
                .overlay(
                    Capsule()
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(isOn ? 0.7 : 0.3),
                                    Color.white.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .frame(width: 58, height: 32)
                .shadow(color: isOn ? Color.cyan.opacity(0.3) : Color.clear, radius: 8)
            
            // Thumb (Стеклянная круглая капля-бегунок)
            Circle()
                .fill(.ultraThinMaterial)
                .overlay(
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.white, Color(white: 0.85)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .padding(2)
                )
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.9), lineWidth: 1)
                )
                .frame(width: 28, height: 28)
                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
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

// MARK: - Segmented Switch Pill
struct LiquidSegmentItem: View {
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
                    .font(.system(size: 14, weight: .medium, design: .rounded))
            }
            .foregroundColor(isSelected ? .white : .white.opacity(0.6))
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    if isSelected {
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .overlay(
                                Capsule().fill(Color.white.opacity(0.18))
                            )
                            .overlay(
                                Capsule().stroke(Color.white.opacity(0.6), lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.15), radius: 6, y: 2)
                    }
                }
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Edge-to-Edge Fluid Liquid Wallpaper
struct LiquidWallpaper: View {
    @Binding var ambientGlow: Bool
    
    var body: some View {
        ZStack {
            Color(red: 0.04, green: 0.05, blue: 0.09)
            
            // Dynamic fluid drops
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.purple.opacity(0.85), Color.purple.opacity(0)],
                        center: .center,
                        startRadius: 20,
                        endRadius: 220
                    )
                )
                .frame(width: 440, height: 440)
                .blur(radius: 65)
                .offset(x: ambientGlow ? -110 : 100, y: ambientGlow ? -260 : -140)
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.cyan.opacity(0.85), Color.blue.opacity(0)],
                        center: .center,
                        startRadius: 20,
                        endRadius: 200
                    )
                )
                .frame(width: 380, height: 380)
                .blur(radius: 60)
                .offset(x: ambientGlow ? 120 : -90, y: ambientGlow ? 160 : 300)
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.pink.opacity(0.7), Color.clear],
                        center: .center,
                        startRadius: 10,
                        endRadius: 180
                    )
                )
                .frame(width: 320, height: 320)
                .blur(radius: 55)
                .offset(x: ambientGlow ? -80 : 90, y: ambientGlow ? 340 : 100)
        }
    }
}
