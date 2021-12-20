//
//  ShowDrawingView.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2021/12/17.
//  Copyright © 2021 tkt989. All rights reserved.
//

import SwiftUI

struct ShowDrawingView: View {
    var dismiss: (() -> Void)?
    
    @Binding var image: UIImage?
    
    var body: some View {
        Color.white
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(Settings.shared.isReverseShow ? 180.0 : 0.0))
                        .frame(maxHeight: .infinity)
                    
                    Button("戻る", action: {
                        dismiss!()
                    })
                        .padding()
                }
            )
    }
    
    static func uiHostingController(image: UIImage?) -> UIHostingController<ShowDrawingView> {
        let view = ShowDrawingView(image: .constant(image))
        let vc = UIHostingController(rootView: view)
        vc.rootView.dismiss = { vc.dismiss(animated: true, completion: nil) }
        return vc
    }
}

struct ShowDrawingView_Previews: PreviewProvider {
    @State static var image: UIImage? = UIImage(systemName: "multiply.circle.fill")
    
    static var previews: some View {
        ShowDrawingView(image: $image)
    }
}
