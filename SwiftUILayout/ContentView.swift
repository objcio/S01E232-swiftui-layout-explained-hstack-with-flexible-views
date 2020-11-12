//
//  ContentView.swift
//  NotSwiftUI
//
//  Created by Chris Eidhof on 05.10.20.
//

import SwiftUI
import Cocoa

func render<V: View_>(view: V, size: CGSize) -> Data {
    return CGContext.pdf(size: size) { context in
        view
            .frame(width: size.width, height: size.height)
            ._render(context: context, size: size)
    }
}

extension View_ {
    var measured: some View_ {
        overlay(GeometryReader_ { size in
            Text_("\(Int(size.width))")
        })
    }
}

struct ContentView: View {
    let size = CGSize(width: 600, height: 400)

    
    var sample: some View_ {
        HStack_(children: [
            AnyView_(
                Rectangle_()
                    .frame(minWidth: 150, maxWidth: 250)
                    .foregroundColor(.blue)
                    .measured
            ),
            AnyView_(
                Rectangle_()
                    .frame(maxWidth: 100)
                    .foregroundColor(.red)
                    .measured
            ),
        ], alignment: .center)
        .frame(width: width.rounded(), height: 100)
        
    }
    


    @State var opacity: Double = 0.5
    @State var width: CGFloat  = 300
//    @State var minWidth: (CGFloat, enabled: Bool)  = (100, true)
//    @State var maxWidth: (CGFloat, enabled: Bool)  = (400, true)

    var body: some View {
        VStack {
            ZStack {
                Image(nsImage: NSImage(data: render(view: sample, size: size))!)
                    .opacity(1-opacity)
                sample.swiftUI.frame(width: size.width, height: size.height)
                    .opacity(opacity)
            }
            Slider(value: $opacity, in: 0...1)
                .padding()
            HStack {
                Text("Width \(width.rounded())")
                Slider(value: $width, in: 0...600)
            }.padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 1080/2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
