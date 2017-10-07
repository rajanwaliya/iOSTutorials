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
  }
}
