module Test.TestVec2 where

import Data.Array (zipWith)
import Effect (Effect)
import GLMatrix (epsilonEqualArrays)
import GLMatrix as GLMatrix
import GLMatrix.Vec2 (Vec2, add, angle, ceil, distance, divide, epsilonEquals, fromValues, length, numbers, scale, subtract)
import Math as Math
import Prelude (Unit, discard, map, ($), (/), (<$>), (<*>))
import Test.QuickCheck (class Arbitrary, arbitrary, quickCheck)

newtype ArbVec2
  = ArbVec2 Vec2

instance arbVec2 :: Arbitrary ArbVec2 where
  arbitrary = ArbVec2 <$> (fromValues <$> arbitrary <*> arbitrary)

testAdd :: Effect Unit
testAdd =
  quickCheck \(ArbVec2 v) ->
    let
      v1 = add v v

      v2 = scale v 2.0
    in
      epsilonEquals v1 v2

testAngleSame :: Effect Unit
testAngleSame = quickCheck \(ArbVec2 v) -> GLMatrix.epsilonEquals (angle v v) 0.0

testCeil :: Effect Unit
testCeil =
  quickCheck \x y ->
    let
      v = fromValues x y

      ceil1 :: Array Number
      ceil1 = numbers $ ceil v

      ceil2 :: Array Number
      ceil2 = map Math.ceil [ x, y ]
    in
      epsilonEqualArrays ceil1 ceil2

testDistance :: Effect Unit
testDistance =
  quickCheck \(ArbVec2 v1) (ArbVec2 v2) ->
    let
      d1 :: Number
      d1 = distance v1 v2

      d2 :: Number
      d2 = length $ subtract v1 v2
    in
      GLMatrix.epsilonEquals d1 d2

testDivide :: Effect Unit
testDivide =
  quickCheck \(ArbVec2 v1) (ArbVec2 v2) ->
    let
      v = divide v1 v2

      divided = zipWith (/) (numbers v1) (numbers v2)
    in
      epsilonEqualArrays divided (numbers v)

main :: Effect Unit
main = do
  testAdd
  testAngleSame
  testCeil
  testDistance
  testDivide
