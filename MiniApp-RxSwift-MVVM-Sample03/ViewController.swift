//
//  ViewController.swift
//  MiniApp-RxSwift-MVVM-Sample03
//
//  Created by 近藤米功 on 2022/08/06.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

final class ViewController: UIViewController {

    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var validationLabel: UILabel!

    private lazy var viewModel = ViewModel(idTextObservable: idTextField.rx.text.asObservable(), passwordTextObservable: passwordTextField.rx.text.asObservable(), model: Model()
    )

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.validationText.bind(to: validationLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.loadLabelColor.bind(to: loadLabelColor).disposed(by: disposeBag)
    }

    private var loadLabelColor: Binder<UIColor>{
        return Binder(self) { me, color in
            me.validationLabel.textColor = color
        }
    }


}

