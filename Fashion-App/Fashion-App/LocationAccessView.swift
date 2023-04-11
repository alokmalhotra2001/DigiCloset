import SwiftUI

struct LocationAccessView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        ZStack {
            Color(.systemBlue).ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                
                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 32)
                
                Spacer()
                
                Text("FashionApp requires your location to provide optimal outift recommendations")
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 350)
                
                Text("Start sharing your location with us")
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                    .padding()
                
                Spacer()
                
                VStack {
                    Button {
                        locationViewModel.requestPermission()
                    } label : {
                        Text("Allow Location")
                            .padding()
                            .font(.headline)
                            .foregroundColor(Color(.systemBlue))
                    }
                    .frame(width: 300)
                    .padding(.horizontal, 32)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding()
                }
                .padding(.bottom, 32)
            }
            .foregroundColor(.white)
        }
    }
}

struct LocationAccessView_Previews: PreviewProvider {
    static var previews: some View {
        LocationAccessView()
    }
}
