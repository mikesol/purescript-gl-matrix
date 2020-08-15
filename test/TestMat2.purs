module Test.TestMat2 where

import Data.Foldable (sum)
import Effect (Effect)
import GLMatrix (epsilonEquals)
import GLMatrix.Mat2 (add, adjoint, determinant, equals, exactEquals, frob, fromValues, identity, multiplyScalar)
import Math (sqrt)
import Prelude (Unit, discard, map, show, ($), (&&), (*), (+), (/), (/=), (<>), (==))
import Test.QuickCheck (quickCheck, (<?>))

testAdd :: Effect Unit
testAdd =
  quickCheck \n ->
    let
      m = fromValues n n n n

      added = add m m

      multiplied = multiplyScalar m 2.0
    in
      added == multiplied && exactEquals added multiplied <?> "testAdd " <> show n

testNotEqual :: Effect Unit
testNotEqual = quickCheck \n -> multiplyScalar identity n /= multiplyScalar identity (n + 1.0)

testAdjoint :: Effect Unit
testAdjoint =
  quickCheck \n ->
    let
      m = identity

      m2 = multiplyScalar (multiplyScalar m n) (1.0 / n) -- somehow utilize n
    in
      equals (adjoint m) m2 <?> "testAdjoint " <> show n

testDeterminantZero :: Effect Unit
testDeterminantZero =
  quickCheck \m00 m01 ->
    determinant (fromValues m00 m01 m00 m01) == 0.0 <?> "testDeterminantZero " <> show [ m00, m01 ]

testDeterminantNonZero :: Effect Unit
testDeterminantNonZero =
  quickCheck \m00 m01 ->
    determinant (fromValues m00 m01 m01 m00) /= 0.0 <?> "testDeterminantZero " <> show [ m00, m01 ]

testFrob :: Effect Unit
testFrob =
  quickCheck \m00 m01 m10 m11 ->
    let
      xs = [ m00, m01, m10, m11 ]

      theFrob = frob (fromValues m00 m01 m10 m11)

      theSum = sqrt $ sum (map (\n -> n * n) xs)
    in
      epsilonEquals theFrob theSum <?> "testFrob " <> show xs <> " frob " <> show theFrob <> " sum " <> show theSum

main :: Effect Unit
main = do
  testAdd
  testNotEqual
  testAdjoint
  testDeterminantZero
  testDeterminantNonZero
  testFrob
