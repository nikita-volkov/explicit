module Explicit.Applicative where

import Explicit.Prelude
import qualified Explicit.Functor as Functor
import qualified Explicit.Point as Point
import qualified Explicit.Ap as Ap


type Applicative m =
  (Functor.Functor m, Point.Point m, Ap.Ap m)

toFunctor :: Applicative m -> Functor.Functor m
toFunctor =
  \(x, _, _) -> x

toPoint :: Applicative m -> Point.Point m
toPoint =
  \(_, x, _) -> x

toAp :: Applicative m -> Ap.Ap m
toAp =
  \(_, _, x) -> x
