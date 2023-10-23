//
//  ViewController.swift
//  Project1
//
//  Created by Zaid Naing on 10/17/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                //this is picture to load
                pictures.append(item)
            }
        }
        pictures = pictures.sorted()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func shareTapped() {
        // Content to be shared
        let text = "Check out this cool app!"
        
        // Create an array containing the share items.
        let activityItems = [text]

        // Initialize the share sheet
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // Exclude certain types of activities from the share sheet
        activityViewController.excludedActivityTypes = [
            .addToReadingList,
            .airDrop,
            .print
            // Add any other activities you wish to exclude
        ]
        // Present the share sheet
        present(activityViewController, animated: true, completion: nil)
    }
   
}

