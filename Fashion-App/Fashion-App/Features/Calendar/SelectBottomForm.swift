import Foundation
import SwiftUI

struct SelectBottomForm: View {
    
    @Binding var data: ClothingItem.FormData
    //let tops = getAllInCategory(cat: Category.top, clothes: data)
    
    var body: some View {
        ScrollView {
            
            //title for form: Choose Top for (insert date)
            Text("Choose Bottoms")
            
            //low temp, high temp, description of weather
            
            //dataset = all clothing filtered for tops, sorted by cleanliness
            //getAllInCategory(cat: top, clothes: data)
            //ForEach()
            
            //each top in an hstack
                //image of top
                //date last worn
                //clean or dirty (cannot select if dirty)
                //button to select (can only select 1 maximum)
        }
    }
    
    
}

struct SelectBottomsForm_Previews: PreviewProvider {
  static var previews: some View {
      SelectTopForm(data: Binding.constant(ClothingItem.previewData[0].dataForForm))
  }
}

