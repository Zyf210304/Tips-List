//
//  ContentView.swift
//  Tips List
//
//  Created by 张亚飞 on 2021/2/5.
//

import SwiftUI

struct ContentView: View {
    
    @State var edit = false
    @State var show = false
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
                    
                    Button(action: { self.show.toggle() }, label: {
                        
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
                .sheet(isPresented: $show, content: {
                    
                    SaveView(show: $show)
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

struct SaveView  : View {
    
    @State var msg = ""
    @State var title = ""
    @Binding var show : Bool
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: 12){
                
                Spacer()
            }
            
            Button(action: { self.show.toggle() }, label: {
                
                Text("Save")
            })
            
            TextField("Title", text: $title)
            multiline(txt: $msg)
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



struct multiline : UIViewRepresentable {
    
    @Binding var txt : String
    
    func makeCoordinator() -> multiline.Coordinator {

        return multiline.Coordinator(parent1: self)
    }
    
    
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18, weight: .heavy)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent : multiline
        
        init(parent1 : multiline) {
            
            parent = parent1
        }
        
        func textViewDidChange(_ textView: UITextView) {
            
            self.parent.txt = textView.text
        }
    }
}
