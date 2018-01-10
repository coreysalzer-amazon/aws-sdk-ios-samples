//
// Copyright 2010-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

import UIKit
import AWSCognitoAuth
import Alamofire

class ViewController: UITableViewController, AWSCognitoAuthDelegate {
  
    @IBOutlet weak var signInButton: UIBarButtonItem!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    var auth: AWSCognitoAuth = AWSCognitoAuth.default()
    var session: AWSCognitoAuthUserSession?
    var playlists:[Playlist] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.auth.delegate = self;
        if(self.auth.authConfiguration.appClientId.contains("SETME")){
            self.alertWithTitle("Error", message: "Info.plist missing necessary config under AWS->CognitoUserPool->Default")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(self.session == nil){
            self.signInTapped(signInButton)
        }
    }
    
    func getViewController() -> UIViewController {
        return self;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let token = getBestToken()
//        if((token) != nil){
//            return token!.claims.count
//        }
//        return 0
        
        let token = getBestToken()
        if((token) == nil){
            return 0
        }
        return self.playlists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
//        let token = getBestToken()
//        let key = Array(token!.claims.keys)[indexPath.row]
//        cell.textLabel?.text = key as? String
//        cell.detailTextLabel?.text = (token!.claims[key] as AnyObject).description
        
        cell.textLabel?.text = playlists[indexPath.row].name
        cell.detailTextLabel?.text = String(playlists[indexPath.row].songs.count) + " songs"
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "showPlaylistDetails", sender: indexPath);
//    }


    func getBestToken() -> AWSCognitoAuthUserSessionToken? {
        if(self.session != nil){
            if((self.session?.idToken) != nil){
                return self.session?.idToken!
            }else if((self.session?.accessToken) != nil){
                return self.session?.accessToken!
            }
        }
        return nil;
    }
    
    func refresh () {
        DispatchQueue.main.async {
            if let token : AWSCognitoAuthUserSessionToken = self.getBestToken() {
                
//                let headers : HTTPHeaders = [
//                    "Authorization": token.tokenString
//                ]
//
//                debugPrint(token.tokenString)
//
//                Alamofire.request("https://1rk5wjwn6j.execute-api.us-east-1.amazonaws.com/prod/playlists", headers: headers)
//                    .responseJSON { response in
//                        debugPrint(response)
//
//                        switch response.result {
//                        case .success:
//                            print("Validation Successful")
//                        case .failure(let error):
//                            print(error)
//                        }
//
//                        if let json = response.result.value as? NSArray {
//                            self.playlists = []
//
//                            for case let playlistJson as NSDictionary in json {
//                                self.playlists.append(Playlist(json: playlistJson))
//                            }
//
//                            self.tableView.reloadData()
//                        }
                }
            
                let client = PLAYLISTIFYPlaylistifyClient.default()
                
                client.playlistsGet().continueWith(block: {(task: AWSTask) -> AnyObject? in
                    if let error = task.error {
                        print("Error: \(error)")
                    }
                    else if let result = task.result {
                        print(result)
                        print(result.playlists)
                        for playlist in result.playlists {
                            print(playlist.ID)
                            print(playlist.user!)
                            print(playlist.songs!)
                        }
                        
                        
                    }
                    return nil
                })
//            }
            
            self.signInButton.isEnabled = self.session == nil
            self.signOutButton.isEnabled = self.session != nil
            self.tableView.reloadData()
            self.title = self.session?.username;
        }
    }
    
    func alertWithTitle(_ title:String, message:String?) -> Void {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (UIAlertAction) in
                alert.dismiss(animated: false, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    

    @IBAction func signInTapped(_ sender: Any) {
        self.auth.getSession  { (session:AWSCognitoAuthUserSession?, error:Error?) in
            if(error != nil) {
                self.session = nil
                self.alertWithTitle("Error", message: (error! as NSError).userInfo["error"] as? String)
            }else {
                self.session = session
            }
            self.refresh()
        }
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        self.auth.signOut { (error:Error?) in
            if(error != nil){
                self.alertWithTitle("Error", message: (error! as NSError).userInfo["error"] as? String)
            }else {
                self.session = nil
                self.alertWithTitle("Info", message: "Session completed successfully")
                self.playlists = []
            }
            self.refresh()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.identifier == "showPlaylistDetails") {
            let controller = segue.destination as! PlaylistDetailViewController
            let row = tableView.indexPathForSelectedRow!.row;
            controller.songs = playlists[row].songs as [Song]
        }
    }

}

