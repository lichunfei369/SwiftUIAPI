//
//  ViewModel.swift
//  swiftUIAPICalls
//
//  Created by lichunfei on 2021/8/1.
//

import Foundation
import SwiftUI

struct Home:Hashable,Codable {
    let name:String
    let image:String
}

class ViewModel: ObservableObject {
    @Published var courses:[Home] = []
    func fetch(){
        guard let url = URL(string:"https://iosacademy.io/api/v1/courses/index.php") else{
            
            return
        }
        let task = URLSession.shared.dataTask(with: url){ [weak self]
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let home = try JSONDecoder().decode([Home].self, from: data)
                DispatchQueue.main.async {
                    self?.courses = home
                }
            }
            catch{
                print(error)
            }
        }
        
        task.resume()
    }
   
  
}

