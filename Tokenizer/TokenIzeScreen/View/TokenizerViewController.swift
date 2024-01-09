//
//  MainViewController.swift
//  Tokenizer
//
//  Created by Attaallah Ayman, Vodafone on 08/01/2024.
//

import UIKit
import Combine

final class TokenizerViewController: UIViewController {
    var sentences: [NSMutableAttributedString] = []
    var languages: [Language] = []
    private var cancellables: Set<AnyCancellable> = []
    private var currentLanguage: Language?

    private let rightLeftMargin: CGFloat = 16
    let viewModel: TokenizerViewModel

    //MARK: - UI Elements.
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 32)
        label.text = "Tokenizer"
        return label
    }()

    let inputTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemGray4
        textView.font = .systemFont(ofSize: 18)
        textView.setCorner(radius: 6)
        return textView
    }()

    lazy var generateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemMint
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Generate", for: .normal)
        button.setCorner(radius: 8)
        button.addTarget(self, action: #selector(generateTokens), for: .touchUpInside)
        return button
    }()

    lazy var sentencesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.setCorner(radius: 6)
        tableView.backgroundColor = .systemMint
        return tableView
    }()

    lazy var languagePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        picker.tintColor = .white
        picker.setCorner(radius: 8)
        return picker
    }()

    //MARK: - Lifecycle Methods.
    required init(viewModel: TokenizerViewModelProtocol) {
        self.viewModel = TokenizerViewModel(tokenizeEngine: TokenizeEngine())
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupUI()
        viewModel.viewDidLoad()
        addKeyboardDismissGesture()
        bindings()
    }

    //MARK: - Helper Functions.
    private func setupUI() {
        [titleLabel, inputTextView, generateButton, sentencesTableView, languagePicker]
            .forEach { view.addSubview($0)}

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rightLeftMargin),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -rightLeftMargin),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),

            inputTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: rightLeftMargin),
            inputTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rightLeftMargin),
            inputTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -rightLeftMargin),
            inputTextView.heightAnchor.constraint(equalToConstant: 160),

            sentencesTableView.topAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: 30),
            sentencesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rightLeftMargin),
            sentencesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -rightLeftMargin),
            sentencesTableView.heightAnchor.constraint(equalToConstant: 180),

            languagePicker.bottomAnchor.constraint(equalTo: generateButton.topAnchor, constant: -20),
            languagePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rightLeftMargin),
            languagePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -rightLeftMargin),
            languagePicker.heightAnchor.constraint(equalToConstant: 90),

            generateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            generateButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rightLeftMargin*2),
            generateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -rightLeftMargin*2),
            generateButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    private func addKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func endEditing() {
        view.endEditing(true)
    }

    @objc func generateTokens() {
        guard let currentLanguage else { return }
        viewModel.tokenize(text: inputTextView.text ?? "", for: currentLanguage)
    }

    private func bindings() {
        viewModel.$languages
            .receive(on: DispatchQueue.main)
            .sink { [weak self] languages in
                guard let self else { return }
                self.languages = languages
                self.languagePicker.reloadAllComponents()
                self.currentLanguage = languages.first
            }.store(in: &cancellables)

        viewModel.$sentences
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sentences in
                guard let self else { return }
                self.sentences = sentences
                self.sentencesTableView.reloadData()
            }.store(in: &cancellables)
    }
}

extension TokenizerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentLanguage = languages[row]
    }
}

extension TokenizerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        languages.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        languages[row].name()
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        30
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as? UILabel
        if label == nil {
            label = UILabel()
            label?.textColor = .systemMint
            label?.textAlignment = .center
            label?.font = .boldSystemFont(ofSize: 25)
        }

        label?.text = languages[row].name()
        return label ?? UIView()
    }
}

extension TokenizerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sentences.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.attributedText = sentences[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }
}
