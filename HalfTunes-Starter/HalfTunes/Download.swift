//
//  Download.swift
//  HalfTunes
//
//  Created by Waliya, Rajan on 10/7/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import Foundation

class Download {
  var track: Track
  
  init(track:Track) {
    self.track = track
  }
  
  
  var task: URLSessionDownloadTask
  var isDownloading = false
  var resumeData: Data?
  
  var progress: Float = 0
  
}
