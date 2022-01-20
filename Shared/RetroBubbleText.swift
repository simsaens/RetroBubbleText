//
//  RetroBubbleText.swift
//  RetroBubbleText
//
//  Created by Sim Saens on 20/1/22.
//

import SwiftUI
import UIKit

struct StrokeTextLabel: UIViewRepresentable {
    let text: String
    let fill: UIColor
    let stroke: UIColor
    let size: CGFloat
    let strokeWidth: CGFloat

    private func makeAttributedString() -> NSAttributedString {
        let attributedStringParagraphStyle = NSMutableParagraphStyle()
        attributedStringParagraphStyle.alignment = NSTextAlignment.center
        let attributedString = NSAttributedString(
            string: text,
            attributes:[
                NSAttributedString.Key.paragraphStyle: attributedStringParagraphStyle,
                NSAttributedString.Key.strokeWidth: strokeWidth,
                NSAttributedString.Key.foregroundColor: fill,
                NSAttributedString.Key.strokeColor: stroke,
                NSAttributedString.Key.font: UIFont.rounded(ofSize: size, weight: .heavy)
            ]
        )
        return attributedString
    }
    
    func makeUIView(context: Context) -> UILabel {
        let strokeLabel = UILabel()
        strokeLabel.attributedText = makeAttributedString()
        strokeLabel.backgroundColor = UIColor.clear
        strokeLabel.sizeToFit()
        strokeLabel.center = CGPoint.init(x: 0.0, y: 0.0)
        return strokeLabel
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = makeAttributedString()
    }
}

struct RetroBubbleText: View {
    let text: String
    let size: Double
    let style: Style
    
    enum Style {
        case large
        case small
        case tiny
        
        var outerWidth: Double {
            switch self {
            case .large: return 22
            case .small: return 14
            case .tiny: return 12
            }
        }
        
        var innerWidth: Double {
            switch self {
            case .large: return 14
            case .small: return 8
            case .tiny: return 6
            }
        }
    }
    
    var body: some View {
        ZStack {
            StrokeTextLabel(text: text, fill: .white, stroke: UIColor(named: "Yellow")!, size: size, strokeWidth: style.outerWidth)
            StrokeTextLabel(text: text, fill: .white, stroke: UIColor(named: "Background")!, size: size, strokeWidth: style.innerWidth)
            StrokeTextLabel(text: text, fill: UIColor(named: "Red")!, stroke: UIColor(named: "Background")!, size: size, strokeWidth: 0)
                .padding([.top, .bottom], 14)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct RetroBubbleText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RetroBubbleText(text: "Wizard", size: 62, style: .small)
            
            RetroBubbleText(text: "Retrogram", size: 62, style: .large)
            
            RetroBubbleText(text: "Mastermind", size: 50, style: .tiny)
        }
    }
}

extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont
        
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }
        return font
    }
}
