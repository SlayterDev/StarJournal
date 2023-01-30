//
//  ImageFrame.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/30/23.
//

import SwiftUI

struct ImageFrame: View {
    @Environment(\.isPresented) private var isPresented
    
    let image: UIImage
    
    func shareImage() {
        guard isPresented else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        let presentedController = UIApplication.keyWindow?.rootViewController?.presentedViewController ?? UIApplication.keyWindow?.rootViewController
        presentedController?.present(activityController, animated: true)
    }
    
    var body: some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Spacer()
                
                VStack(alignment: .trailing) {
                    Spacer()
                    
                    Button(action: shareImage) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color.white)
                            .frame(width: 20)
                    }
                    .frame(width: 55, height: 55)
                    .background(Color.accentColor)
                    .cornerRadius(27.5)
                }
            }
            .padding(8)
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
    }
}
