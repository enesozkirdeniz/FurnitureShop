//
//  HomeScreen.swift
//  ShoppingApp
//
//  Created by Enes Özkırdeniz on 6.08.2023.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var selectedIndex : Int = 0
    private let categories = ["All", "Chair", "Sofa", "Lamp", "Kitchen", "Table"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView (.vertical, showsIndicators: false) {
                    VStack (alignment: .leading) {
                        AppBarView()
                        
                        TagLineView()
                            .padding()
                        
                        Search()
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack{
                                ForEach(0 ..< categories.count) { i in
                                    CategoryView(isActive: i == selectedIndex, text: categories[i])
                                        .onTapGesture {
                                            selectedIndex = i
                                        }
                                }
                            }
                            .padding()
                        }
                        
                        Text("Popular")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 4) { index in
                                    NavigationLink(destination: DetailScreen(), label: {
                                        ProductCardView(image: Image("chair_\(index + 1)"),size: 210)
                                    })
                                    .navigationBarHidden(true)
                                    .foregroundColor(.black
                                    )
                                }
                                .padding(.trailing)
                            }
                            .padding(.leading)
                        }
                        
                        Text("Best")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 4) { index in
                                    ProductCardView(image: Image("chair_\(index + 1)"), size: 180)
                                }
                                .padding(.trailing)
                            }
                            .padding(.leading)
                        }
                        
                        
                        
                    }
                }
                
                HStack {
                    BottomNavBar(content: {Image(systemName: "house.fill") }) {}
                    
                    BottomNavBar(content: {Image(systemName: "heart") }) {}
                    
                    BottomNavBar(content: {Image(systemName: "cart") }) {}
                    
                    BottomNavBar(content: {Image(systemName: "person") }) {}
                }
                .padding()
                .background(Color.white)
                .clipShape(Capsule())
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.25), radius: 8, x: 2, y: 6)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}


struct AppBarView: View {
    var body: some View {
        HStack  {
            Button(action: {}) {
                Image("menu")
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(10.0)
            }
            
            Spacer()
            
            Button( action: {}) {
                Image("Profile")
                    .resizable()
                    .frame(width: 42, height: 42)
                    .cornerRadius(10.0)
            }
        }
        .padding(.horizontal)
    }
}

struct TagLineView: View {
    var body: some View {
        Text("Find the \nBest ")
            .font(.custom("PlayfairDisplay-Regular", size: 28))
            .foregroundColor(Color("Primary"))
        + Text("Furniture!")
            .font(.custom("PlayfairDisplay-Bold", size: 28))
            .foregroundColor(Color("Primary"))
            .fontWeight(.bold)
    }
}

struct Search: View {
    @State private var search : String = ""
    var body: some View {
        HStack {
            HStack {
                Image("Search")
                    .padding(.trailing, 8)
                TextField("Search Furniture", text: $search)
            }
            .padding(.all, 20)
            .background(Color.white)
            .cornerRadius(10.0)
            .padding(.horizontal)
            
        }
    }
}

struct CategoryView: View {
    let isActive : Bool
    let text: String
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 0) {
                Text(text)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundColor(isActive ? Color("Primary"): Color.black.opacity(0.5))
                
                if (isActive) {
                    Color("Primary")
                        .frame(width: 15, height: 2)
                        .clipShape(Capsule())
                }
            }
            .padding(.trailing)
        }
    }
}

struct ProductCardView: View {
    let image : Image
    let size : CGFloat
    var body: some View {
        VStack {
            image
                .resizable()
                .frame(width: size, height: 200 * (size / 210))
                .cornerRadius(20.0)
            
            Text("Luxury Swedian Chair")
                .font(.title3)
                .fontWeight(.bold)
            
            HStack (spacing: 2) {
                ForEach(0 ..< 5) { item in
                    Image("star")
                }
                Spacer()
                
                Text("$1299")
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
        .frame(width: 210)
        .padding()
        .background(Color.white)
        .cornerRadius(20.0)
    }
}

struct BottomNavBar<Content: View>: View {
    let content : () -> Content
    let action : ()-> Void
    var body: some View {
        Button(action: action){
            content()
                .imageScale(.large)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.brown)
                
        }
    }
}
