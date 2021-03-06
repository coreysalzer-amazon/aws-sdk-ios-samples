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
import AWSCore
import AWSLex

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: CognitoRegion, identityPoolId: CognitoIdentityPoolId)

        let configuration = AWSServiceConfiguration(region: LexRegion, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let chatConfig = AWSLexInteractionKitConfig.defaultInteractionKitConfig(withBotName: BotName, botAlias: BotAlias)
        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "AWSLexVoiceButton")
        chatConfig.autoPlayback = false
        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "chatConfig")
        
        // Override point for customization after application launch.
        return true
    }
}

