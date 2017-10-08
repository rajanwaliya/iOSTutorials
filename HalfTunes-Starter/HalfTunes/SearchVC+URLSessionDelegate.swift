//
//  SearchVC+URLSessionDelegate.swift
//  HalfTunes
//
//  Created by Waliya, Rajan on 10/7/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import Foundation

extension SearchViewController: URLSessionDelegate {
  
  func urlSession(_ session:URLSession, downloadTask: URLSessionDownloadTask,
                  didFinishDownloadingTo location: URL){
    print("Finished downloading to \(location).");
    guard let sourceURL = downloadTask.originalRequest?.url else {return}
    let download = downloadService.activeDownloads[sourceURL]
    downloadService.activeDownloads[sourceURL] = nil
    
    let destinationURL = localFilePath(for: sourceURL)
    print("destination url is \(destinationURL)")
    let fileManager = FileManager.default
    
    try? fileManager.removeItem(at: sourceURL)
    do{
      try fileManager.copyItem(at: location, to: destinationURL)
      download?.track.downloaded = true
    }catch let error{
      print("could not copy the file \(error.localizedDescription)")
    }
    
    if let index = download?.track.index{
      DispatchQueue.main.async {
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
      }
    }
  }
  
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                  didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                  totalBytesExpectedToWrite: Int64) {
    // 1
    guard let url = downloadTask.originalRequest?.url,
      let download = downloadService.activeDownloads[url]  else { return }
    // 2
    download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
    // 3
    let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
    // 4
    DispatchQueue.main.async {
      if let trackCell = self.tableView.cellForRow(at: IndexPath(row: download.track.index,
                                                                 section: 0)) as? TrackCell {
        trackCell.updateDisplay(progress: download.progress, totalSize: totalSize)
      }
    }
  }
}
