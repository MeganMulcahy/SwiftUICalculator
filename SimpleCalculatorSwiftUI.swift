import SwiftUI
enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, . multiply, .divide, .equal:
            return .pink
        case .clear, .negative, .percent:
            return .pink
        default:
            return Color(UIColor(red: 255/255.0, green: 182/255.0, blue: 193/255.0, alpha: 1))
        }
    }
}
enum Operation {
    case add, subtract, multiply, divide, none
}
struct ContentView: View {
    @State var value = "0"
    @State var runningNum = 0.0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .divide],
        [.one, .two, .three, .multiply],
        [.four, .five, .six, .subtract],
        [.seven, .eight, .nine, .add],
        [.zero, .equal]
    ]
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                Spacer()
                Text(value)
                    .bold()
                    .font(.system(size: 74))
                    .foregroundColor(.white)
                }
                .padding()
                
                
                //Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 10) {
                    ForEach(row, id: \.self) { item in
                        Button(action: {
                            self.tap(button: item)
                        }, label: {
                            Text(item.rawValue)
                                .font(.system(size:32))
                                .frame(width: self.buttonWidth(item: item),
                                       height: self.buttonHeight() )
                                .background(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        })
                    }
                }
                    .padding(.bottom, 2)
              }
            }
        }
    }
    func tap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNum = Double(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNum = Double(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNum = Double(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNum = Double(self.value) ?? 0
            }
            else if button == .equal {
                let runningVal = self.runningNum
                let currentVal = Double(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningVal + currentVal)"
                case .subtract:
                    self.value = "\(runningVal - currentVal)"
                case .multiply:
                    self.value = "\(runningVal * currentVal)"
                case .divide:
                    self.value = "\(runningVal / currentVal)"
                case .none:
                    break
                }
            }
            if button != .equal {
                if button != .negative
                {
                    if button != .percent
                    {
                        self.value = "0"
                    }
                }
            }
        case .clear:
            self.value = "0"
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else  {
                self.value = "\(self.value)\(number)"
            }
        }//end of switch
    }
    func buttonWidth(item: CalcButton) -> CGFloat
    {
        if item == .zero {
            return (UIScreen.main.bounds.width - (4*12)) / 4 * 3.2
        }
        if item == .clear {
            return (UIScreen.main.bounds.width - (4*12)) / 4 * 3.2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight() ->CGFloat
    {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}
