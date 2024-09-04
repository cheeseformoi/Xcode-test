import SwiftUI

struct ContentView: View {
    @State private var points: [CGPoint] = [] // Stores all points

    var body: some View {
        ZStack {
            Color.white
                //.edgesIgnoringSafeArea(.all)
                .onTapGesture { location in
                    points.append(location)
                }

            // Draw lines for every pair of points
            ForEach(0..<(points.count / 2), id: \.self) { index in
                let startPoint = points[index * 2]
                let endPoint = points[index * 2 + 1]

                Path { path in
                    path.move(to: startPoint)
                    path.addLine(to: endPoint)
                }
                .stroke(Color.blue, lineWidth: 4)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
