//  NotificationForm.swift
//  Written by Alexandra Rivera
//

import SwiftUI

struct NotificationsForm: View {
    @Binding var data: Notification.FormData
    var notif: Notification

    var body: some View {
        Form {
            Section(header: Text("\(notif.top.name)")) {
                HStack{
                    Spacer()
                    notif.top.img
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200, maxHeight: 200)
                    Spacer()
                }
                Toggle("Moved to the dirty bin", isOn: $data.topInDirtyBin).bold()
            }
            Section(header: Text("\(notif.bottom.name)")) {
                HStack{
                    Spacer()
                    notif.bottom.img
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200, maxHeight: 200)
                    Spacer()
                }
                Toggle("Moved to the dirty bin", isOn: $data.bottomInDirtyBin).bold()
            }
        }
        .navigationTitle(Text("Navigation title"))
    }
}

// from MovieTrackerApp
struct TextFieldWithLabel: View {
  let label: String
  @Binding var text: String
  var prompt: String? = nil

  var body: some View {
    VStack(alignment: .leading) {
      Text(label)
        .bold()
        .font(.caption)
      TextField(label, text: $text, prompt: prompt != nil ? Text(prompt!) : nil)
        .padding(.bottom, 20)
    }
  }
}

struct NotificationsForm_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsForm(
            data: Binding.constant(Notification.previewData[0].dataForForm),
            notif: Notification.previewData[0]
        )
    }
}

