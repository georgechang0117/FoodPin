//
//  AddTableViewController.swift
//  FoodPin
//
//  Created by georgechang on 2015/7/17.
//  Copyright (c) 2015年 georgechang. All rights reserved.
//

import UIKit
import CoreData

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var typeTextField:UITextField!
    @IBOutlet weak var locationTextField:UITextField!
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var yesButton:UIButton!
    @IBOutlet weak var noButton:UIButton!
    
    var isVisited = true
    
    var restaurant:Restaurant!
    
    //@IBOutlet weak var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.delegate = self
                self.presentViewController(imagePicker, animated: true, completion: nil)
                
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func save() {
        
        // Form validation
        var errorField = ""
        
        if nameTextField.text == "" {
            errorField = "name"
        } else if locationTextField.text == "" {
            errorField = "location"
        } else if typeTextField.text == "" {
            errorField = "type"
        }
        
        if errorField != "" {
            
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed as you forget to fill in the restaurant " + errorField + ". All fields are mandatory.", preferredStyle: .Alert)
            let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        // If all fields are correctly filled in, extract the field value
        println("Name: " + nameTextField.text)
        println("Type: " + typeTextField.text)
        println("Location: " + locationTextField.text)
        println("Have you been here: " + (isVisited ? "yes" : "no"))
        
    
        // If all fields are correctly filled in, extract the field value
        // Create Restaurant Object and save to data store
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            
            restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant",
            inManagedObjectContext: managedObjectContext) as! Restaurant
            restaurant.name = nameTextField.text
            restaurant.type = typeTextField.text
            restaurant.location = locationTextField.text
            restaurant.image = UIImagePNGRepresentation(imageView.image)
            restaurant.isVisited = isVisited
            //            restaurant.isVisited = NSNumber.convertFromBooleanLiteral(isVisited)
            
            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println("insert error: \(e!.localizedDescription)")
                return
            }
        }
    
        // Execute the unwind segue and go back to the home screen
        performSegueWithIdentifier("unwindToHomeScreen", sender: self)

    }
    
    @IBAction func updateIsVisited(sender: AnyObject) {
        // Yes button clicked
        let buttonClicked = sender as! UIButton
        if buttonClicked == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
            noButton.backgroundColor = UIColor.grayColor()
        } else if buttonClicked == noButton {
            isVisited = false
            yesButton.backgroundColor = UIColor.grayColor()
            noButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        }
    }

    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
