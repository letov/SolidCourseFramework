//
//  Area.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 17.04.2022.
//

import Foundation
import simd

class Area {
    typealias BlockCoord = (x: Int, y: Int)
    var table: [[[Int]]]
    var width: Int
    var height: Int
    var xCount: Int
    var yCount: Int
    var blockWidth: Int {
        width / xCount
    }
    var blockHeight: Int {
        height / yCount
    }
    init(width: Int, height: Int, xCount: Int, yCount: Int) {
        table = [[[Int]]].init(repeating: [[Int]].init(repeating: [Int](), count: yCount), count: xCount)
        self.width = width
        self.height = height
        self.xCount = xCount
        self.yCount = yCount
    }
    func coordToBlockCoordX(x: Int) -> Int {
        return x / blockWidth
    }
    func coordToBlockCoordY(y: Int) -> Int {
        return y / blockHeight
    }
    func getBlockCoord(point: simd_int2) -> BlockCoord
    {
        return BlockCoord(x: coordToBlockCoordX(x: Int(point.x)), y: coordToBlockCoordY(y: Int(point.y)))
    }
    func getNearBlocks(coord: BlockCoord) -> [BlockCoord] {
        var result = [BlockCoord]()
        if (coord.x > 0) {
            result.append(BlockCoord(x: coord.x - 1, y: coord.y))
        }
        if (coord.y > 0) {
            result.append(BlockCoord(x: coord.x, y: coord.y - 1))
        }
        if (coord.x < xCount) {
            result.append(BlockCoord(x: coord.x + 1, y: coord.y))
        }
        if (coord.y < yCount) {
            result.append(BlockCoord(x: coord.x, y: coord.y + 1))
        }
        return result
    }
    func removeObjectId(objectId: Int, coord: BlockCoord) {
        table[coord.x][coord.y] = table[coord.x][coord.y].filter { $0 != objectId}
    }
    func updateTable(m: Movable, objectId: Int) throws {
        let point = try m.getPosition().value
        let coord = getBlockCoord(point: point)
        let nearBlocks = getNearBlocks(coord: coord)
        nearBlocks.forEach {
            removeObjectId(objectId: objectId, coord: $0);
        }
        table[coord.x][coord.y].append(objectId)
    }
    func getNearObjectIds(m: Movable, objectId: Int) throws -> [Int]  {
        let point = try m.getPosition().value
        let coord = getBlockCoord(point: point)
        return table[coord.x][coord.y].filter { $0 != objectId }
    }
}
