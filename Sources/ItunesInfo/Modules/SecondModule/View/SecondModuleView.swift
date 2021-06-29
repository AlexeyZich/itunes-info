//
//  Created by Aleksey Ermolaev on 20/05/2021.
//

import UIKit

extension SecondModuleView {
    struct Appearance {
        let exampleOffset: CGFloat = 10
    }
}

class SecondModuleView: UIView {
    let appearance = Appearance()

    fileprivate(set) lazy var customView: UIView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews(){
        addSubview(customView)
    }

    func makeConstraints() {
    }

    func configure() {
        self.backgroundColor = .red
    }
}
