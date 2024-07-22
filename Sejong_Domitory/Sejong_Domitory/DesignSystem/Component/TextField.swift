import SwiftUI

struct LoginTextfieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 50)
                Divider()
                    .frame(height: 1)
                    .background(Color.sejonggray)
                    .padding(.horizontal, 15)
            }
            // 텍스트필드
            configuration
                .font(.system(size: 12, weight: .bold))
                .padding(.leading, 20)
                .autocorrectionDisabled()
        }
    }
}


// 사용법

//TextField("입력", text: $inputText)
//    .textFieldStyle(CommonTextfieldStyle())
