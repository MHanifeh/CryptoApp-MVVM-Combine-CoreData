//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/25/1401 AP.
//

import Foundation
import SwiftUI

class LocalFileManager{
    
    static let instance = LocalFileManager()
    
    private init(){}
    
    func savedImage(image: UIImage , imageName : String , folderName : String){
        
        //create folder
        createFolderIfNeeded(folderName: folderName)
        
        //get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else {return}
        
        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error in saveing image , image name :\(imageName), \(error)")
        }}
    
    func getImage(imageName: String , folderName: String) -> UIImage?{
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
                FileManager.default.fileExists(atPath: url.path) else {
            return nil
            
        }
        return UIImage(contentsOfFile: url.path)
        
    }
    
    private func createFolderIfNeeded(folderName : String){
        
        guard let url = getURLForFolder(folderName: folderName) else {return}
        if !FileManager.default.fileExists(atPath: url.path){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Erorr in crating folder :\(folderName), \(error)")
            }
        }
    }
    
    // get folder url to place file in it .
    
    private func getURLForFolder(folderName:String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    // create image and place it in directory .
    
    private func getURLForImage(imageName:String , folderName : String) ->URL? {
        guard let folderUrl = getURLForFolder(folderName: folderName) else {return nil}
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
    
    
}
