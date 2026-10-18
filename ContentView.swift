import SwiftUI

struct ContentView: View {
    @State private var counter: Int = 0
    @State private var isLightMode: Bool = false
    @State private var animateGlow: Bool = false
    
    var body: some View {
        ZStack {
            // Fluid / Liquid Animated Background
            LiquidBackground(animateGlow: $animateGlow)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Glass Header Card
                VStack(spacing: 8) {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.cyan, .white, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: .cyan.opacity(0.8), radius: 12)
                    
                    Text("Liquid Glass")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("SwiftUI Glassmorphism")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.vertical, 25)
                .padding(.horizontal, 30)
                .glassCard(cornerRadius: 28)
                .padding(.top, 40)
                
                // Content Card with interactive counter
                VStack(spacing: 16) {
                    Text("Счётчик нажатий")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("\(counter)")
                        .font(.system(size: 64, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .contentTransition(.numericText())
                    
                    Text("Красивый эффект жидкого стекла с размытием ультра-тонкого материала, цветными бликами и свечением.")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.75))
                        .padding(.horizontal, 10)
                }
                .padding(24)
                .glassCard(cornerRadius: 24)
                
                Spacer()
                
                // Glass Action Buttons
                VStack(spacing: 14) {
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                            counter += 1
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Увеличить")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                    }
                    .glassButton(tint: .cyan.opacity(0.3))
                    
                    HStack(spacing: 14) {
                        Button(action: {
                            withAnimation(.spring()) {
                                counter = 0
                            }
                        }) {
                            HStack {
                                Image(systemName: "arrow.counterclockwise")
                                Text("Сброс")
                            }
                            .font(.subheadline.bold())
                            .foregroundColor(.white.opacity(0.9))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                        }
                        .glassButton(tint: .pink.opacity(0.25))
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                animateGlow.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Волна")
                            }
                            .font(.subheadline.bold())
                            .foregroundColor(.white.opacity(0.9))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                        }
                        .glassButton(tint: .purple.opacity(0.25))
                    }
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                animateGlow = true
            }
        }
    }
}

// Background with animated colored fluid blobs
struct LiquidBackground: View {
    @Binding var animateGlow: Bool
    
    var body: some View {
        ZStack {
            Color.black
            
            Circle()
                .fill(Color.purple.opacity(0.55))
                .frame(width: 320, height: 320)
                .blur(radius: 70)
                .offset(x: animateGlow ? -100 : 80, y: animateGlow ? -200 : -100)
            
            Circle()
                .fill(Color.cyan.opacity(0.6))
                .frame(width: 280, height: 280)
                .blur(radius: 65)
                .offset(x: animateGlow ? 120 : -90, y: animateGlow ? 100 : 250)
            
            Circle()
                .fill(Color.pink.opacity(0.45))
                .frame(width: 250, height: 250)
                .blur(radius: 60)
                .offset(x: animateGlow ? -60 : 70, y: animateGlow ? 260 : 50)
        }
    }
}

// View Modifier for Glassmorphism Cards
struct GlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.35),
                                        Color.white.opacity(0.05),
                                        Color.clear
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.6),
                                        Color.white.opacity(0.1),
                                        Color.cyan.opacity(0.3)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.2
                            )
                    )
                    .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 10)
            )
    }
}

// View Modifier for Glassmorphic Buttons
struct GlassButtonModifier: ViewModifier {
    var tint: Color
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(tint)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.6), Color.white.opacity(0.1)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 1
                            )
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            )
    }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 20) -> some View {
        modifier(GlassCardModifier(cornerRadius: cornerRadius))
    }
    
    func glassButton(tint: Color = .clear) -> some View {
        modifier(GlassButtonModifier(tint: tint))
    }
}
