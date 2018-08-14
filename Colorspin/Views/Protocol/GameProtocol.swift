//
//  GameProtocol.swift
//  Colorspin
//
//  Created by Anand Kumar on 8/13/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

/// Protocol to contain all necessary game lifecycle functions.
protocol Game {
    /// Begins the game from a fresh state.
    /// Supports transitioning to stop, pause, or restart functionality.
    func start()

    /// Stops the game entirely. Restart may or may not be triggered after stop.
    func stop()

    /// Pauses a game currently in-progress. Game can be resumed, stopped, or restarted.
    func pause()

    /// Resumes the game from a halted state and preserves the game state.
    func resume()

    /// Nukes the game state and refreshes all data.
    func restart()
}
