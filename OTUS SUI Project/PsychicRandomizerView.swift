import SwiftUI
#if canImport(AudioToolbox)
import AudioToolbox
#endif

struct PsychicRandomizerView: View {
    @State private var displayedNumber: Int = 1
    @State private var isAnimating: Bool = false
    @State private var isFinished: Bool = false
    @State private var glowPulse: Bool = false
    @State private var lowerValue: Double = 1
    @State private var upperValue: Double = 20

    private let totalSteps: Int = 60
    private let minDelay: Double = 0.03
    private let maxDelay: Double = 0.22

    private var lowerBound: Int {
        max(1, Int(lowerValue.rounded()))
    }

    private var upperBound: Int {
        max(lowerBound, min(100, Int(upperValue.rounded())))
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.purple.opacity(0.9),
                    Color.black,
                    Color.indigo.opacity(0.9)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()

                VStack(spacing: 12) {
                    ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.white.opacity(0.15),
                                    Color.purple.opacity(0.6),
                                    Color.black
                                ],
                                center: .center,
                                startRadius: 10,
                                endRadius: 260
                            )
                        )
                        .frame(width: 310, height: 310)
                        .shadow(color: .purple.opacity(0.6), radius: 25, x: 0, y: 0)

                    Circle()
                        .strokeBorder(
                            AngularGradient(
                                gradient: Gradient(colors: [
                                    .purple,
                                    .blue,
                                    .mint,
                                    .purple
                                ]),
                                center: .center
                            ),
                            lineWidth: 4
                        )
                        .frame(width: glowPulse ? 320 : 290, height: glowPulse ? 320 : 290)
                        .opacity(isFinished ? 1 : 0.3)
                        .blur(radius: 1.5)
                        .animation(
                            isFinished
                            ? .easeInOut(duration: 1.4).repeatForever(autoreverses: true)
                            : .default,
                            value: glowPulse
                        )

                    Text("\(displayedNumber)")
                        .font(.system(size: 140, weight: .black, design: .rounded))
                        .kerning(3)
                        .foregroundStyle(
                            isFinished
                            ? LinearGradient(
                                colors: [.yellow, .orange, .red],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            : LinearGradient(
                                colors: [.white, .cyan],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: .black.opacity(0.8), radius: 18, x: 0, y: 10)
                        .shadow(color: .purple.opacity(0.7), radius: 30, x: 0, y: 0)
                        .scaleEffect(isAnimating ? 1.1 : (isFinished ? 1.15 : 1.0))
                        .animation(
                            isAnimating
                            ? .easeInOut(duration: 0.25).repeatForever(autoreverses: true)
                            : .spring(response: 0.5, dampingFraction: 0.45),
                            value: isAnimating
                        )
                        .animation(
                            .spring(response: 0.6, dampingFraction: 0.5),
                            value: isFinished
                        )
                        .animation(
                            .easeInOut(duration: 0.12),
                            value: displayedNumber
                        )
                    }
                    .frame(height: 320)

                    Text("Загадай число от \(lowerBound) до \(upperBound)")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity)
                        .frame(height: 22, alignment: .center)
                }

                Spacer(minLength: 0)

                VStack(spacing: 8) {
                    HStack {
                        Text("от \(lowerBound)")
                            .font(.footnote)
                            .foregroundStyle(.white.opacity(0.7))

                        Slider(value: Binding(
                            get: { lowerValue },
                            set: { newValue in
                                lowerValue = min(newValue, upperValue)
                            }
                        ), in: 1...100, step: 1)
                        .tint(.purple)
                    }

                    HStack {
                        Text("до \(upperBound)")
                            .font(.footnote)
                            .foregroundStyle(.white.opacity(0.7))

                        Slider(value: Binding(
                            get: { upperValue },
                            set: { newValue in
                                upperValue = max(newValue, lowerValue)
                            }
                        ), in: 1...100, step: 1)
                        .tint(.purple)
                    }
                }
                .padding(.horizontal, 8)

                Button {
                    startRandomization()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: isAnimating ? "sparkles" : "wand.and.stars")
                        Text(isAnimating ? "Идет предсказание..." : (isFinished ? "Запустить ещё раз" : "Запустить рандомайзер"))
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 28)
                    .padding(.vertical, 14)
                    .background(
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [.purple, .pink, .orange],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                    .foregroundStyle(.white)
                    .shadow(color: .purple.opacity(0.7), radius: 14, x: 0, y: 8)
                }
                .disabled(isAnimating)
                .opacity(isAnimating ? 0.8 : 1)
                .frame(height: 56)
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }

    private func startRandomization() {
        isAnimating = true
        isFinished = false
        glowPulse = false

        let finalNumber = Int.random(in: lowerBound...upperBound)
        let startNumber = Int.random(in: lowerBound...upperBound)
        displayedNumber = startNumber

        animateStep(step: 0, currentNumber: startNumber, finalNumber: finalNumber)
    }

    private func animateStep(step: Int, currentNumber: Int, finalNumber: Int) {
        if step >= totalSteps {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.45)) {
                displayedNumber = finalNumber
                isAnimating = false
                isFinished = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                glowPulse.toggle()

                #if os(iOS)
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                #if canImport(AudioToolbox)
                // Лёгкий системный звук при появлении финальной цифры
                AudioServicesPlaySystemSound(1104)
                #endif
                #endif
            }

            return
        }

        let progress = Double(step) / Double(totalSteps)
        let eased = progress * progress
        let delay = minDelay + (maxDelay - minDelay) * eased

        let nextNumber = Int.random(in: lowerBound...upperBound)
        displayedNumber = nextNumber

        #if os(iOS)
        #if canImport(AudioToolbox)
        // Быстрый системный звук на каждом шаге смены числа
        AudioServicesPlaySystemSound(1104)
        #endif
        #endif

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            animateStep(step: step + 1, currentNumber: nextNumber, finalNumber: finalNumber)
        }
    }
}

#Preview {
    NavigationStack {
        PsychicRandomizerView()
    }
}

