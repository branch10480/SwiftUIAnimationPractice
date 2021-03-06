//
//  ContentView.swift
//  SwiftUIAnimationPractice
//
//  Created by branch10480 on 2021/11/13.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    MainView(showDetail: false)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension AnyTransition {
  static var moveAndFade: AnyTransition {
    let insertion = AnyTransition.move(edge: .top).combined(with: .opacity)
    let removal = AnyTransition.scale.combined(with: .opacity)
    // .asymmetric を使って表示時、非表示時のアニメーションを別々にできる
    return .asymmetric(insertion: insertion, removal: removal)
  }
}

struct MainView: View {
  @State var showDetail: Bool
  
  var body: some View {
    Button(action: {
      withAnimation(.spring()) {
        showDetail.toggle()
      }
    }) {
      VStack {
        Image(systemName: "chevron.right.circle").font(.system(size: 50))
          .rotationEffect(.degrees(showDetail ? 90 : 0))
        
        if showDetail {
          // .transition はViewの表示・非表示時に動作するアニメーション
          // extension で静的定義した AnyTransition
          Text("Detail").transition(.moveAndFade)
        }
        
        Spacer()
      }
    }
  }
}

struct Step1View: View {
  @State var showDetail: Bool
  
  var body: some View {
    Button(action: {
      self.showDetail.toggle()
    }) {
      Image(systemName: "chevron.right.circle")
        .font(.system(size: 50))
        .rotationEffect(.degrees(showDetail ? 90 : 0))
      // .animation(nil...) でアニメーションをOFFにできる
        .animation(nil, value: showDetail)
        .scaleEffect(showDetail ? 1.5 : 1)
      // .speed() で元々のアニメーション速度を乗算で変化させられる
      // .speed(0.5) は速度を0.5倍することなので2倍遅くなる
        .animation(.spring().speed(0.5), value: showDetail)
    }
  }
}

struct Step2View: View {
  @State var showDetail: Bool
  
  var body: some View {
    Button(action: {
      // Stateの変更部分（.toggle()） を withAnimation でくくると、そのStateに関連するすべてのビューがアニメーションする
      // withAnimation(.spring()) { ... で .sprint() アニメーション指定ができる
      withAnimation(.spring()) {
        self.showDetail.toggle()
      }
    }) {
      Image(systemName: "chevron.right.circle")
        .font(.system(size: 50))
        .rotationEffect(.degrees(showDetail ? 90 : 0))
      // withAnimation を上書きできる（この場合、rotationEffectはアニメーションしない）
        .animation(nil, value: showDetail)
        .scaleEffect(showDetail ? 1.5 : 1)
    }
  }
}

struct Step3View: View {
  @State var showDetail: Bool
  
  var body: some View {
    Button(action: {
      withAnimation(.spring()) {
        showDetail.toggle()
      }
    }) {
      VStack {
        Image(systemName: "chevron.right.circle").font(.system(size: 50))
          .rotationEffect(.degrees(showDetail ? 90 : 0))
        
        if showDetail {
          // .transition はViewの表示・非表示時に動作するアニメーション
          Text("Detail").transition(
            // AnyTransitionから初めて .move .combined で transition を組み合わせる
            AnyTransition.move(edge: .top).combined(with: .opacity)
          )
        }
        
        Spacer()
      }
    }
  }
}
