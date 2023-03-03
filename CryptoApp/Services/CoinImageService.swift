//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/24/1401 AP.
//
import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image : UIImage? = nil
    
    private var imageSubscription : AnyCancellable?
    private var coin : CoinModel
    private var filManager = LocalFileManager.instance
    private var folderName = "coin_images"
    private var imageName : String
    
    init(coin : CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let savedImage = filManager.getImage(imageName: imageName, folderName: folderName){
            image = savedImage
            print("Retrived Image From FileManager")
    
        }else{
            downloaCoinImage()
            print("Image Downloaded")
        }
    }
    
    private func downloaCoinImage(){
   
        guard let url = URL(string: coin.image) else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ ( data )-> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handelError, receiveValue: {[weak self] (returnedImage) in
                guard let self = self , let downloadedImage = returnedImage else{return}
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.filManager.savedImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
