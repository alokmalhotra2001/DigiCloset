//  ToDonate.swift
//  Fashion-App
//
//  Created by Aarzu Gupta on 4/5/23.
//

import SwiftUI

struct ToDonate: View {
    
    var body: some View {
      
      NavigationView{
        
        VStack{
          ScrollView{
            Text("Finalize Clothes to Donate").font(.title).frame(alignment: .top).padding(.top, 30)
            
            
            
            NavigationLink(destination: ContentView()) {
              Text("Find Donation Centers Near Me")
            }
            
  //          Button("Find Donation Centers Near Me") {
  //            NavigationLink(<#LocalizedStringKey#>, destination: ContentView())
  //          }.padding().background(Color(.black)).foregroundColor(.white).clipShape(Capsule()).frame(maxHeight: 200)
  //            .frame(maxWidth: 200).frame(alignment: .bottom)
          }
        }
        
      }

    }
}

struct ToDonate_Previews: PreviewProvider {
    static var previews: some View {
        ToDonate()
    }
}
