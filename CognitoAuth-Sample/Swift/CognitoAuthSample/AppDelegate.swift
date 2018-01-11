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
import AWSCognitoIdentityProvider
import AWSCore
import AWSCognito


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //Need to let CognitoAuth handle redirects so it can extract tokens
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return AWSCognitoAuth.default().application(app, open: url, options: options)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//
//        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "us-east-1:054cb6b9-addf-4e9f-b91d-b6b241dcddca")
//        let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialProvider)
//        AWSServiceManager.default().defaultServiceConfiguration = configuration
//
        
//        let serviceConfiguration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: nil)
//        let userPoolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: "4ood3na1ad7ihr3rqdb4ro0gd9", clientSecret: "na7bjn5s33a3s89fjucru3q16e7i3ad7e1p1dhvjck87rqloam4", poolId: "us-east-1_ESgINWmXW")
//        AWSCognitoIdentityUserPool.registerCognitoIdentityUserPool(with: userPoolConfiguration, forKey: "UserPool")
//        let pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
//        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "us-east-1:054cb6b9-addf-4e9f-b91d-b6b241dcddca", identityProviderManager:pool)
//
//
        
        var serviceConfiguration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: nil)
        AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration
        let userPoolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: "4ood3na1ad7ihr3rqdb4ro0gd9", clientSecret: "na7bjn5s33a3s89fjucru3q16e7i3ad7e1p1dhvjck87rqloam4", poolId: "us-east-1_ESgINWmXW")
       AWSCognitoIdentityUserPool.registerCognitoIdentityUserPool(with: userPoolConfiguration, forKey: "UserPool")
        let pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "us-east-1:054cb6b9-addf-4e9f-b91d-b6b241dcddca", identityProviderManager:pool)
        serviceConfiguration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration
    

        return true
    }


}

