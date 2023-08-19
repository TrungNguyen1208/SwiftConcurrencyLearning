//
//  DoCatchTryThrowsBootcamp.swift
//  SwiftConcurrencyLearning
//
//  Created by Trung Nguyen on 15/08/2023.
//

import SwiftUI

final class DoCatchTryThrowsBootcampDataManager {
    
    let isActive: Bool = true
    
    func getTitle() -> String {
        return "New text"
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("New text")
        } else {
            return .failure(URLError(.badURL))
        }
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "New text"
        } else {
            throw URLError(.badServerResponse)
        }
    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "Final text"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

final class DoCatchTryThrowsBootcampViewModel: ObservableObject {
    
    @Published var text: String = "Starting text."
    let manager = DoCatchTryThrowsBootcampDataManager()
    
    func fetchTitle() {
        do {
            if let newTitle = try? manager.getTitle3() {
                self.text = newTitle
            }
            
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
        } catch {
            self.text = error.localizedDescription
        }
        
        /*
        let result = manager.getTitle2()
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }
         */
        
        /*
        let newTitle = manager.getTitle()
        self.text = newTitle
         */
    }
}

struct DoCatchTryThrowsBootcamp: View {
    
    @StateObject private var vm = DoCatchTryThrowsBootcampViewModel()
    
    var body: some View {
        Text(vm.text)
            .frame(width: 300, height: 300)
            .background(.blue)
            .onTapGesture {
                vm.fetchTitle()
            }
    }
}

struct DoCatchTryThrowsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchTryThrowsBootcamp()
    }
}
