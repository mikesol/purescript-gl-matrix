module GLMatrix.Mat2 where

import Prelude
import Data.Function.Uncurried (Fn0, Fn1, Fn2, Fn4, runFn0, runFn1, runFn2, runFn4)
import Data.Tuple.Nested (Tuple3, tuple3)
import Partial.Unsafe (unsafePartial)

foreign import data Mat2 :: Type

foreign import js_fromValues :: Fn4 Number Number Number Number Mat2

-- |Create a new mat2 with the given values
fromValues :: Number -> Number -> Number -> Number -> Mat2
fromValues = runFn4 js_fromValues

foreign import js_add :: Fn2 Mat2 Mat2 Mat2

-- |Adds two mat2's
add :: Mat2 -> Mat2 -> Mat2
add = runFn2 js_add

foreign import js_adjoint :: Fn1 Mat2 Mat2

-- |Calculates the adjugate of a mat2
adjoint :: Mat2 -> Mat2
adjoint = runFn1 js_adjoint

foreign import js_determinant :: Fn1 Mat2 Number

-- |Calculates the determinant of a mat2
determinant :: Mat2 -> Number
determinant = runFn1 js_determinant

foreign import js_equals :: Fn2 Mat2 Mat2 Boolean

-- |Returns whether or not the matrices have approximately the same elements in the same position
equals :: Mat2 -> Mat2 -> Boolean
equals = runFn2 js_equals

foreign import js_exactEquals :: Fn2 Mat2 Mat2 Boolean

-- |Returns whether or not the matrices have exactly the same elements in the same position (when compared with ===)
exactEquals :: Mat2 -> Mat2 -> Boolean
exactEquals = runFn2 js_exactEquals

foreign import js_frob :: Fn1 Mat2 Number

-- |Returns Frobenius norm of a mat2
frob :: Mat2 -> Number
frob = runFn1 js_frob

foreign import js_fromRotation :: Fn1 Number Mat2

-- |Creates a matrix from a given angle This is equivalent to (but much faster than): mat2.identity(dest); mat2.rotate(dest, dest, rad);
fromRotation :: Number -> Mat2
fromRotation = runFn1 js_fromRotation

foreign import js_fromScaling :: Fn1 Number Mat2

-- |Creates a matrix from a vector scaling This is equivalent to (but much faster than): mat2.identity(dest); mat2.scale(dest, dest, vec);
fromScaling :: Number -> Mat2
fromScaling = runFn1 js_fromScaling

foreign import js_identity :: Fn0 Mat2

-- |Set a mat2 to the identity matrix
identity :: Mat2
identity = runFn0 js_identity

foreign import js_invert :: Fn1 Mat2 Mat2

-- |Inverts a mat2
invert :: Mat2 -> Mat2
invert = runFn1 js_invert

foreign import js_ldu :: Fn1 Mat2 (Array Mat2)

array3ToTuple :: forall a. Partial => Array a -> Tuple3 a a a
array3ToTuple [ a, b, c ] = tuple3 a b c

ldu :: Mat2 -> Tuple3 Mat2 Mat2 Mat2
ldu m = unsafePartial $ array3ToTuple $ runFn1 js_ldu m
