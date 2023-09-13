//
//  AddToDoListView.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 13/09/23.
//

import SwiftUI

struct AddToDoListView: View {
    @StateObject private var viewModel: AddToDoListViewModel = AddToDoListViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var deadline = Date.now
    
    var categories = ["Minor", "Medium", "Major", "Critical"]
    @State private var selectedCategory = "Minor"
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "pencil.line")
                TextField("Title", text: $title)
                
                Spacer()
                if title.count != 0 {
                    Image(systemName: "checkmark")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }.padding().overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
            ).padding()
            HStack{
                DatePicker(selection: $deadline, displayedComponents: .date) {
                    Text("Select your deadline date")
                }
                Spacer()
                Image(systemName: deadline>=Date.now ? "checkmark" : "xmark")
                    .fontWeight(.bold)
                    .foregroundColor(deadline>=Date.now ? .green : .red)
            }.padding().overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
            ).padding()
            HStack{
                Picker("Choose the category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }.accentColor(.black)
                Spacer()
                Image(systemName: "checkmark")
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }.padding().overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
            ).padding()
            Spacer()
            Button{
                if title.count != 0{
                    if deadline >= Date.now{
                        if selectedCategory.count != 0{
                            viewModel.title = title
                            viewModel.deadline = deadline
                            viewModel.category = selectedCategory
                            viewModel.saveTask()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            } label: {
                Text("Make New To Do")
                    .foregroundColor(title.count == 0 || deadline < Date.now || selectedCategory.count == 0 ? .gray : .white)
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.all)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black)
                            .padding(.horizontal)
                    )
            }.disabled(title.count == 0 || deadline < Date.now || selectedCategory.count == 0)
        }.navigationBarTitle("New To Do", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }.foregroundColor(.black)
                }
            })
    }
}

struct AddToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoListView()
    }
}
