//
//  DetailView.swift
//  A2
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct DetailView: View {
    var animal:Animal
    @State var name = ""
    @State var age = ""
    @State var url = ""
    @State var isEditing = false
    @State var image = defaultImage
    var body: some View {
        VStack{
            if !isEditing {
                List {
                    Text("Name: \(name)")
                    Text("Age: \(age)")
                    Text("Url: \(url)")
                }
            }else {
                List{
                    TextField("Name:", text: $name)
                    TextField("Age:", text: $age)
                    TextField("Url:", text: $url)

                }
            }
            HStack {
                Button("\(isEditing ? "Confirm" : "Edit")"){
                    if(isEditing) {
                        animal.strAge = age
                        animal.strName = name
                        animal.strUrl = url
                        saveData()
                        Task {
                            image = await animal.getImage()
                        }
                    }
                    isEditing.toggle()
                }
            }
            image.scaledToFit().cornerRadius(20).shadow(radius: 20)
        }
        .navigationTitle("Animal Detail")
        .onAppear{
            name = animal.strName
            age = animal.strAge
            url = animal.strUrl
        }
        .task {
            await image = animal.getImage()
        }
    }
}
