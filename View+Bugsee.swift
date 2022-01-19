//
//  View+Bugsee.swift
//
//  Created by Denis Sheikherev on 08.12.2021.
//  Copyright © 2021 Bugsee. All rights reserved.
//

// Usage:
/*
Text(landmark.description)
    .bugseeProtect { view in
        view.bugseeProtectedView = true
    }
*/

// If your View has offsets then you should call .bugseeProtect first:
/*
CircleImage(image: landmark.image)
    .bugseeProtect { view in
        view.bugseeProtectedView = true
    }
    .offset(y: -130)
*/

#if canImport(SwiftUI)

import Foundation
import SwiftUI

@available(iOS 13.0, *)
extension View {
    public func bugseeProtect(_ completion: @escaping (UIView) -> ()) -> some View {
        bugseeOverlay(BugseeProtectedOverlayUIView(completion: completion))
    }
    
    fileprivate func bugseeOverlay<SomeView>(_ view: SomeView) -> some View where SomeView: View {
        overlay(GeometryReader{ geometry in
            view.frame(width: geometry.size.width, height: geometry.size.height)
                .allowsHitTesting(false)
        })
    }
}

@available(iOS 13.0, *)
public struct BugseeProtectedOverlayUIView: UIViewRepresentable {
    
    let completion: (UIView) -> Void
    
    public init(completion: @escaping (UIView) -> Void) {
        self.completion = completion
    }
    
    public func makeUIView(context: UIViewRepresentableContext<BugseeProtectedOverlayUIView>) -> UIView {
        let view = UIView(frame: .zero)
        return view
    }
    
    public func updateUIView(
        _ uiView: UIView,
        context: UIViewRepresentableContext<BugseeProtectedOverlayUIView>
    ) {
        DispatchQueue.main.async {
            uiView.isUserInteractionEnabled = false
            uiView.backgroundColor = .clear
            self.completion(uiView)
        }
    }
}

#endif
