import SwiftUI
import Foundation
import CoreGraphics
import CoreFoundation

struct RangedSliderView: View {
    let currentValue: Binding<ClosedRange<Int>>
    let sliderBounds: ClosedRange<Int>
    
    public init(value: Binding<ClosedRange<Int>>, bounds: ClosedRange<Int>) {
        self.currentValue = value
        self.sliderBounds = bounds
    }
    
    var body: some View {
        GeometryReader { geomentry in
            sliderView(sliderSize: geomentry.size)
        }
    }
    
        
    @ViewBuilder private func sliderView(sliderSize: CGSize) -> some View {
        let sliderViewYCenter = sliderSize.height / 2
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.gray)
                    .frame(height: 4)
                ZStack {
                    let sliderBoundDifference = sliderBounds.count
                    let stepWidthInPixel = CGFloat(sliderSize.width) / CGFloat(sliderBoundDifference)
                    
                    // Calculate Left Thumb initial position
                    let leftThumbLocation: CGFloat = currentValue.wrappedValue.lowerBound == Int(Float(sliderBounds.lowerBound))
                        ? 0
                    : CGFloat(Float(currentValue.wrappedValue.lowerBound) - Float(sliderBounds.lowerBound)) * stepWidthInPixel
                    
                    // Calculate right thumb initial position
                    let rightThumbLocation = CGFloat(currentValue.wrappedValue.upperBound) * stepWidthInPixel
                    
                    // Path between both handles
                    lineBetweenThumbs(from: .init(x: leftThumbLocation, y: sliderViewYCenter), to: .init(x: rightThumbLocation, y: sliderViewYCenter))
                    
                    // Left Thumb Handle
                    let leftThumbPoint = CGPoint(x: leftThumbLocation, y: sliderViewYCenter)
                    thumbView(position: leftThumbPoint, value: Int(Float(currentValue.wrappedValue.lowerBound)))
                        .highPriorityGesture(DragGesture().onChanged { dragValue in
                            
                            let dragLocation = dragValue.location
                            let xThumbOffset = min(max(0, dragLocation.x), sliderSize.width)
                            
                            let newValue = Float(sliderBounds.lowerBound) + Float(xThumbOffset / stepWidthInPixel)
                            
                            // Stop the range thumbs from colliding each other
                            if newValue < Float(currentValue.wrappedValue.upperBound) {
                                currentValue.wrappedValue = Int(newValue)...currentValue.wrappedValue.upperBound
                            }
                        })
                    
                    // Right Thumb Handle
                    thumbView(position: CGPoint(x: rightThumbLocation, y: sliderViewYCenter), value: Int(Float(currentValue.wrappedValue.upperBound)))
                        .highPriorityGesture(DragGesture().onChanged { dragValue in
                            let dragLocation = dragValue.location
                            let xThumbOffset = min(max(CGFloat(leftThumbLocation), dragLocation.x), sliderSize.width)
                            
                            var newValue = Float(xThumbOffset / stepWidthInPixel) // convert back the value bound
                            newValue = min(newValue, Float(sliderBounds.upperBound))
                            
                            // Stop the range thumbs from colliding each other
                            if newValue > Float(currentValue.wrappedValue.lowerBound) {
                                currentValue.wrappedValue = currentValue.wrappedValue.lowerBound...Int(newValue)
                            }
                        })
                }
            }
        }
    }
    
    @ViewBuilder func lineBetweenThumbs(from: CGPoint, to: CGPoint) -> some View {
        Path { path in
            path.move(to: from)
            path.addLine(to: to)
        }.stroke(Color.blue, lineWidth: 4)
    }
    
    @ViewBuilder func thumbView(position: CGPoint, value: Int) -> some View {
        ZStack {
            Text(String(value))
                .font(.body)
                .offset(y: -20)
            Circle()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.16), radius: 8, x: 0, y: 2)
                .contentShape(Rectangle())
        }
        .position(x: position.x, y: position.y)
    }
}

