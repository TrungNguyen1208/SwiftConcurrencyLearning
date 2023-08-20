//
//  TaskBootcamp.swift
//  SwiftConcurrencyLearning
//
//  Created by Trung Nguyen on 20/08/2023.
//

import SwiftUI

final class TaskBootcampViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  @Published var image2: UIImage? = nil
  
  @MainActor
  func fetchImage() async {
    let url = URL(string: "https://picsum.photos/200")!
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      self.image = UIImage(data: data)
    } catch {
      print(error.localizedDescription)
    }
    
//    for x in array {
//      // work
//      try Task.checkCancellation()
//    }
  }
  
  @MainActor
  func fetchImage2() async {
    let url = URL(string: "https://picsum.photos/1000")!
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      self.image2 = UIImage(data: data)
    } catch {
      print(error.localizedDescription)
    }
  }
}

struct TaskBootcamp: View {
  
  @StateObject private var vm = TaskBootcampViewModel()
  @State private var fetchImageTask: Task<(), Never>? = nil
  
  var body: some View {
    VStack(spacing: 40) {
      if let image = vm.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200)
      }
      if let image = vm.image2 {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200)
      }
    }
    .task {
      await vm.fetchImage()
    }
    .onDisappear {
      fetchImageTask?.cancel()
    }
//    .onAppear {
//      fetchImageTask = Task {
//        await vm.fetchImage()
//      }
//      Task {
//        await vm.fetchImage2()
//      }
//    }
  }
}

struct TaskBootcamp_Previews: PreviewProvider {
  static var previews: some View {
    TaskBootcamp()
  }
}
