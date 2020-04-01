//
//  ImageView.swift
//  Funetics
//
//  Created by Tanay Nistala on 4/1/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import Combine

struct ImageView: View {
     @ObservedObject var imageLoader:ImageLoader
       @State var image:UIImage = UIImage()

       init(withURL url:String) {
           imageLoader = ImageLoader(urlString:url)
       }

       var body: some View {
               Image(uiImage: image)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width:196, height:196)
                   .onReceive(imageLoader.didChange) { data in
                   self.image = UIImage(data: data) ?? UIImage()
                   }
       }
}

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: "https://i.postimg.cc/QCkp9f3k/Image-2.png")
    }
}
