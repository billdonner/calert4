import SwiftUI
import AVFoundation


// Outer content view that presents MainView as a sheet
struct ContentView: View {
  @State private var showMainView = false

  var body: some View {
      VStack {
          Button(action: {
              showMainView = true
          }) {
              Text("Open Main View")
                  .padding()
                  .background(Color.blue)
                  .foregroundColor(.white)
                  .cornerRadius(8)
          }
          .sheet(isPresented: $showMainView) {
              MainView(showSheet: $showMainView)
          }
      }
  }
}

// Main view with buttons to present different alerts and a switch to control dismissal behavior
struct MainView: View {
  @Binding var showSheet: Bool
  @State private var dismissToRoot = false
  @State private var showYouWinAlert = false
  @State private var showYouLoseAlert = false
  @State private var showAnsweredAlert = false
  @State private var showHintAlert = false

  var body: some View {
      VStack(spacing: 20) {
          Toggle(isOn: $dismissToRoot) {
              Text("Dismiss to ContentView")
          }
          .padding()

          Button(action: {
              showYouWinAlert = true
          }) {
              Text("Show You Win Alert")
                  .customButtonStyle(backgroundColor: .blue)
          }
          .youWinAlert(isPresented: $showYouWinAlert, title: "You Win!", bodyMessage: "7 moves - Great Job!\nYou've won 12 games so far!", buttonTitle: "Dismiss") {
              handleDismissal()
          }

          Button(action: {
              showYouLoseAlert = true
          }) {
              Text("Show You Lose Alert")
                  .customButtonStyle(backgroundColor: .red)
          }
          .youLoseAlert(isPresented: $showYouLoseAlert, title: "You Lose", bodyMessage: "Unfortunately you have no valid moves.\nTry Again!", buttonTitle: "Dismiss") {
              handleDismissal()
          }

          Button(action: {
              showAnsweredAlert = true
          }) {
              Text("Show Answered Alert")
                  .customButtonStyle(backgroundColor: .green)
          }
          .answeredAlert(isPresented: $showAnsweredAlert, title: "Answered Alert", message: "This is an alert with easeInOut animation.", buttonTitle: "Dismiss") {
              handleDismissal()
          }

          Button(action: {
              showHintAlert = true
          }) {
              Text("Show Hint Alert")
                  .customButtonStyle(backgroundColor: .orange)
          }
          .hintAlert(isPresented: $showHintAlert, title: "Hint Alert", message: "This is an alert with spring animation.", buttonTitle: "Dismiss", onButtonTapped: {
              handleDismissal()
          }, animation: .spring())
      }
      .padding()
  }

  private func handleDismissal() {
      if dismissToRoot {
          withAnimation(.easeInOut(duration: 1.25)) { // Slower dismissal
              showSheet = false
          }
      } else {
          showYouWinAlert = false
          showYouLoseAlert = false
          showAnsweredAlert = false
          showHintAlert = false
      }
  }
}

// Helper function to style buttons
extension View {
  func customButtonStyle(backgroundColor: Color) -> some View {
      self
          .padding()
          .background(backgroundColor)
          .foregroundColor(.white)
          .cornerRadius(8)
  }
}

// Entry point of the app
@main
struct CustomAlertApp: App {
  var body: some Scene {
      WindowGroup {
          ContentView()
      }
  }
}
