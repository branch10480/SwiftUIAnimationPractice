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

struct MainView: View {
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
        .animation(.spring(), value: showDetail) // これより前に .animation(nil があるからこの行は適用されない
        .scaleEffect(showDetail ? 1.5 : 1)
        .animation(.spring(), value: showDetail)
    }
  }
}
