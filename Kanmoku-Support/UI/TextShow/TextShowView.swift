//
//  TextShowView.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2021/12/18.
//  Copyright © 2021 tkt989. All rights reserved.
//

import SwiftUI

struct TextShowView: View {
    var dismiss: (() -> Void)?
    
    @Binding var text: String
    @State private var textShowSize: CGFloat = Settings.shared.textShowSize
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                    Text(text)
                        .font(.system(size: textShowSize))
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                    .frame(minHeight: geometry.size.height)
                }
                .rotationEffect(.degrees(Settings.shared.isReverseShow ? 180.0 : 0.0))
            }
            bottomView
        }
    }
    
    var bottomView: some View {
        HStack {
            Button("小さく", action: { zoomOut() })
            Spacer()
            Button("戻る", action: { dismiss!() })
            Spacer()
            Button("大きく", action: { zoomIn() })
        }.padding()
    }
    
    private func zoomIn() {
        textShowSize = Settings.shared.textShowSize * 1.2
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            Settings.shared.textShowSize = textShowSize
        }
    }
    
    private func zoomOut() {
        textShowSize = Settings.shared.textShowSize / 1.2
        if textShowSize < 10.0 {
            textShowSize = 10.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            Settings.shared.textShowSize = textShowSize
        }
    }
    
    static func uiHostingController(text: String) -> UIHostingController<TextShowView> {
        let vc = UIHostingController(rootView: TextShowView(text: .constant(text)))
        vc.rootView.dismiss = { vc.dismiss(animated: true, completion: nil)}
        return vc
    }
}

struct TextShowView_Previews: PreviewProvider {
    static var previews: some View {
        TextShowView(text: .constant("Preview"))
    }
}
