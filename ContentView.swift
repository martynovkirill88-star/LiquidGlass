import SwiftUI

struct ContentView: View {
    @State private var counter: Int = 0
    @State private var animateGlow: Bool = false
    @State private var wavePulse: Bool = false
    
    // Haptic feedback generator
    private let impactMed = UIImpactFeedbackGenerator(style: .medium)
    private let impactRigid = UIImpactFeedbackGenerator(style: .rigid)
    private let notificationFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            // Dynamic fluid liquid background with morphing blobs
            LiquidBackground(animateGlow: $animateGlow, wavePulse: $wavePulse)
                .ignoresSafeArea()
            
            VStack(spacing: 28) {
                // Top Header Glass Capsule
                HStack(spacing: 12) {
                    Image(systemName: "drop.fill")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.cyan, .white],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .font(.system(size: 24, weight: .bold))
                    
                    Text("Liquid Glass")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("iOS Native")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.white.opacity(0.85))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.ultraThinMaterial, in: Capsule())
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .systemLiquidGlassCard(cornerRadius: 30)
                .padding(.top, 20)
                
                // Main Counter Card with thick glass refraction effect
                VStack(spacing: 12) {
                    Text("СЧЁТЧИК НАЖАТИЙ")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .tracking(1.5)
                        .foregroundColor(.white.opacity(0.65))
                    
                    Text("\(counter)")
                        .font(.system(size: 76, weight: .heavy, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white, Color(white: 0.88)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(color: .cyan.opacity(0.4), radius: 20, x: 0, y: 10)
                        .contentTransition(.numericText())
                    
                    Text("Системное жидкое стекло: преломление света, ультратонкий матовый слой и тактильный виброотклик.")
                        .font(.system(size: 13, weight: .regular))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.horizontal, 12)
                }
                .padding(.vertical, 32)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity)
                .systemLiquidGlassCard(cornerRadius: 32)
                
                Spacer()
                
                // System Liquid Glass Buttons
                VStack(spacing: 16) {
                    // Big Primary Liquid Glass Button
                    LiquidGlassButton(
                        title: "Добавить +1",
                        icon: "plus.circle.fill",
                        tintColor: Color.cyan,
                        action: {
                            impactMed.impactOccurred()
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
                                counter += 1
                            }
                        }
                    )
                    
                    HStack(spacing: 14) {
                        // Reset button
                        LiquidGlassButton(
                            title: "Сброс",
                            icon: "arrow.counterclockwise",
                            tintColor: Color.pink,
                            isCompact: true,
                            action: {
                                notificationFeedback.notificationOccurred(.warning)
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    counter = 0
                                }
                            }
                        )
                        
                        // Wave button
                        LiquidGlassButton(
                            title: "Волна",
                            icon: "sparkles",
                            tintColor: Color.purple,
                            isCompact: true,
                            action: {
                                impactRigid.impactOccurred()
                                withAnimation(.easeInOut(duration: 0.8)) {
                                    wavePulse.toggle()
                                    animateGlow.toggle()
                                }
                            }
                        )
                    }
                }
                .padding(.bottom, 34)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                animateGlow = true
            }
        }
    }
}

// Custom Native System Liquid Glass Button with spring press effect
struct LiquidGlassButton: View {
    let title: String
    let icon: String
    let tintColor: Color
    var isCompact: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: isCompact ? 16 : 20, weight: .bold))
                
                Text(title)
                    .font(.system(size: isCompact ? 16 : 18, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, isCompact ? 15 : 18)
        }
        .buttonStyle(SystemLiquidGlassButtonStyle(tintColor: tintColor))
    }
}

// Interactive button style with authentic glass refraction, bevels & press depression
struct SystemLiquidGlassButtonStyle: ButtonStyle {
    let tintColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    // 1. Native iOS UltraThin Material for blur
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(.ultraThinMaterial)
                    
                    // 2. Liquid Glass Tint Glow
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    tintColor.opacity(configuration.isPressed ? 0.45 : 0.25),
                                    tintColor.opacity(configuration.isPressed ? 0.2 : 0.08)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    // 3. Top-edge glass reflection (light catch / bevel)
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(configuration.isPressed ? 0.35 : 0.65),
                                    Color.white.opacity(0.12),
                                    Color.clear
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .padding(1)
                    
                    // 4. Subtle inner shadow for glass depth
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.8),
                                    Color.white.opacity(0.2),
                                    tintColor.opacity(0.4)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.2
                        )
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            // 5. Authentic multi-layered soft drop shadows
            .shadow(
                color: tintColor.opacity(configuration.isPressed ? 0.15 : 0.35),
                radius: configuration.isPressed ? 6 : 14,
                x: 0,
                y: configuration.isPressed ? 2 : 7
            )
            .shadow(
                color: Color.black.opacity(0.3),
                radius: configuration.isPressed ? 3 : 8,
                x: 0,
                y: configuration.isPressed ? 2 : 4
            )
            // Liquid tactile spring response
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(.spring(response: 0.28, dampingFraction: 0.65), value: configuration.isPressed)
    }
}

// Background with animated colored fluid blobs
struct LiquidBackground: View {
    @Binding var animateGlow: Bool
    @Binding var wavePulse: Bool
    
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.06, blue: 0.11)
            
            // Blob 1: Deep Indigo / Violet
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.purple.opacity(0.85), Color.purple.opacity(0)],
                        center: .center,
                        startRadius: 10,
                        endRadius: 180
                    )
                )
                .frame(width: 360, height: 360)
                .blur(radius: 50)
                .offset(
                    x: animateGlow ? -90 : 90,
                    y: animateGlow ? -230 : -110
                )
            
            // Blob 2: Vibrant Cyan / Azure
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.cyan.opacity(0.9), Color.blue.opacity(0)],
                        center: .center,
                        startRadius: 10,
                        endRadius: 170
                    )
                )
                .frame(width: 320, height: 320)
                .blur(radius: 50)
                .scaleEffect(wavePulse ? 1.2 : 1.0)
                .offset(
                    x: animateGlow ? 110 : -80,
                    y: animateGlow ? 120 : 260
                )
            
            // Blob 3: Neon Magenta / Rose
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.pink.opacity(0.75), Color.clear],
                        center: .center,
                        startRadius: 10,
                        endRadius: 160
                    )
                )
                .frame(width: 290, height: 290)
                .blur(radius: 45)
                .offset(
                    x: animateGlow ? -70 : 80,
                    y: animateGlow ? 280 : 60
                )
        }
    }
}

// View Modifier for System Liquid Glass Cards
struct SystemLiquidGlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(.ultraThinMaterial)
                    
                    // Glass highlight reflection
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.28),
                                    Color.white.opacity(0.04),
                                    Color.clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    // Glass boundary light rim
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.75),
                                    Color.white.opacity(0.15),
                                    Color.cyan.opacity(0.25)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.2
                        )
                }
            )
            .shadow(color: Color.black.opacity(0.35), radius: 25, x: 0, y: 12)
    }
}

extension View {
    func systemLiquidGlassCard(cornerRadius: CGFloat = 24) -> some View {
        modifier(SystemLiquidGlassCardModifier(cornerRadius: cornerRadius))
    }
}
