//
//  MovieCard.swift
//  Swiftui_movie
//
//  Created by Swipe on 30.07.2020.
//  Copyright © 2020 Liem Vo. All rights reserved.
//
import URLImage
import SwiftUI
import ModalView

struct MovieCard: View {
    
    var movie: Movie
    
    @State private var notificationDate = Date()
    
    @State var showModal = false
    
    
    var dateFormatter = DateFormatter()
    
    var calendar = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)
    
    init(movie: Movie) {
        self.movie = movie
        dateFormatter.dateStyle = .short
        
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // Main Featured Image - Upper Half of Card
            URLImage(URL(string:  "\(BASE_IMAGE_URL)\(movie.poster_path)")!)
            { proxy in
                proxy.image.resizable()
            }
            .scaledToFill()
            .frame(minWidth: nil, idealWidth: nil, maxWidth: UIScreen.main.bounds.width, minHeight: 300, idealHeight: nil, maxHeight: 300, alignment: .center)
            .clipped()
            
            // Under image part of the movie card
            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .fontWeight(Font.Weight.heavy)
                Text(movie.overview)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(Font.custom("HelveticaNeue-Bold", size: 16))
                    .foregroundColor(Color.gray)
                    .lineLimit(nil)
                
                
                
                // Movie release date and rating
                HStack(alignment: .center, spacing: 6) {
                    
                    HStack {
                        Text(movie.release_date).foregroundColor(.gray)
                        Spacer()
                        Text("Rate: \(movie.vote_average.format())/10")
                    }
                    Spacer()
                    
                }
                .padding([.top, .bottom], 8)
                
                // Horizontal Line separating details and scheduling
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: nil, height: 1, alignment: .center)
                    .padding([.leading, .trailing], -12)
                
                // Schedule viewing modal view toggle button
                HStack(alignment: .center, spacing: 4) {
                    Button(action: { self.showModal.toggle() }) { // Button to show the modal view by toggling the state
                        Text("Schedule viewing")
                            .fontWeight(Font.Weight.heavy)
                            .foregroundColor(Color(red: 231/255, green: 119/255, blue: 112/255))
                    }.sheet(isPresented: $showModal, onDismiss: registerNotification, content:  { // Passing the state to the sheet API
                        
                        RKViewController(isPresented: self.$showModal, rkManager: self.calendar)})
                    Spacer()
                    
                    Text(dateFormatter.string(from: calendar.selectedDate ?? Date()))
                    
                }.padding([.top, .bottom], 8)
                
            }
            .padding(12)
            
        }
        .background(Color.white)
        .cornerRadius(15)
        .padding(12)
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
    }
    
    func registerNotification(){
        let uuidString = UUID().uuidString
        
        let content = UNMutableNotificationContent()
        content.title = movie.title
        content.body = "Don't forget to watch this movie today"
        
        let comps =  Calendar.current.dateComponents([.month, .day,.hour,.minute,.second],from: Date().addingTimeInterval(60*60*10+1))
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
                print(error)
            }
        }
        print(trigger.nextTriggerDate())
    }
}



extension Float {
    func format() -> String {
        return String(format: "%.2f",self)
    }
}
