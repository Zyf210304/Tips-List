//
//  ContentView.swift
//  Tips List
//
//  Created by 张亚飞 on 2021/2/5.
//

import SwiftUI

struct ContentView: View {
    
    @State var edit = false
    @EnvironmentObject var obs : observer
    @State var selected : type = .init(id: "", title: "", msg: "", time: "", day: "")
    
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
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    VStack(spacing: 10, content: {
                        
                        ForEach(self.obs.datas) { item in
                            
                            cellView(edit: edit, data: selected)
                                .onTapGesture {
                                    
                                    self.selected = item
                                }
                        }
                    })
                    .foregroundColor(.white)
                })
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

struct cellView : View {
    
    var edit : Bool
    var data : type
    var body: some View {
        
        HStack {
            
            if edit {
                
                Button(action: {}, label: {
                    
                    Image(systemName: "minus.circle")
                        .font(.title)
                        .foregroundColor(Color.red)
                })
            }
            
            Text(data.title).lineLimit(1)
            
            Spacer()
            
            VStack(spacing: 5) {
                
                Text(data.day).lineLimit(1)
                Text(data.time).lineLimit(1)
            }
        }
    }
}


struct type : Identifiable {
    
    var id : String
    var title : String
    var msg : String
    var time : String
    var day : String
}


class observer: ObservableObject {
    
    @Published var datas = [type]()
    
}
