//
//  ContentView.swift
//  swiftUIAPICalls
//
//  Created by lichunfei on 2021/8/1.
//

import SwiftUI

struct  URLImage : View{
    let urlString:String
    @State var data:Data?
    
    var body: some View{
        if let data = data,let uiimage  = UIImage(data: data){
            Image(uiImage: uiimage)
                .resizable()
                .frame(width: 130, height: 70)
                .background(Color.gray)
                
        }else{
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
        }
    }
    private func  fetchData(){
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.courses, id:\.self){ course in
                    HStack{
                        URLImage(urlString: course.image)
                            .frame(width: 130, height: 70)
                            .background(Color.gray)
                        Text(course.name)
                            .bold()
                    }
                    .padding(3)
                    
                    
                }
            }
            .navigationTitle("首页")
            .onAppear{
                viewModel.fetch()
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
