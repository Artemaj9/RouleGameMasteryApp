//
//  Welcome.swift
//

import SwiftUI

struct ShakeData {
  var offset: AnimatableDouble = AnimatableDouble(value: -500)
  var opacity: AnimatableDouble = AnimatableDouble(value: 0)
  var saturation: AnimatableDouble = AnimatableDouble(value: 1)
  var rotation: Angle = .zero
}

struct MoveData {
  var offset: AnimatableDouble = AnimatableDouble(value: 700)
  var opacity: AnimatableDouble = AnimatableDouble(value: 0)
  var rotation: Angle = .zero
}

struct Welcome: View {
  @EnvironmentObject var vm: GameViewModel
  @State private var stage = 1
  @State private var shakes = 0
  
  var body: some View {
    ZStack {
      if stage == 1 {
          bg
          skipBtn
          firstHeader
          firstText
          nextbtnAnimator
      } else {
        ZStack {
        Image(.welcsecbg)
            .backgroundFill()
        Text("How It Works?")
            .rouleFont(size: 50, style: .ibarraRealNovaSI, color: Color(hex: "#F3D9A5"))
            .multilineTextAlignment(.center)

            .yOffset(-vm.h*0.35)
          Image(.welcdata)
            .resizableToFit()
            .padding(30)
      }
          .transition(.ripple(location: CGPoint(x: 0, y: 0)))
          .ignoresSafeArea()

      }
      nextbtnAnimator2
    }
    .animation(.interpolatingSpring(stiffness: 30, damping: 2).delay(1), value: stage)
    .onAppear {
      shakes += 1
      vm.setupTwirlTimer()
    }
  }
  
  private var bg: some View {
    ZStack {
      Image(.welcroulebg)
        .backgroundFill()
        .saturation(shakes == 1 ? 1 : 0)
        .animation(.easeInOut(duration: 1.4).delay(2), value: shakes)
        .overlay {
          Image(uiImage: vm.filteredImage)
            .backgroundFill()
            .saturation(2)
            .opacity(0.2)
        }
    }
  
  }
  
  private var skipBtn: some View {
    Button {
      vm.isWelcome = false
    } label: {
      Text("Skip")
        .rouleFont(size: 17, style: .interM, color: .white)
        .padding()
        .tappableBg()
    }
    .offset(vm.w*0.4, -vm.h*0.45)
    .opacity(shakes == 1 ? 1 : 0)
    .animation(.easeIn.delay(1), value: shakes)
  }
  
  private var firstText: some View {
    VStack(spacing: 20) {
      Text(Txt.welcome[0])
        .rouleFont(size: 17, style: .interR, color: .white)
        .xOffset(shakes == 1 ? 0 : -vm.w)
        .animation(.smooth(duration: 1), value: shakes)
      
      Text(Txt.welcome[1])
        .rouleFont(size: 17, style: .interB, color: .white)
        .opacity(shakes == 1 ? 1 : 0)
        .animation(.smooth(duration: 0.8).delay(0.5), value: shakes)
    }
    .hPadding()
    .multilineTextAlignment(.center)
    .yOffset(vm.h*0.23)
  }
  
  private var firstHeader: some View {
    Text("Breaking\n Down Roulette")
      .rouleFont(size: 50, style: .ibarraRealNovaSI, color: Color(hex: "#F3D9A5"))
      .multilineTextAlignment(.center)
      .xOffset(shakes == 1 ? 0 : -vm.w)
      .animation(.interpolatingSpring(stiffness: 30, damping: 5), value: shakes)
      .yOffset(-vm.h*0.35)
  }
  
  private var nextBtn: some View {
    Button {
      if stage == 1 {
        withAnimation(.easeIn(duration: 1)) {
          stage += 1
        }
      } else {
        vm.isWelcome = false
      }
    } label: {
      Image(.welcbtn)
        .resizableToFit(height: 54)
        .overlayMask {
          ZStack {
            LiquidMetal()
              .opacity(0.2)
          }
        }
        .overlay {
          Text("Next")
            .rouleFont(size: 17, style: .interB, color: Color(hex: "#020202"))
        }
    }
    .yOffset(vm.h*0.4)
  }
  
