//
//  VideoPlayerHelper.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 13/1/68 BE.
//

import Foundation
import AVKit

var videoPlayer: AVPlayer?

func playVideo(fileName: String, fileFormat: String) -> AVPlayer? {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: fileFormat) else {
        return  videoPlayer
    }
    videoPlayer = AVPlayer(url: url)
    videoPlayer?.play()
    return videoPlayer
}

