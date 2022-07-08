//
//  AlertItem.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/28/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    // MARK: - MapView Errors
    static let unableToGetLocations         = AlertItem(title: Text("Locations Error"),
                                            message: Text("Unable to retrieve locations at this time.\nPlease try again"),
                                            dismissButton: .default(Text("Ok")))
    
    static let locationRestricted           = AlertItem(title: Text("Locations Restricted"),
                                              message: Text("Your location is restricted. This may be due to parental controls."),
                                              dismissButton: .default(Text("Ok")))
    static let locationDenied               = AlertItem(title: Text("Locations Denied"),
                                              message: Text("DubDubGrub does not have permission to access your location.\nGo to your phone's Settings -> DubDubGrub -> Location"),
                                              dismissButton: .default(Text("Ok")))
    
    static let locationDisabled             = AlertItem(title: Text("Locations Disabled"),
                                              message: Text("DubDubGrub does not have permission to access your location.\nGo to your phone's Settings -> Privacy -> Location Services"),
                                              dismissButton: .default(Text("Ok")))
    
    // MARK: - ProfileView Errors
    static let invalidProfile               = AlertItem(title: Text("Invalid Profile"),
                                            message: Text("All fields are required as well as a profile photo. Your bio less than 100 characters.\nPlease try again."),
                                            dismissButton: .default(Text("Ok")))
    
    static let noUserRecord                 = AlertItem(title: Text("No User record"),
                                            message: Text("You must log into iCloud in order to utilize Dub Dub Grub's Profile. Please log in to iCloud."),
                                            dismissButton: .default(Text("Ok")))
    
    static let createProfileSuccess         = AlertItem(title: Text("Profile Created Successfully"),
                                            message: Text("Your profile has successfully been created."),
                                            dismissButton: .default(Text("Ok")))
    
    static let createProfileFailure         = AlertItem(title: Text("Failed To Create Profile"),
                                            message: Text("We were unable to create your profile at this time.\n Please try again later or contact the developer if this persists."),
                                            dismissButton: .default(Text("Ok")))
    
    static let unableToGetProfile           = AlertItem(title: Text("Unable To Retrieve Profile"),
                                            message: Text("We are unable to retrieve your profile at this time. Please check your internet connection.\n Contact the developer if this persists."),
                                            dismissButton: .default(Text("Ok")))
    
    static let updatedProfileSuccess        = AlertItem(title: Text("Updated Profile Successfully"),
                                            message: Text("Your profile has successfully been updated."),
                                            dismissButton: .default(Text("Ok")))
    
    static let updatedProfileFailure        = AlertItem(title: Text("Profile Update Failed"),
                                            message: Text("Your profile was not succesfully updated./n Please try again later."),
                                            dismissButton: .default(Text("Ok")))
    
    // MARK: - LocationDetailView Errors
    static let invalidPhoneNumber           = AlertItem(title: Text("Invalid Phone Number"),
                                            message: Text("The phone number for the location is invalid. Please check for the phone number yourself."),
                                            dismissButton: .default(Text("Ok")))
    
    static let unableToGetCheckInStatus     = AlertItem(title: Text("Server Error"),
                                                    message: Text("Unable to retrieve checked in status of the current user.\nPlease try again."),
                                                    dismissButton: .default(Text("Ok")))
    
    static let unableToCheckInOrOut         = AlertItem(title: Text("Server Error"),
                                                   message: Text("We are unable to check in/out at this time. \nPlease try again."),
                                                   dismissButton: .default(Text("Ok")))
    
    static let unableToGetCheckedInProfiles = AlertItem(title: Text("Server Error"),
                                                   message: Text("We are unable to get users checked into this location at this time.\nPlease try again."),
                                                   dismissButton: .default(Text("Ok")))
}
