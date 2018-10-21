//
//  File.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 16.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import UIKit
import MediaPlayer

extension MusicPlayerViewController {
    func getSongs() -> [Track] {
        var tracks : [Track] = []
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        var title : String = ""
        var albumName : String = ""
        var artist : String = ""
        var duration : Int = 0
        
        do {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for track in songPath {
                
                let songString = track.absoluteString
                if songString.contains(".mp3") {
                    
                    //To get title artist and album name...
                    let playerItem = AVPlayerItem(url: track)
                    let metadataList = playerItem.asset.commonMetadata
                    for item in metadataList {

                        if item.commonKey!.rawValue == "title" {
                            title = item.stringValue ?? "Unknown"
                            print("Title = \(title)")
                        }
                        if item.commonKey!.rawValue == "artist" {
                            artist = item.stringValue ?? "Unknown"
                            print("Artist = \(artist)")
                        }
                        if item.commonKey!.rawValue == "albumName" {
                            albumName = item.stringValue ?? "Unknown"
                            print("Album Name = \(albumName) ")
                        }
                    }
                    
                    // to get duration
                    let asset = AVURLAsset(url: track)
                    let audioDuration = asset.duration
                    duration = Int(CMTimeGetSeconds(audioDuration))
                    print("Duration : ", duration)
                    
                    let data = try Data(contentsOf: track)
                    tracks.append(Track(trackData: data, title: title, albumName: albumName, artist: artist, duration: duration, albumCover: nil))
                    
                }
            }
        } catch  {
           print("couldn't catch songs.")
        }
        return tracks
    }
    
    
//
//
//    func getTracks() -> [Data] {
//        var tracks : [Data] = []
//        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
//
//        var title : String = ""
//        var albumName : String = ""
//        var artist : String = ""
//        var duration : Int = 0
//
//        do {
//            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
//
//            for track in songPath {
////                try let data = Data(contentsOf: track)
//                let songString = track.absoluteString
//                if songString.contains(".mp3") {
//
//                    //To get title artist and album name...
//                    let playerItem = AVPlayerItem(url: track)
//                    let metadataList = playerItem.asset.commonMetadata
//                    for item in metadataList {
//
//                        if item.commonKey!.rawValue == "title" {
//                            title = item.stringValue ?? "Unknown"
//                            print("Title = \(title)")
//                        }
//                        if item.commonKey!.rawValue == "artist" {
//                            artist = item.stringValue ?? "Unknown"
//                            print("Artist = \(artist)")
//                        }
//                        if item.commonKey!.rawValue == "albumName" {
//                            albumName = item.stringValue ?? "Unknown"
//                            print("Album Name = \(albumName) ")
//                        }
//                    }
//
//                    // to get duration
//                    let asset = AVURLAsset(url: track)
//                    let audioDuration = asset.duration
//                    duration = Int(CMTimeGetSeconds(audioDuration))
//                    print("Duration : ", duration)
//
//                    tracks.append(Track(title: title, albumName: albumName, artist: artist, duration: duration))
//
//                }
//            }
//        } catch  {
//            print("couldn't catch songs.")
//        }
//        return tracks
//    }
//

}
