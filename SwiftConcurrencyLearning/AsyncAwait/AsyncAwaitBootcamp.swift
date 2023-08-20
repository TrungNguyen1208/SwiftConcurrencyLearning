//
//  AsyncAwaitBootcamp.swift
//  SwiftConcurrencyLearning
//
//  Created by Trung Nguyen on 20/08/2023.
//

import SwiftUI

struct AsyncAwaitBootcamp: View {
  
  @StateObject private var vm = AsyncAwaitBootcampViewModel()
  
  var body: some View {
    List {
      ForEach(vm.dataArray, id: \.self) { data in
        Text(data)
      }
    }
    .onAppear {
      vm.addTitle1()
      vm.addTitle2()
    }
  }
}

struct AsyncAwaitBootcamp_Previews: PreviewProvider {
  static var previews: some View {
    AsyncAwaitBootcamp()
  }
}
