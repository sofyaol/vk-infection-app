//
//  CreateGroupViewController.swift
//  vk-infection-app
//
//  Created by Sofya Olekhnovich on 25.03.2024.
//

import UIKit

class CreateGroupViewController: UIViewController {
    
    var viewModel: CreateGroupViewModel
    
    // MARK: - UI Elements
    
    var groupSizeInputField: GroupPropertyInputField = {
        var groupSizeInputField = GroupPropertyInputField(placeholder: "Размер группы")
        return groupSizeInputField
    }()
    
    var infectionFactorInputField: GroupPropertyInputField = {
        var infectionFactorInputField = GroupPropertyInputField(placeholder: "Фактор инфекции")
        return infectionFactorInputField
    }()
    
    var timeIntervalInputField: GroupPropertyInputField = {
        var infectionFactorInputField = GroupPropertyInputField(placeholder: "Время заражения, сек")
        return infectionFactorInputField
    }()
    
    var groupSizeValidationMessage: ValidationMessageLabel = {
        var groupSizeValidationMessage = ValidationMessageLabel()
        return groupSizeValidationMessage
    }()
    
    var infectionFactorValidationMessage: ValidationMessageLabel = {
        var infectionFactorValidationMessage = ValidationMessageLabel()
        return infectionFactorValidationMessage
    }()
    
    var timeIntervalValidationMessage: ValidationMessageLabel = {
        var timeIntervalValidationMessage = ValidationMessageLabel()
        return timeIntervalValidationMessage
    }()
    
    var launchButton: UIButton = {
        var launchButton = UIButton()
        launchButton.setTitle("Запустить моделирование", for: .normal)
        launchButton.backgroundColor = .systemBlue
        launchButton.layer.cornerRadius = DefaultButtonConstants.cornerRadius
        launchButton.addTarget(self, action: #selector(launchButtonTapped), for: .touchUpInside)
        return launchButton
    }()
    
    var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = CreateGroupViewConstants.defaultSpacing
        return stackView
    }()
    
    // MARK: - Inits
    
    init(viewModel: CreateGroupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    @objc private func launchButtonTapped() {
        setValidationMessages(groupSizeMessage: nil, infectionFactorMessage: nil, timeIntervalMessage: nil)
        
        viewModel.launchGroupModeling(groupSize: groupSizeInputField.text, infectionFactor: infectionFactorInputField.text, timeInterval: timeIntervalInputField.text) { validationErrors in
            
            setValidationMessages(groupSizeMessage: validationErrors[0]?.rawValue, infectionFactorMessage: validationErrors[1]?.rawValue, timeIntervalMessage: validationErrors[2]?.rawValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
    
    private func setValidationMessages(groupSizeMessage: String?, infectionFactorMessage: String?, timeIntervalMessage: String?) {
        groupSizeValidationMessage.text =  groupSizeMessage ?? ""
        infectionFactorValidationMessage.text = infectionFactorMessage ?? ""
        timeIntervalValidationMessage.text = timeIntervalMessage ?? ""
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        stackView.addArrangedSubview(groupSizeInputField)
        stackView.addArrangedSubview(groupSizeValidationMessage)
        
        stackView.addArrangedSubview(infectionFactorInputField)
        stackView.addArrangedSubview(infectionFactorValidationMessage)
        
        stackView.addArrangedSubview(timeIntervalInputField)
        stackView.addArrangedSubview(timeIntervalValidationMessage)
        
        stackView.setCustomSpacing(CreateGroupViewConstants.buttonSpacing, after: timeIntervalValidationMessage)
        stackView.addArrangedSubview(launchButton)
        
        view.addSubview(stackView)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: CreateGroupViewConstants.stackCenterAnchorOffset),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CreateGroupViewConstants.leadingContentOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CreateGroupViewConstants.trailingContentOffset),
            
            launchButton.heightAnchor.constraint(equalToConstant: DefaultButtonConstants.height)
        ])
    }
}
