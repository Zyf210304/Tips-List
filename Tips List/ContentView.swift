//
//  ContentView.swift
//  Tips List
//
//  Created by 张亚飞 on 2021/2/5.
//

import SwiftUI

struct ContentView: View {
    
    @State var edit = false
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.bottom)
            
            VStack (spacing: 5){
                
                VStack {
                    
                    HStack {
                        
                        Text("ToDo").font(.largeTitle).fontWeight(.heavy)
                        
                        Spacer()
                        
                        Button(action: { self.edit.toggle() }, label: {
                            Text(self.edit ? "Done" : "Edit")
                        })
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: "plus").font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red.clipShape(Circle()))
                    })
                    .padding(.bottom, -25)
                    .offset(y : 5)
                }
                .background(Rounded().fill(Color.white))
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Rounded : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 24, height: 25))
        
        return Path(path.cgPath)
    }
}
