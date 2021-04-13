////
////  UserSettingsScene.swift
////  Work Hard Play Hard
////
////  Created by Onell Daniyal on 2021-03-27.
////  Copyright © 2021 tm. All rights reserved.
////
//
//import Foundation
//import SpriteKit
//import UIKit
//import SwiftUI
//
//struct UserSettings: View {
//    @State private var activity: String = ""
//    @State private var timeSelection: Int = 1
//
//    let timeInterval = [5, 10, 15, 20, 25]
//    let activities = [1, 2]
//
//    var body: some View {
//        NavigationView(){
//        Form{
//            Section(header: Text("You May Adjust Your Settings Here")){
//
//            }
//            Section(header: Text("Select your preferred break time interval")){
//                Picker("Time Interval", selection: $timeSelection){
//                    ForEach(0 ..< timeInterval.count){
//                    Text("\(self.timeInterval[$0]) mins")
//                    }
//                }.pickerStyle(SegmentedPickerStyle())
//            }
//            Section(header: Text("Select your preferred break time activity")){
//                Picker("Activity", selection: $activity){
//                    Text("\(self.activities[0]). Game")
//                    Text("\(self.activities[1]). Music")
//                }.pickerStyle(SegmentedPickerStyle())
//            }
//
//                Button(action:{
//                    print("Changes Confirmed")
//                }){
//                    Text("Confirm Changes")
//                        .accentColor(Color.white)
//                        .padding()
//                        .background(Color(UIColor.darkGray))
//                        .cornerRadius(5.0)
//                        .frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
//                }
//        }//form
//        .navigationBarTitle("User Settings")
//        }//nagivationview
//    }
//}
//
//struct UserSettings_Previews: PreviewProvider {
//    static var previews: some View {
//        UserSettings().previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus")).previewDisplayName("My iphone 8")
//    }
//}
//
//
