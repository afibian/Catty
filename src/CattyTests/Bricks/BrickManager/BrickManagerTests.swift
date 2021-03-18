/**
 *  Copyright (C) 2010-2021 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

import XCTest

@testable import Pocket_Code

final class BrickManagerTests: XCTestCase {

    func testSizeForBrick() {
        let brick = SetVariableBrick()
        let brickCell = brick.brickCell()

        let size = BrickManager.shared()?.size(forBrick: brick)
        XCTAssertEqual(UIScreen.main.bounds.size.width, size?.width)
        XCTAssertEqual(brickCell?.cellHeight(), size?.height)
    }

    func testRecentlyUsedBricks() {
        let recentArray: [Brick.Type] = [
            AskBrick.self,
            SetBackgroundBrick.self,
            NextLookBrick.self,
            PreviousLookBrick.self,
            SetLookBrick.self,
            PenDownBrick.self,
            PenUpBrick.self,
            SetRotationStyleBrick.self,
            StitchBrick.self,
            SetLookByIndexBrick.self
        ]

        Util.resetRecentlyUsedBricks()
        let script = Script()
        var i: UInt = 0
        for cls in recentArray {
            script.add(cls.init(), at: i)
            i += 1
        }

        let recentBricks = BrickManager.shared()?.selectableBricks(for: kBrickCategoryType(rawValue: 0)!)
        XCTAssertEqual(recentArray.count, recentBricks?.count)
        for (ref, res): (AnyClass, Brick) in zip(recentArray.reversed(), recentBricks as! [Brick]) {
            XCTAssertTrue(ref === type(of: res))
        }
        Util.resetRecentlyUsedBricks()
    }
}
