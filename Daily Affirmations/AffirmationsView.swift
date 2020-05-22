//
//  AffirmationsView.swift
//  Daily Affirmations
//
//  Created by Samuel Agyakwa on 5/21/20.
//  Copyright © 2020 Samuel Agyakwa. All rights reserved.
//

import SwiftUI

struct AffirmationsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: AffirmationItem.getAllAffirmations()) var affirmationItems: FetchedResults<AffirmationItem>
    @State private var newAffirmationItem = ""
    
    
    var body: some View {
        GeometryReader{ (proxy: GeometryProxy) in
            // Whole screen
            VStack(alignment: .leading, spacing: 5) {
                // Title HStack
                HStack(alignment: .center){
                    Text("Affirmations")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .font(.largeTitle)
                    
                    Spacer()
                }
                .padding()
                
                // Heading and textbox HStack
                VStack(alignment: .leading) {
                    Section(header: Text("Add Affirmations").font(.headline)) {
                        
                        // HStack for Text Field and Actions
                        HStack {
                            TextField("Type New Affirmation", text:self.$newAffirmationItem)

                            Spacer()

                            ZStack{
                                Button(action: {
                                    if !self.newAffirmationItem.isEmpty{
                                        let affirmationItem = AffirmationItem(context: self.managedObjectContext)

                                        // Put info in managedObjectCOntext
                                        affirmationItem.affirmationText = self.newAffirmationItem
                                        affirmationItem.createdAt = Date()


                                        // Save info
                                        do{
                                            try self.managedObjectContext.save()
                                        } catch { // TODO: Catch actual errors later
                                            print(error)
                                        }
                                    }


                                    // clean
                                    self.newAffirmationItem = ""

                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .imageScale(.large)
                                        .foregroundColor(.green)
                                }
                            }
                        }  // End Text field
                    }
                    
                }
                .padding()
                
                // List View
                NavigationView{
                    List {
                        Section(header: Text("Saved Affirmations")){
                             ForEach(self.affirmationItems){ affirmationItem in
                                ZStack {
                                    HStack (alignment: .top){
                                        VStack(alignment: .leading) {

                                            HStack(alignment: .top) {
                                               Spacer()
                                               Button(action: {}){
                                                   Image(systemName: "list.bullet")
                                               }
                                               .onTapGesture {
                                                print("Test")
                                               }
                                               .contextMenu {
                                                   ZStack {
                                                       VStack{
                                                           Button(action: {}){
                                                               HStack{
                                                                   Text("Edit")

                                                                   Image(systemName: "text.cursor")
                                                               }
                                                           }

                                                           Button(action: {}){
                                                               HStack{
                                                                   Text("Delete")
                                                                   Image(systemName: "trash")
                                                                               }
                                                           }
                                                       }
                                                   }
                                                }
                                           .buttonStyle(PlainButtonStyle())
                                           .padding(5)
                                           }
                                               Spacer()

                                            Text(affirmationItem.affirmationText!)
                                                   .font(.title)
                                                   .foregroundColor(Color.white)
                                                   .multilineTextAlignment(.leading)
                                                   .padding(.bottom, 80)
                                            }
                                        }
                                    }
                                    .frame(width: proxy.size.width, height: 140)
                                    .fixedSize(horizontal: true, vertical: true)
                                    .background(RoundedCorners(color: Color.systemIndigo, topLeft: 40, topRight: 40, bottomLeft: 40, bottomRight: 0))
                                    .shadow(color: self.colorScheme == .dark ? Color.darkEnd: Color.black.opacity(0.5), radius: 10, x: -5, y: -5)
                                    .shadow(color: self.colorScheme == .dark ? Color.darkEnd : Color.white.opacity(0.5), radius: 10, x: -5, y: -5)
                            }
                            .onDelete{ indexSet in
                                let deleteItem = self.affirmationItems[indexSet.first!]
                                self.managedObjectContext.delete(deleteItem)

                                // Save
                                do {
                                    try self.managedObjectContext.save()
                                }catch {
                                    print(error)
                                }

                            }
                        }
                    }
                    .listSeparatorStyleNone()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarItems(trailing: EditButton()).frame(width: proxy.size.width)
                }
                
//                .onTapGesture {
//                    UIApplication.shared.endEditing()
//                }
            } // TODO: tapping to dismiss keyboard disables tapping to delet (after swiping to delete)
            .gesture(TapGesture().onEnded{_ in UIApplication.shared.endEditing()})
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

extension Color {
    static let systemIndigo = Color(UIColor.systemIndigo)
    
    static let systemBlue = Color(UIColor.systemBlue)
    
    static let systemRed = Color(UIColor.systemRed)
   
    
    static let systemPink = Color(UIColor.systemPink)
    
    static let systemTeal = Color(UIColor.systemTeal)
    
    static let darkEnd = Color(red: 30 / 255, green: 30 / 255, blue: 35 / 255)
}

// extension for keyboard to dismiss
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

public struct ListSeparatorStyleNoneModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content.onAppear {
            UITableView.appearance().separatorStyle = .none
        }.onDisappear {
            UITableView.appearance().separatorStyle = .singleLine
        }
    }
}

extension View {
    public func listSeparatorStyleNone() -> some View {
        modifier(ListSeparatorStyleNoneModifier())
    }
}

struct AffirmationsView_Previews: PreviewProvider {
    static var previews: some View {
        AffirmationsView()
    }
}


//{ (proxy: GeometryProxy) in
//            NavigationView {
//                List {
//                    Section(header: Text("Add Affirmations")){
//                        HStack {
//                            TextField("Type New Affirmation", text:self.$newAffirmationItem)
//
//                            Spacer()
//
//                            ZStack{
//                                Button(action: {
//                                    if !self.newAffirmationItem.isEmpty{
//                                        let affirmationItem = AffirmationItem(context: self.managedObjectContext)
//
//                                        // Put info in managedObjectCOntext
//                                        affirmationItem.affirmationText = self.newAffirmationItem
//                                        affirmationItem.createdAt = Date()
//
//
//                                        // Save info
//                                        do{
//                                            try self.managedObjectContext.save()
//                                        } catch { // TODO: Catch actual errors later
//                                            print(error)
//                                        }
//                                    }
//
//
//                                    // clean
//                                    self.newAffirmationItem = ""
//
//                                }) {
//                                    Image(systemName: "plus.circle.fill")
//                                        .imageScale(.large)
//                                        .foregroundColor(.green)
//                                }
//                            }
//                        }
//                    }.font(.headline)
//
//
//                    Section(header: Text("Saved Affirmations")){
//                        ForEach(self.affirmationItems){ affirmationItem in
//                            ZStack {
//                                HStack (alignment: .top){
//                                    VStack(alignment: .leading) {
//
//                                        HStack(alignment: .top) {
//                                           Spacer()
//                                           Button(action: {}){
//                                               Image(systemName: "list.bullet")
//                                           }
//                                           .onTapGesture {
//                                            print("Test")
//                                           }
//                                           .contextMenu {
//                                               ZStack {
//                                                   VStack{
//                                                       Button(action: {}){
//                                                           HStack{
//                                                               Text("Edit")
//
//                                                               Image(systemName: "text.cursor")
//                                                           }
//                                                       }
//
//                                                       Button(action: {}){
//                                                           HStack{
//                                                               Text("Delete")
//                                                               Image(systemName: "trash")
//                                                                           }
//                                                       }
//                                                   }
//                                               }
//                                            }
//                                       .buttonStyle(PlainButtonStyle())
//                                       .padding(5)
//                                       }
//                                           Spacer()
//
//                                        Text(affirmationItem.affirmationText!)
//                                               .font(.title)
//                                               .foregroundColor(Color.white)
//                                               .multilineTextAlignment(.leading)
//                                               .padding(.bottom, 80)
//                                        }
//                                    }
//                                }
//                                .frame(width: proxy.size.width, height: 140)
//                                .fixedSize(horizontal: true, vertical: true)
//                                .background(RoundedCorners(color: Color.systemIndigo, topLeft: 40, topRight: 40, bottomLeft: 40, bottomRight: 0))
//                                .shadow(color: self.colorScheme == .dark ? Color.darkEnd: Color.black.opacity(0.5), radius: 10, x: -5, y: -5)
//                                .shadow(color: self.colorScheme == .dark ? Color.darkEnd : Color.white.opacity(0.5), radius: 10, x: -5, y: -5)
//                        }
//                        .onDelete{ indexSet in
//                            let deleteItem = self.affirmationItems[indexSet.first!]
//                            self.managedObjectContext.delete(deleteItem)
//
//                            // Save
//                            do {
//                                try self.managedObjectContext.save()
//                            }catch {
//                                print(error)
//                            }
//
//                        }
//                    }
//                }
////                .padding()
//                .listSeparatorStyleNone()
//                .frame(width: proxy.size.width)
//                .navigationBarTitle(Text("Affirmations"))
//                .navigationBarItems(trailing: EditButton())
//            }
//            .frame(width: proxy.size.width)
//        }
