import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("1")
            .font(.system(size: 72)) // Adjust the font size as needed
            .fontWeight(.bold)       // Optional: Make the text bold
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Expand to fill the screen
            .background(Color.white)  // Set background color (optional)
            .foregroundColor(.black)  // Set text color (optional)
            .edgesIgnoringSafeArea(.all) // Make sure the content fills the screen
    }
}

#Preview {
    ContentView()
}
