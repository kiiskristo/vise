//
//  ToastView.swift
//  LeFood
//
//  Created by Kristo Kiis on 06.08.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import SwiftUI

enum ToastState {
    case minimized
    case loading
    case error
    case approved
    case disabled
}

struct ToastView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var state: ToastState
    let pub = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
    var onClosed: (() -> Void)
    @State private var isPasteAble = false

    var buttonColor: Color {
        return isPasteAble ? .yellow : .gray
    }

    var body: some View {
        HStack {
            ZStack(alignment: .topTrailing) {
                VisualEffectView(effect: UIBlurEffect(style: colorScheme == .dark ? .light : .dark))
                    .cornerRadius(10)
                if self.state == .minimized {
                    HStack {
                        Text("Oled Facebooki sõber?")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                withAnimation {
                                    self.state = ToastState.disabled
                                }
                            }
                        Button(action : {
                            withAnimation {
                                self.onClosed()
                            }
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                            Text("")
                        }.frame(width: 40, height: 40, alignment: .center)
                    }.padding(10)
                }
                 else {
                    VStack(alignment: .trailing) {
                        Button(action : {
                            withAnimation {
                                self.state = ToastState.minimized
                            }
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                            Text(" ")
                        }
                        .frame(width: 55, height: 60, alignment: .center)
                        VStack {
                            if state == .loading {
                                ActivityIndicator(isAnimating: .constant(true), style: .large)
                                .padding()
                            } else if state == .error {
                                Text("😭")
                                    .font(.largeTitle)
                                    .padding([.top, .bottom], 30)
                                Text("Tekkis viga pildi tuvastamisel, proovi palun uuesti!")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.bottom], 30).multilineTextAlignment(.leading)
                            } else {
                                Text("Facebooki sõpradele kehtib meil soodustus!")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 10).multilineTextAlignment(.leading)
                                HStack {
                                    Text("• Pane like meie")
                                        .foregroundColor(.white)
                                    Button("Facebooki lehele") {
                                        UIApplication.tryURL(urls: [
                                            "fb://page/?id=120685067963808",
                                            "http://www.facebook.com/Suveterrass"
                                        ])
                                    }.foregroundColor(.yellow)
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 10)
                                Text("• Tee screenshot, kui oled likenud")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 10)
                                Text("• Kopeeri pilt käsklusega copy")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 10)
                                    .padding(.bottom, 30)
                            }
                            Button(action: {
                                self.pasteImage()
                            }) {
                                Text("Kleebi")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                }.disabled(!self.isPasteAble)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(buttonColor)
                            .cornerRadius(40)

                        }
                        .padding([.leading, .trailing ], 30)
                        .padding(.bottom, 30)
                        .padding(.top, -40)
                    }
                }
            }.fixedSize(horizontal: false, vertical: true)
            .padding(10)
                .padding(.bottom, self.state == .minimized ? 80 : 10)
            .onReceive(pub) { output in
                self.isPasteAble = UIPasteboard.general.hasImages
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: self.state == .minimized ? .bottom : .center)
        .background(Color.black.opacity(self.state == .minimized ? 0 : 0.7))
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

extension ToastView {
    func pasteImage() {
        guard isPasteAble else { return }
        isPasteAble = false
        state = .loading
        debugPrint("Kleebitud")
        TextRecognition.recognizeText(from: UIPasteboard.general.image?.cgImage, checkString: "Liked") { found in
            if found {
                debugPrint("Leitud")
                self.onClosed()
            } else {
                self.state = .error
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.state = .disabled
                }
            }
        }
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(state: .error, onClosed: {
            debugPrint("Closed")
        })
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        uiView.color = .white
    }
}

extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                application.open(URL(string: url)!, options: [:], completionHandler: nil)
                return
            }
        }
    }
}
