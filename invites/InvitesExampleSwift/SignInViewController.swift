//
//  Copyright (c) Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
import UIKit
import Firebase
import GoogleSignIn

// Match the ObjC symbol name inside Main.storyboard.
@objc(SignInViewController)

class SignInViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

  @IBOutlet weak var signInButton: GIDSignInButton!
  @IBOutlet weak var bgText: UILabel!

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    bgText.text = "Invites\niOS demo"

    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance().signInSilently()
  }

  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    guard error == nil else {
      // Something went wrong; for example, the user could haved clicked cancel.
      print("\(error.localizedDescription)")
      return
    }
    // User Successfully signed in.
    // TODO: Remove async after, when GIDSignIn is started getting called after dissmissVC
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
      guard let s = self else { return }
      s.performSegue(withIdentifier: "SignedInScreen", sender: s)
    }
  }

  @IBAction func unwindToSignIn(_ sender: UIStoryboardSegue) {
    GIDSignIn.sharedInstance().delegate = self
  }

  // Sets the status bar to white.
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
