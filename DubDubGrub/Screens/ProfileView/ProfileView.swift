//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/27/22.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @State private var firstName            = ""
    @State private var lastName             = ""
    @State private var companyName          = ""
    @State private var bio                  = ""
    @State private var avatar               = PlaceholderImage.avatar
    @State private var isShowingPhotoPicker = false
    @State private var alertItem: AlertItem?
    
    var body: some View {
        
        VStack {
            ZStack {
                NameBackgroundView()
                
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(image: avatar, size: 84)
                        EditImageView()
                    }
                    .padding(.leading, 12)
                    .onTapGesture {
                        isShowingPhotoPicker = true
                    }
                    
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .profileNameStyle()
                        
                        TextField("Last Name", text: $lastName)
                            .profileNameStyle()
                        
                        TextField("Company", text: $companyName)
                    }
                    .padding(.trailing, 16)
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    CharactersRemainView(currentCount: bio.count)
                    
                    Spacer()
                    
                    
                    Button {
                        print("stuff")
                    } label: {
                        Label("Check out", systemImage: "mappin.and.ellipse")
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.regular)
                    .tint(.red)
                    
                }
                TextEditor(text: $bio)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, lineWidth:  1))
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button {
                //                createProfile()
            } label: {
                DDGButton(title: "Save Profile")
            }
            .buttonStyling()
            .padding(.bottom)
        }
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .onAppear { getProfile() }
        .alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(image: $avatar)
        }
    }
    
    func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count < 100 else { return false }
        
        return true
    }
    
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        // Create our CKRecord from the data gathered from our Profile View
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[DDGProfile.kFirstName]    = firstName
        profileRecord[DDGProfile.kLastName]     = lastName
        profileRecord[DDGProfile.kCompanyName]  = companyName
        profileRecord[DDGProfile.kBio]          = bio
        profileRecord[DDGProfile.kAvatarAsset]  = avatar.convertToCKAsset()
        
        // Get our UserRecordID from the Container
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            // Get UserRecord from the Public Database
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                // Create reference on UserRecord to the DDGProfile we created
                userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
                // Create a CKOperation to save our User and Profile Records.
                let operation = CKModifyRecordsOperation(recordsToSave: [userRecord, profileRecord])
                operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
                    guard let savedRecords = savedRecords, error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    print(savedRecords)
                }
                // task.resume()
                CKContainer.default().publicCloudDatabase.add(operation)
            }
            
        }
    }
    
    func getProfile() {
        // Get our UserRecord, this is what ties us to our profile
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                // Now that we have our UserRecord, grab the reference to the profile.
                let profileReference = userRecord["userProfile"] as! CKRecord.Reference
                let profileRecordID = profileReference.recordID
                
                // Fetch from the publicCloudDatabase using our profileRecordID
                CKContainer.default().publicCloudDatabase.fetch(withRecordID: profileRecordID) { profileRecord, error in
                    guard let profileRecord = profileRecord, error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    // Once we get our information, populate the profile with all of this information.
                    DispatchQueue.main.async {
                        let profile = DDGProfile(record: profileRecord)
                        firstName   = profile.firstName
                        lastName    = profile.lastName
                        companyName = profile.companyName
                        bio         = profile.bio
                        avatar      = profile.avatarImage
                    }
                }
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            ProfileView()
                .preferredColorScheme(.dark)
        }
    }
}

struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

struct EditImageView: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width:14, height: 14)
            .offset(y: 30)
    }
}

struct CharactersRemainView: View {
    
    var currentCount: Int
    
    var body: some View {
        Text("Bio: ")
            .font(.callout)
            .foregroundColor(.secondary)
        +
        Text("\(100 - currentCount)")
            .bold()
            .font(.callout)
            .foregroundColor(currentCount <= 100 ? .brandPrimary : Color(.systemPink))
        +
        Text(" characters remain.")
            .font(.callout)
            .foregroundColor(.secondary)
    }
}
