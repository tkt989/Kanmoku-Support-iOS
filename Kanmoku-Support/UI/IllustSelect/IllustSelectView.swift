//
//  IllustSelectView.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2021/12/18.
//  Copyright © 2021 tkt989. All rights reserved.
//

import SwiftUI

struct IllustSelectView: View {
    var hostVC: UIHostingController<IllustSelectView>?
    
    @State private var images = [
        "face1",
        "face2",
        "face3",
        "face4",
        "face5",
        "face6",
        "face7",
        "face8",
        "face9",
        "illust10",
        "illust11"
    ]
    
    var body: some View {
        Color.white
            .ignoresSafeArea()
            .overlay(
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                        ForEach(images, id: \.self) { image in
                            let uiImage = UIImage(named: image)!
                            Button(action: {
                                clickImage(uiImage)
                            }) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 160, height: 160)
                                
                            }
                        }
                    }
                }
            )
    }
    
    private func clickImage(_ image: UIImage) {
        let vc = ShowDrawingView.uiHostingController(image: image)
        vc.modalPresentationStyle = .fullScreen
        hostVC?.present(vc, animated: true, completion: nil)
    }
    
    static func uiHostingController() -> UIHostingController<IllustSelectView> {
        let vc = UIHostingController(rootView: IllustSelectView())
        vc.rootView.hostVC = vc
        return vc
    }
}

struct IllustSelectView_Previews: PreviewProvider {
    static var previews: some View {
        IllustSelectView()
    }
}
