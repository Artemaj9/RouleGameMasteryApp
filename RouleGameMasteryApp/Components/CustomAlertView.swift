//
//  CustomAlertView.swift
//

import SwiftUI

struct CustomAlertView<Content: View>: View {

    @Environment(\.colorScheme) var colorScheme

    let title: String
    let description: String
    let material: Material

    var cancelAction: (() -> Void)?
    var cancelActionTitle: String?

    var primaryAction: (() -> Void)?
    var primaryActionTitle: String?

    var customContent: Content?


    init(title: String,
         description: String,
         material: Material,
         cancelAction: (() -> Void)? = nil,
         cancelActionTitle: String? = nil,
         primaryAction: (() -> Void)? = nil,
         primaryActionTitle: String? = nil,
         customContent: Content? = EmptyView()) {
        self.title = title
        self.description = description
        self.material = material
        self.cancelAction = cancelAction
        self.cancelActionTitle = cancelActionTitle
        self.primaryAction = primaryAction
        self.primaryActionTitle = primaryActionTitle
        self.customContent = customContent
    }

    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 0) {
                Text(title)
                    .multilineTextAlignment(.center)
                    .rouleFont(size: 17, style: .cambayB, color: .white)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top)
                    .padding(.bottom, 8)
                    .foregroundStyle(.white)

                Text(description)
                    .rouleFont(size: 13, style: .cambayR, color: .white)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding([.bottom, .trailing, .leading])
                    .foregroundStyle(.white)

                customContent

                Divider()

                HStack {
                    if let cancelAction, let cancelActionTitle {
                        Button { cancelAction() } label: {
                            Text(cancelActionTitle)
                            .rouleFont(size: 17, style: .cambayR, color: Color(hex: "0A84FF"))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        }
                    }

                    if cancelActionTitle != nil && primaryActionTitle != nil {
                        Divider()
                    }

                    if let primaryAction, let primaryActionTitle {
                        Button { primaryAction() } label: {
                            Text("**\(primaryActionTitle)**")
                            .rouleFont(size: 17, style: .cambayB, color: Color(hex: "FD1354"))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        }
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .center)
            }
            .frame(minWidth: 0, maxWidth: 400, alignment: .center)
            .background(material)
            .cornerRadius(10)
            .padding([.trailing, .leading], 50)
        }
        .zIndex(1)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.4))
    }
}
