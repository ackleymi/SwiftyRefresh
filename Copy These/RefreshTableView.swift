//
//  RefreshTableView.swift
//  MarketfyApp
//
//  Created by Mike Ackley on 4/21/15.
//  Copyright (c) 2015 Marketfy.com. All rights reserved.
//

import UIKit

protocol RefreshDelegate {
    func refreshTriggered()
}

public class RefreshTableView: UITableView, UITableViewDelegate {
    
    var refreshLoadingView : UIView!
    var refreshControl : UIRefreshControl!
    var arrowView : UIImageView!
    var refreshDelegate: RefreshDelegate!
    var refreshSpinner: UIActivityIndicatorView!
    
    func setupRefreshControl() {
        
        self.refreshControl = UIRefreshControl()
        self.addSubview(self.refreshControl)
        
        self.refreshLoadingView = UIView(frame: self.refreshControl!.bounds)
        self.refreshLoadingView.backgroundColor = UIColor.clearColor()
        
        self.arrowView = UIImageView(image: UIImage(named: "pull-arrow.png"))
        self.arrowView.frame = CGRectMake((UIScreen.mainScreen().bounds.size.width/2-12.5), 0, 25, 25)
        
        self.refreshSpinner = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50))
        self.refreshSpinner.center = self.refreshLoadingView.center
        self.refreshSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.refreshLoadingView.addSubview(self.refreshSpinner)
        self.refreshSpinner.startAnimating()
        self.refreshSpinner.hidden = true
        
        self.refreshLoadingView.addSubview(self.arrowView)
        self.refreshLoadingView.clipsToBounds = true;
        
        self.refreshControl!.tintColor = UIColor.clearColor()
        self.refreshControl!.addSubview(self.refreshLoadingView)
        
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func refresh(){
        
        self.refreshSpinner.hidden = false
        self.arrowView.hidden = true
        self.refreshDelegate.refreshTriggered()
    }
    
    
    func endRefreshing() {
        
        self.refreshSpinner.hidden = true
        self.arrowView.hidden = false
        self.refreshControl.endRefreshing()
    }
    
    
    public func tableDidScroll() {
        
        var refreshBounds = self.refreshControl!.bounds;
        var pullDistance = max(0.0, -self.refreshControl!.frame.origin.y);
        var arrowFrame = self.arrowView.frame;
        
        arrowFrame.origin.y = (pullDistance-40);
        
        self.arrowView.frame = arrowFrame;
        self.refreshSpinner.center = self.arrowView.center;
        self.refreshSpinner.hidden = !self.refreshControl.refreshing
        
        refreshBounds.size.height = pullDistance;
        
        self.refreshLoadingView.frame = refreshBounds;
        
        
        
    }
    
}
