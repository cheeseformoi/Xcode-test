import SwiftUI

struct ContentView: View {
    @State private var startPoint: CGPoint = .zero // Stores the start of the line
    @State private var endPoint: CGPoint = .zero   // Stores the current end of the line
    @State private var isDragging: Bool = false    // Track if we're currently dragging
    @State private var lines: [(CGPoint, CGPoint, CGPoint)] = [] // Store completed lines, with (startPoint, adjustedEndPoint, actualEndPoint)
    
    let circleRadius: CGFloat = 20 // Radius of the circle at the endpoint
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if !isDragging {
                                // Start the drag
                                startPoint = value.startLocation
                                isDragging = true
                            }
                            // Update the end point as the drag continues (no adjustment yet)
                            endPoint = value.location
                        }
                        .onEnded { _ in
                            // Finalize the line when the drag ends by adjusting to the circle perimeter
                            let adjustedEndPoint = lineEndPoint(start: startPoint, end: endPoint, radius: circleRadius)
                            lines.append((startPoint, adjustedEndPoint, endPoint)) // Store both adjusted and actual end points
                            isDragging = false
                        }
                )

            // Draw all finalized lines and circles
            ForEach(0..<lines.count, id: \.self) { index in
                let line = lines[index]
                drawLineWithCircle(start: line.0, adjustedEnd: line.1, actualEnd: line.2)
            }

            // Draw the line currently being dragged (directly to the cursor)
            if isDragging {
                Path { path in
                    path.move(to: startPoint)
                    path.addLine(to: endPoint)
                }
                .stroke(Color.red, style: StrokeStyle(lineWidth: 4, lineCap: .round))
            }
        }
    }
    
    // Function to calculate the point where the line hits the perimeter of the circle
    func lineEndPoint(start: CGPoint, end: CGPoint, radius: CGFloat) -> CGPoint {
        let dx = end.x - start.x
        let dy = end.y - start.y
        let distance = sqrt(dx * dx + dy * dy)
        
        // Calculate the point at the edge of the circle
        let ratio = (distance - radius) / distance
        return CGPoint(x: start.x + dx * ratio, y: start.y + dy * ratio)
    }
    
    // Function to draw the line and the circle
    func drawLineWithCircle(start: CGPoint, adjustedEnd: CGPoint, actualEnd: CGPoint) -> some View {
        return ZStack {
            // Draw the line (already adjusted to the circle's perimeter)
            Path { path in
                path.move(to: start)
                path.addLine(to: adjustedEnd)
            }
            .stroke(Color.red, style: StrokeStyle(lineWidth: 4, lineCap: .round))
            
            // Draw the circle at the actual end point
            Circle()
                .stroke(Color.red, lineWidth: 4) // Outline of the circle
                .frame(width: circleRadius * 2, height: circleRadius * 2)
                .position(actualEnd) // Position the circle at the actual endpoint (cursor's location)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
