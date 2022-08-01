//
//  HomeViewController.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import AVFoundation
import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    private let homeView = HomeView.init()
    private let homeViewModel = AppContainer.shared.resolve(HomeViewModel.self)!
    private var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        homeView.chartsCollectionView.delegate = self
        homeView.chartsCollectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        setViewModelBinds()
        setTextField()
        setupButtons()
    }

    private func setViewModelBinds() {
        homeViewModel.charts.bindWithoutFire { _ in
            DispatchQueue.main.async {
                self.homeView.chartsCollectionView.reloadData()
            }
        }
        homeViewModel.artists.bindWithoutFire { _ in
            DispatchQueue.main.async {
                self.homeView.chartsCollectionView.reloadData()
            }
        }
        homeViewModel.musics.bindWithoutFire { _ in
            DispatchQueue.main.async {
                self.homeView.chartsCollectionView.reloadData()
            }
        }
        homeViewModel.isSingerButtonChecked.bindWithoutFire { checked in
            self.homeView.singerButton.setup(checked: checked)
            self.homeView.musicButton.setup(checked: !checked)
        }
        homeViewModel.isMusicButtonChecked.bindWithoutFire { checked in
            self.homeView.singerButton.setup(checked: !checked)
            self.homeView.musicButton.setup(checked: checked)
        }
        homeViewModel.currentUser.bindWithoutFire { user in
            DispatchQueue.main.async {
                self.homeView.name = user.fullName
                self.homeView.setupTexts()
            }
        }
        homeViewModel.collectionViewTitle.bindWithoutFire { title in
            DispatchQueue.main.async {
                self.homeView.chartsTitleText = title
                self.homeView.setupTexts()
            }
        }
        homeViewModel.getCharts()
        homeViewModel.getUserData()
    }

    private func setTextField() {
        homeView.searchField.delegate = self
        homeView.searchField.addTarget(self, action: #selector(textFieldDidChange), for:  UIControl.Event.editingChanged)
    }

    private func setupButtons() {
        homeView.singerButton.addTarget(self, action: #selector(singerTapped), for: .touchDown)
        homeView.musicButton.addTarget(self, action: #selector(musicTapped), for: .touchDown)
    }
}

extension HomeViewController {
    @objc private func textFieldDidChange() {
        guard let text = homeView.searchField.text else { return }
        homeViewModel.textFieldDidChange(text)
    }

    @objc private func singerTapped() {
        homeViewModel.singerTapped()
    }

    @objc private func musicTapped() {
        homeViewModel.musicTapped()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showsCharts() { return homeViewModel.chartsSize }
        else if showsArtists() { return homeViewModel.artistsSize }
        else if showsMusics() { return homeViewModel.musics.value?.data?.count ?? 0 }
        else { return 0 }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if showsCharts() {
            return setupChartsCell(collectionView: collectionView, indexPath: indexPath)
        } else if showsArtists() {
            return setupArtistCell(collectionView: collectionView, indexPath: indexPath)
        } else if showsMusics() {
            return setupMusicCell(collectionView: collectionView, indexPath: indexPath)
        } else {
            return setupErrorCell(collectionView: collectionView, indexPath: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Dimen.cellSize, height: Dimen.cellSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if showsCharts() {
            guard let charts = homeViewModel.charts.value,
                  let music = charts.data,
                  let url = music[indexPath.row].preview else { return }
            startAudio(url: url)
        } else if showsMusics() {
            guard let musics = homeViewModel.musics.value,
                  let music = musics.data,
                  let url = music[indexPath.row].preview else { return }
            startAudio(url: url)
        }
    }

    private func showsCharts() -> Bool {
        homeViewModel.showsCharts.value
    }

    private func showsArtists() -> Bool {
        homeViewModel.showsArtists.value
    }

    private func showsMusics() -> Bool {
        homeViewModel.showsMusics.value
    }

    private func setupChartsCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as? MusicCollectionViewCell,
              let charts = homeViewModel.charts.value, let music = charts.data, let url = music[indexPath.row].album?.cover_big else {
            return UICollectionViewCell()
        }
        cell.setup(url: url)
        return cell
    }

    private func setupArtistCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as? MusicCollectionViewCell,
              let artist = homeViewModel.artists.value?.artists, let url = artist[indexPath.row].picture_big else {
            return UICollectionViewCell()
        }
        cell.setup(url: url)
        return cell
    }

    private func setupMusicCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as? MusicCollectionViewCell,
              let musics = homeViewModel.musics.value, let music = musics.data, let url = music[indexPath.row].album?.cover_big else {
            return UICollectionViewCell()
        }
        cell.setup(url: url)
        return cell
    }

    private func setupErrorCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as? MusicCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(image: .happyMusic)
        return cell
    }
}

extension HomeViewController {
    private func startAudio(url: String) {
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
            let sound = URL.init(string: url)
            let playerItem = AVPlayerItem.init(url: sound!)
            self.player = AVPlayer.init(playerItem: playerItem)
            setupAVPlayer()
            self.player!.play()
    }

    @objc private func audioDidEnded(){
        NotificationCenter.default.removeObserver(self)
    }

    private func setupAVPlayer() {
        player!.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)
        self.player!.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as AnyObject? === self.player! {
            if player!.timeControlStatus == .playing {
               
            }
        }
    }
}

extension HomeViewController: Navigation {
    func setupNavigationBar() {
        navigationController?.navigationItem.hidesBackButton = true
    }
}

