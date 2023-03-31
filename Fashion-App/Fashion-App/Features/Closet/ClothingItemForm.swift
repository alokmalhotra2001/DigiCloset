import SwiftUI
import Foundation

struct ClothingForm: View {
    @Binding var data: ClothingItem.FormData

    var body: some View {
        Form {
            TextFieldWithLabel(label: "Title", text: $data.name, prompt: "Name")
        }
    }
}

struct TextFieldWithLabel: View {
    let label: String
    @Binding var text: String
    var prompt: String? = nil

    var body: some View {
        VStack(alignment: .leading) {
            Text(label).bold().font(.caption)
            TextField(label, text: $text, prompt: prompt != nil ? Text(prompt!) : nil).padding(.bottom, 20)
        }
    }
}

struct ClothingForm_Previews: PreviewProvider {
    static var previews: some View {
        ClothingForm(data: Binding.constant(ClothingItem.previewData[0].dataForForm))
    }
}


//import SwiftUI
//import Foundation
//
//struct BookForm: View {
//    @Binding var data: Book.FormData
//
//    var body: some View {
//        Form {
//            TextFieldWithLabel(label: "Id", text: $data.id, prompt: "Id")
//            TextFieldWithLabel(label: "Title", text: $data.title, prompt: "Title")
//            TextFieldWithLabel(label: "Author", text: $data.author, prompt: "Author")
//        }
//    }
//}
//
//struct BookForm_Previews: PreviewProvider {
//    static var previews: some View {
//        BookForm(data: Binding.constant(Book.previewData[0].dataForForm))
//    }
//}
