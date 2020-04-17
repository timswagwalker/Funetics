//
//  ContentView.swift
//  Funetics
//
//  Created by Tanay Nistala on 3/26/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var appdata: AppData
    let defaults = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color("Background"))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Group {
                        Image("Logo")
                            .resizable()
                            .frame(width: 96, height: 96)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .rotationEffect(.degrees(-15))
                        Text("Funetics")
                            .font(Font.custom("OpenDyslexic-Bold", size: 48))
                            .edgesIgnoringSafeArea(.bottom)
                    }
                    
                    RoundedRectangle(cornerRadius: 24)
                            .frame(width: 300, height: 64)
                            .foregroundColor(Color("Background"))
                            .shadow(color: Color("Light Shadow"), radius: 8, x: -8, y: -8)
                            .shadow(color: Color("Dark Shadow"), radius: 8, x: 8, y: 8)
                            .overlay(
                                Button(action: {
//                                    UserDefaults.standard.set(0, forKey: "questionNum")
//                                    UserDefaults.standard.set(0, forKey: "correctAnswers")
                                    if self.appdata.current_question < self.appdata.words.count {
                                    self.appdata.show_question = true
                                    }
                                }) {
                                VStack(alignment: .leading) {
                                Text("Next Question")
                                    .font(.headline)
                                    .foregroundColor(self.appdata.current_question < self.appdata.words.count ? Color("Foreground") : .gray)
                                Text("Question \(self.appdata.current_question + 1)")
                                    .font(.caption)
                                    .foregroundColor(self.appdata.current_question < self.appdata.words.count ? Color("Foreground") : .gray)
                                }
                                .padding()
                                Spacer()
                                Image(systemName: "chevron.right.2")
                                    .padding()
                                    .font(.title)
                                    .foregroundColor(self.appdata.current_question < self.appdata.words.count ? Color("Foreground") : .gray)
                            }
                                .foregroundColor(Color("Foreground"))
                                .sheet(isPresented: self.$appdata.show_question) {QuestionView(current_word: self.appdata.words[self.appdata.current_question])
                                .environmentObject(self.appdata)}
                                )
                            .padding(.vertical)
                    
                    Text(self.appdata.current_question == self.appdata.words.count ? "No more questions for today." : "")
                        .foregroundColor(.red)
                    
                    // NOTE TO SELF: make this an alert with the correct answer if wrong
                    
                    HStack {
                        Image(systemName: self.appdata.current_question == self.appdata.start_question ? "" : (self.appdata.was_correct ? "checkmark" : "xmark"))
                            .foregroundColor(self.appdata.was_correct ? .green : .red)
                            .font(Font.system(.title).bold())
                        Text(self.appdata.current_question == self.appdata.start_question ? "" : (self.appdata.was_correct ? "Correct!" : "Wrong"))
                            .font(Font.custom("OpenDyslexic-Bold", size: 24))
                            .foregroundColor(self.appdata.was_correct ? .green : .red)
                            .bold()
                    }
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Image(systemName: "chart.pie")
                                .font(.title)
                            Text("Stats")
                                .font(Font.custom("OpenDyslexic-Bold", size: 32))
                        }
                        
                        RoundedRectangle(cornerRadius: 24)
                        .frame(width: 336, height: 48)
                        .foregroundColor(Color("Background"))
                        .shadow(color: Color("Light Shadow"), radius: 8, x: -8, y: -8)
                        .shadow(color: Color("Dark Shadow"), radius: 8, x: 8, y: 8)
                            .padding(.vertical, 8.0)
                        .overlay(
                            HStack {
                                Text("Questions Attempted")
                                    .padding()
                                Spacer()
                                Text("\(self.appdata.current_question)")
                                    .padding()
                            }
                        )
                        
                        RoundedRectangle(cornerRadius: 24)
                        .frame(width: 336, height: 96)
                        .foregroundColor(Color("Background"))
                        .shadow(color: Color("Light Shadow"), radius: 8, x: -8, y: -8)
                        .shadow(color: Color("Dark Shadow"), radius: 8, x: 8, y: 8)
                        .padding(.vertical, 8.0)
                        .overlay(
                            VStack {
                                HStack {
                                    HStack {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                        Text("Right")
                                    }
                                    .padding([.top, .leading, .trailing])
                                    .padding(.bottom, 4.0)
                                    Spacer()
                                    Text("\(self.appdata.correct_answers)")
                                        .padding([.top, .leading, .trailing])
                                        .padding(.bottom, 4.0)
                                }
                                Divider()
                                HStack {
                                    HStack {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.red)
                                        Text("Wrong")
                                    }
                                    .padding([.leading, .bottom, .trailing])
                                    .padding(.top, 4.0)
                                    Spacer()
                                    Text("\(self.appdata.current_question - self.appdata.correct_answers)")
                                        .padding([.leading, .bottom, .trailing])
                                        .padding(.top, 4.0)
                                }
                            }
                        )
                    
                        Spacer()
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 128, height: 32)
                            .foregroundColor(Color("Background"))
                            .shadow(color: Color("Light Shadow"), radius: 8, x: -4, y: -4)
                            .shadow(color: Color("Dark Shadow"), radius: 8, x: 4, y: 4)
                            .overlay(
                                Button(action: {
                                    UserDefaults.standard.set(0, forKey: "questionNum")
                                    UserDefaults.standard.set(0, forKey: "correctAnswers")
                                }) {
                                    Text("Reset Stats")
                                        .foregroundColor(Color.red)
                                        .bold()
                                }
                        )
                        
                        Text("This action cannot be undone.")
                            .foregroundColor(Color.red)
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "c.circle")
                            .font(.caption)
                        Text("Tanay Nistala")
                            .font(.caption)
                    }
                }
                .offset(y: -16)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppData())
    }
}

//func load<T: Decodable>(_ filename: String) -> T {
//    let data: Data
//
//    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
//        else {
//            fatalError("Couldn't find \(filename) in main bundle.")
//    }
//
//    do {
//        data = try Data(contentsOf: file)
//    } catch {
//        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//    }
//
//    do {
//        let decoder = JSONDecoder()
//        return try decoder.decode(T.self, from: data)
//    } catch {
//        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//    }
//}

class AppData: ObservableObject {
    let defaults = UserDefaults.standard
    
    @Published var start_question = 0
    @Published var current_question = 0
    @Published var show_question = false
    @Published var was_correct = false
    @Published var was_time_up = false
    @Published var correct_answers = 0
    @Published var words = [Word]()
    
    init(){
        load()
        
        self.start_question = self.defaults.integer(forKey: "questionNum")
        self.current_question = self.defaults.integer(forKey: "questionNum")
        self.correct_answers = self.defaults.integer(forKey: "correctAnswers")
    }
    
    func load() {
        let url = URL(string: "https://raw.githubusercontent.com/timswagwalker/Funetics/master/Funetics/Words.json?token=AF6VHSWYIFDWTY2XK2S5TL26QNSAU")!
    
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode([Word].self, from: d)
                    DispatchQueue.main.async {
                        self.words = decodedLists
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
            
        }.resume()
         
    }
}

struct Word: Decodable, Identifiable {
    public var id: Int
    public var word: String
    public var question: String
    public var option_a: String
    public var option_b: String
    public var option_c: String
    public var option_d: String
    public var correct: String
    public var image_url: String
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case word = "word"
            case question = "question"
            case option_a = "option_a"
            case option_b = "option_b"
            case option_c = "option_c"
            case option_d = "option_d"
            case correct = "correct_option"
            case image_url = "image_url"
        }
}
