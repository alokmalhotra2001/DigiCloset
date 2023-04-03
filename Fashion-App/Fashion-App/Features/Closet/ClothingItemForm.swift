import SwiftUI
import Foundation

struct ClothingForm: View {
    @Binding var data: ClothingItem.FormData
    @State var showingImagePicker = false
    @State var inputImage: UIImage?

    var body: some View {
        Form {
            Section(header: Text("Basic Clothing Info")) {
                TextField("Title", text: $data.name)
                Picker("Category", selection: $data.category) {
                    ForEach(ClothingItem.Category.allCases) {
                        category in Text(category.rawValue.capitalized)
                    }
                }
                    .pickerStyle(MenuPickerStyle())
            }
            
            Section(header: Text("Temperature Range")) {
                RangedSliderView(value: $data.tempRange, bounds: 0...100)
                    .padding()
            }
            
            Section(header: Text("Image")) {
                ZStack {
                    Rectangle().fill(.white)
                    if (data.img != Image(systemName: "photo")) {
                        data.img.resizable().scaledToFit()
                    }
                    else {
                        Text("Tap to Select a Picture")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                    .onTapGesture {
                        showingImagePicker = true
                    }
                    .onChange(of: inputImage) { _ in loadImage() }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        data.img = Image(uiImage: inputImage)
    }
}

struct ClothingForm_Previews: PreviewProvider {
    static var previews: some View {
        ClothingForm(data: Binding.constant(ClothingItem.previewData[0].dataForForm))
    }
}
