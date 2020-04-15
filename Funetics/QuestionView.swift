//
//  QuestionView.swift
//  Funetics
//
//  Created by Tanay Nistala on 3/26/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import Combine

struct QuestionView: View {
    @State var current_word: Word
    @State var time = 10
    
    @EnvironmentObject var appdata: AppData
    @State private var show_modal: Bool = false
    @State private var show_alert: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func getAnswer(option: String) {
        if option == current_word.correct {
            print("Correct")
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "correctAnswers") + 1, forKey: "correctAnswers")
            self.appdata.correct_answers += 1
            self.appdata.was_correct = true
            self.appdata.was_time_up = false
        } else if option == "time" {
            print ("Time Up")
            self.appdata.was_correct = false
            self.appdata.was_time_up = true
        } else {
            print ("Wrong")
            self.appdata.was_correct = false
            self.appdata.was_time_up = false
        }
        
        show_alert = true
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
                    .frame(height: 244)
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
                            
                            ImageView(withURL: current_word.image_url)
                            .frame(width: 144, height: 144)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
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
                                    .frame(width: 160.0, height: 160.0, alignment: .center)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(24)
                            .onTapGesture {self.getAnswer(option: "A")}
                            
                        Text(current_word.option_b)
                        .font(.system(size: 64))
                        .fontWeight(.bold)
                        .contentShape(
                            RoundedRectangle(cornerRadius: 24))
                                .frame(width: 160.0, height: 160.0, alignment: .center)
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
                                .frame(width: 160.0, height: 160.0, alignment: .center)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(24)
                        .onTapGesture {self.getAnswer(option: "C")}
                        
                        Text(current_word.option_d)
                        .font(.system(size: 64))
                        .fontWeight(.bold)
                        .contentShape(
                            RoundedRectangle(cornerRadius: 24))
                                .frame(width: 160.0, height: 160.0, alignment: .center)
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(24)
                            .onTapGesture {self.getAnswer(option: "D")}
                    }
                    .padding(.top, 4.0)
                }
                .offset(y: 64)
                .padding(.bottom)
                .alert(isPresented: $show_alert) {
                    Alert(title: Text(self.appdata.was_time_up ? "Time Up!" : (self.appdata.was_correct ? "Correct!" : "Wrong")), message: Text(self.appdata.was_correct ? "Great Job!" : "It was \(current_word.word)"), dismissButton: .default(Text("OK")) {
                        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "questionNum") + 1, forKey: "questionNum")
                        self.appdata.current_question += 1
                        self.appdata.show_question.toggle()
                    })
                }
                
    //            TextField("Enter Answer Here", text: $answer) {
    //                UIApplication.shared.keyWindow?.endEditing(true)
    //            }
    //            .textFieldStyle(RoundedBorderTextFieldStyle())
    //            .padding()
                
//                RoundedRectangle(cornerRadius: 24)
//                    .frame(width: 300, height: 32)
//
                //           ()         .foregroundColor(Color("Background"))
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
                                
                                if self.time == 0 {
                                    self.getAnswer(option: "time")
                                }
                            }
                    )
                    .offset(y: 32)
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