  private var startBtn: some View {
    Button {
        vm.isWelcome = false
    } label: {
      Image(.welcbtn)
        .resizableToFit(height: 54)
        .overlayMask {
          ZStack {
            LiquidMetal()
              .opacity(0.2)
          }
        }
        .overlay {
          Text("Start")
            .rouleFont(size: 17, style: .interB, color: Color(hex: "#020202"))
        }
    }
    .yOffset(vm.h*0.4)
  }
  
  private var nextbtnAnimator: some View {
    MyKeyframeAnimator(initialValue: ShakeData(), trigger: shakes, content: { anim in
      nextBtn
        .opacity(anim.opacity.value)
        .offset(x: anim.offset.value)
        .rotationEffect(anim.rotation)
        .saturation(anim.saturation.value)
    }, keyframes: [
      MyKeyframeTrack(\ShakeData.offset, [
        MyCubicKeyframe(AnimatableDouble(value: -vm.w), duration: 1),
       MyCubicKeyframe(AnimatableDouble(value: 30), duration: 1.5),
        MyCubicKeyframe(AnimatableDouble(value: -30), duration: 1),
        MyLinearKeyframe(AnimatableDouble(value: 0), duration: 0.5)
        ]),
        MyKeyframeTrack(\.rotation, [
            MyCubicKeyframe(Angle.degrees(30), duration: 1),
            MyCubicKeyframe(Angle.degrees(-30), duration: 1),
            MyLinearKeyframe(Angle.zero, duration: 1)
        ]),
      MyKeyframeTrack(\ShakeData.opacity, [
        MyCubicKeyframe(AnimatableDouble(value: 0.5), duration: 0.4),
        MyCubicKeyframe(AnimatableDouble(value: 0.2), duration: 0.7),
        MyCubicKeyframe(AnimatableDouble(value: 0.7), duration: 1),
        MyLinearKeyframe(AnimatableDouble(value: 1), duration: 0.5)
        ]),
      MyKeyframeTrack(\ShakeData.saturation, [
        MyCubicKeyframe(AnimatableDouble(value: 1.7), duration: 0.4),
        MyCubicKeyframe(AnimatableDouble(value: 1.2), duration: 1.7),
        MyCubicKeyframe(AnimatableDouble(value: 1.4), duration: 1),
        MyLinearKeyframe(AnimatableDouble(value: 1), duration: 0.5)
        ]),
    ])
  }
  
  
  private var nextbtnAnimator2: some View {
    MyKeyframeAnimator(initialValue: MoveData(), trigger: stage, content: { anim in
      startBtn
        .opacity(anim.opacity.value)
        .offset(x: anim.offset.value)
        .rotationEffect(anim.rotation)
    }, keyframes: [
      MyKeyframeTrack(\MoveData.offset, [
        MyCubicKeyframe(AnimatableDouble(value: vm.w), duration: 2),
        MyCubicKeyframe(AnimatableDouble(value: -30), duration: 1.5),
        MyCubicKeyframe(AnimatableDouble(value: 30), duration: 1),
        MyLinearKeyframe(AnimatableDouble(value: 0), duration: 0.5)
      ]),
      MyKeyframeTrack(\.rotation, [
        MyCubicKeyframe(Angle.degrees(-30), duration: 1),
        MyCubicKeyframe(Angle.degrees(30), duration: 1),
        MyLinearKeyframe(Angle.zero, duration: 1)
      ]),
      MyKeyframeTrack(\MoveData.opacity, [
        MyCubicKeyframe(AnimatableDouble(value: 0), duration: 0.6),
        MyCubicKeyframe(AnimatableDouble(value: 0.5), duration: 0.7),
        MyCubicKeyframe(AnimatableDouble(value: 0.7), duration: 1),
        MyLinearKeyframe(AnimatableDouble(value: 1), duration: 0.5)
      ]),
    ])
  }
  
}

#Preview {
    Welcome()
    .vm
}
