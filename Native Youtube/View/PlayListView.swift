//
//  PlayListSidebarMain.swift
//  Native Youtube
//
//  Created by Aayush Pokharel on 2021-05-23.
//

import SwiftUI


struct PlayListView: View {
    @EnvironmentObject var data: YTData
    @State var showing_playlist_id: Bool = true
    @AppStorage("apiKey") var apiKey = ""
    @State var apiInput = ""
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                
                ForEach(data.videos, id:\.self.title) { vid in
                    VideoRow(video: vid)
                        .contextMenu(ContextMenu(menuItems: {
                            VStack{
                                Button(action: {
                                    let shellProcess = Process();
                                                      shellProcess.launchPath = "/bin/bash";
                                                      shellProcess.arguments = [
                                                          "-l",
                                                          "-c",
                                                          // Important: this must all be one parameter to make it work.
                                                          "mpv \(vid.url) --no-video",
                                                      ];
                                                      shellProcess.launch();
                                }, label: {
                                    Text("Play Music")
                                })
                                Button(action: {
                                    let shellProcess = Process();
                                                      shellProcess.launchPath = "/bin/bash";
                                                      shellProcess.arguments = [
                                                          "-l",
                                                          "-c",
                                                          // Important: this must all be one parameter to make it work.
                                                          "mpv \(vid.url)",
                                                      ];
                                                      shellProcess.launch();
                                }, label: {
                                    Text("Play Video")
                                })
                            }
                        }))
                        .padding(.vertical, 5)
                    
                }
                ChangeIdView()
                    .environmentObject(data)
                HStack{
                    TextField("API KEY", text: $apiInput)
                        .textFieldStyle(PlainTextFieldStyle())
                        .underlineTextField(color: .orange)
                    
                    CustomButton(image: "chevron.left.slash.chevron.right", color: .orange)
                    .frame(width: 50)
                        .onTapGesture {
                            if apiInput.count == 39{                                
                            apiKey = apiInput
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
