//
//  QuestionView.swift
//  Funetics
//
//  Created by Tanay Nistala on 3/26/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import Combine
import AVFoundation

struct QuestionView: View {
    @State var current_word: Word
    @State var time = 10
    
    @State var sound: AVAudioPlayer!
    
    @EnvironmentObject var appdata: AppData
    @State private var show_modal: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func getAnswer(option: String) {
        if option == current_word.correct {
            print("Correct")
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "correctAnswers") + 1, forKey: "correctAnswers")
            self.appdata.correct_answers += 1
            self.appdata.was_correct = true
        } else {
            print ("Wrong")
            self.appdata.was_correct = false
        }
        
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "questionNum") + 1, forKey: "questionNum")
        self.appdata.current_question += 1
        self.appdata.show_question = false
        return
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("Background"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Rectangle()
                    .frame(height: 224)
                    .foregroundColor(Color("Background"))
                    .shadow(color: Color("Dark Shadow"), radius: 8, x: 0, y: 8)
                    .padding(.bottom)
                    .overlay(
                        VStack {
                            Text("Question \(String(current_word.id))")
                                .fontWeight(.bold)
                                .foregroundColor(Color("Foreground"))
                                .font(.system(size: 24))
                            Text(current_word.question)
                                .fontWeight(.bold)
                                .foregroundColor(Color("Foreground"))
                                .font(.system(size: 48))
                            Button(action: {
                                let path = Bundle.main.path(forResource: "audio", ofType:"mp3")!
                                let url = URL(fileURLWithPath: path)

                                do {
                                    print("Sound Playing")
                                    self.sound = try AVAudioPlayer(contentsOf: url)
                                    self.sound?.play()
                                } catch {
                                    // couldn't load file :(
                                }}) {
                                Text("Hello")
                            }
                            .overlay(
                            Circle().stroke(Color.white, lineWidth: 0))
                                .shadow(radius: 10)
                                .offset(y: -16)

                        }
                        .offset(y: 64)
                    )
                    .edgesIgnoringSafeArea(.top)
                
//                Options(option_a: current_word.option_a, option_b: current_word.option_b, option_c: current_word.option_c, option_d: current_word.option_d)
                
                VStack {
                    HStack {
                        
                        Text(current_word.option_a)
                            .font(.system(size: 64))
                            .fontWeight(.bold)
                            .contentShape(
                                RoundedRectangle(cornerRadius: 24))
                                    .frame(width: 192.0, height: 192.0, alignment: .center)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(24)
                            .onTapGesture {self.getAnswer(option: "A")}
                            
                        Text(current_word.option_b)
                        .font(.system(size: 64))
                        .fontWeight(.bold)
                        .contentShape(
                            RoundedRectangle(cornerRadius: 24))
                                .frame(width: 192.0, height: 192.0, alignment: .center)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(24)
                            .onTapGesture {self.getAnswer(option: "B")}
                    }
                    .padding(.bottom, 4.0)
                    
                    HStack {
                        Text(current_word.option_c)
                        .font(.system(size: 64))
                        .fontWeight(.bold)
                        .contentShape(
                            RoundedRectangle(cornerRadius: 24))
                                .frame(width: 192.0, height: 192.0, alignment: .center)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(24)
                        .onTapGesture {self.getAnswer(option: "C")}
                        
                        Text(current_word.option_d)
                        .font(.system(size: 64))
                        .fontWeight(.bold)
                        .contentShape(
                            RoundedRectangle(cornerRadius: 24))
                                .frame(width: 192.0, height: 192.0, alignment: .center)
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(24)
                            .onTapGesture {self.getAnswer(option: "D")}
                    }
                    .padding(.top, 4.0)
                }
                .offset(y: 48)
                .padding(.bottom)
                
    //            TextField("Enter Answer Here", text: $answer) {
    //                UIApplication.shared.keyWindow?.endEditing(true)
    //            }
    //            .textFieldStyle(RoundedBorderTextFieldStyle())
    //            .padding()
                
//                RoundedRectangle(cornerRadius: 24)
//                    .frame(width: 300, height: 32)
//
//                    .foregroundColor(Color("Background"))
//                    .shadow(color: Color("Light Shadow"), radius: 8, x: -8, y: -8)
//                    .shadow(color: Color("Dark Shadow"), radius: 8, x: 0, y: 8)
//                    .overlay(
//                    Button(action: {self.show_modal = true}) {
//                        Image(systemName: "book.fill")
//                        Text("Syllable Dictionary")
//                    }
//                        .foregroundColor(Color("Foreground"))
//                        .sheet(isPresented: self.$show_modal) {ModalView()}
//                        )
//                    .padding(.vertical, 24.0)
                
                Rectangle()
                    .fill(Color("Background"))
                    .frame(height:64)
                    .shadow(color: Color("Light Shadow"), radius: 8, x: 0, y: -8)
                    .overlay(
                        Text("\(time)")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Foreground"))
                            .font(.title)
                            .onReceive(timer) { _ in
                                if self.time > 0 {
                                    self.time -= 1
                                }
                            }
                    )
            }
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Dismiss")
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .frame(height: 32)
                .cornerRadius(16)
                
                SyllableList()
            }
        .navigationBarTitle("Syllable Dictionary")
        }
    }
}
