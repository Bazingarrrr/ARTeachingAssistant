//
//  ARDetailedView.swift
//  NUS FYP ARTeachingAssistant
//
//  Created by yi 万 on 29/09/2020.
//  Copyright © 2020 yi 万. All rights reserved.
//

import SwiftUI

struct ARDetailedView: View {
    
    var image: Image
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            image
                .shadow(radius: 10)

            HStack {
                Text("4-Bar Mechanism")
                    .font(.title)
                    .foregroundColor(Color.black)
                Spacer()
            }
            
            Text("Discription for 4-Bar mechanism")
            
            Spacer()
        }
        .padding()
        

        
    }
}

struct ARDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        ARDetailedView(image: Image("FourBarLinkage"))
    }
}
