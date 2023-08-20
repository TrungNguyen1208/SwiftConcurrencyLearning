//
//  AsyncAwaitBootcampViewModel.swift
//  SwiftConcurrencyLearning
//
//  Created by Trung Nguyen on 20/08/2023.
//

import Foundation

final class AsyncAwaitBootcampViewModel: ObservableObject {
  @Published var dataArray: [String] = []
  
  func addTitle1() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.dataArray.append("Title1: \(Thread.current)")
    }
  }
  
  func addTitle2() {
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
      let title = "Title2: \(Thread.current)"
      DispatchQueue.main.async {
        self.dataArray.append(title)
        
        let title3 = "Title3: \(Thread.current)"
        self.dataArray.append(title3)
      }
    }
  }
  
  func addAuthor1() async {
    let author1 = "Author1: \(Thread.current)"
    self.dataArray.append(author1)
    
    try? await Task.sleep(seconds: 3.75)
  }
}

public extension Task where Success == Never, Failure == Never {
  static func sleep(seconds: Double) async throws {
    let nanoseconds = UInt64(seconds * Double(NSEC_PER_SEC))
    try await Task.sleep(nanoseconds: nanoseconds)
  }
}
