//
//  ViewController.swift
//  SwiftyRefresh
//
//  Created by Mike Ackley on 4/30/15.
//  Copyright (c) 2015 Michael Ackley. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RefreshDelegate  {

    @IBOutlet weak var tableView: RefreshTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 70

        //Initializer
        self.tableView.setupRefreshControl()
        self.tableView.refreshDelegate = self
        
    }
 
    // !! Put your async refreshing activity in this method !!
    func refreshTriggered() {
        
        var delayInSeconds = 2.0;
        var popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            
            //Call this to end refreshing after the activity is complete
            self.tableView.endRefreshing()
            
        }
        
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // !! This is important !!
        self.tableView.tableDidScroll()
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        cell.textLabel?.text = "Cell \(indexPath.row)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

