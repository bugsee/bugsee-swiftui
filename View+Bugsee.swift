/// View+Bugsee.swift
///
/// Created by Denis Sheikherev on 08.12.2021.
///
/// The MIT License (MIT)
///
/// Copyright (c) 2021 Bugsee
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
///

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
