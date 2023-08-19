//
//  DownloadImageAsync.swift
//  SwiftConcurrencyLearning
//
//  Created by Trung Nguyen on 16/08/2023.
//

import SwiftUI

struct DownloadImageAsync: View {
  
  @StateObject private var vm = DownloadImageAsyncViewModel()
  
  var body: some View {
    ZStack {
      if let image = vm.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200)
          .cornerRadius(16)
      }
    }
    .onAppear {
      Task {
        await vm.fetchImage()
      }
    }
  }
}

struct DownloadImageAsync_Previews: PreviewProvider {
  static var previews: some View {
    DownloadImageAsync()
  }
}
