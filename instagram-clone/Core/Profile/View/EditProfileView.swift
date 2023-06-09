//
//  EditProfileView.swift
//  instagram-clone
//
//  Created by ipeerless on 24/05/2023.
//

import SwiftUI
import  PhotosUI

struct EditProfileView: View {
    @Environment (\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    var body: some View {
        VStack {
            
            VStack {
                HStack  {
                    Button("cancel") {
                       dismiss()
                        
                    }
                    Spacer()
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        Task {try await viewModel.updateUserData()}
                        dismiss()
                    } label: {
                        Text("done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }

                }
                .padding(.horizontal)
                Divider()
                
            }
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                    } else {
                        CircularProfileImageView(user: viewModel.user, size: .large)
                    }
                     
                    Text("Edit profile pic")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Divider()
                }
            }
            .padding(.vertical, 8)
            VStack {
                editProfileRowView(title: "name", placeholder: "Enter name", text: $viewModel.fullname)
                editProfileRowView(title: "bio", placeholder: "Enter bio", text: $viewModel.bio)
            }
            Spacer()
        }
     
    }
}

struct editProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            VStack {
                TextField(placeholder, text: $text)
                Divider()
                
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User.MOCK_USERS[0])
    }
}
