import SwiftUI

struct ColorChange: View {
    @State private var images: [String] = ["yellow", "green", "blue", "purple", "orange", "red"]
    @State private var imgNdx = 0
    
    var body: some View {
        VStack {
            Image(images[imgNdx])
                .frame(width: 333, height: 333) // adjust the size as desired
            
            HStack {
                Button("Next", action: {
                    if imgNdx < images.count-1 {
                        imgNdx += 1
                    }
                })
                
                Button("Previous", action: {
                    if imgNdx >= 1 {
                        imgNdx -= 1
                    }
                })
            }
        }.buttonStyle(.bordered)
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
      ColorChange()
    }
}

