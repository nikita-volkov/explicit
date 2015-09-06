module Explicit.Applicative where

import Explicit.Prelude
import qualified Explicit.Functor as Functor
import qualified Explicit.Point as Point
import qualified Explicit.Ap as Ap


data Applicative m =
  Applicative !(Functor.Functor m) !(Point.Point m) !(Ap.Ap m)

toFunctor :: Applicative m -> Functor.Functor m
toFunctor =
  \(Applicative x _ _) -> x

toPoint :: Applicative m -> Point.Point m
toPoint =
  \(Applicative _ x _) -> x

toAp :: Applicative m -> Ap.Ap m
toAp =
  \(Applicative _ _ x) -> x

point :: Applicative m -> a -> m a
point =
  Point.point . toPoint

ap :: Applicative m -> m (a -> b) -> (m a -> m b)
ap =
  Ap.ap . toAp

map :: Applicative m -> (a -> b) -> (m a -> m b)
map =
  Functor.map . toFunctor

map2 :: Applicative m -> (a -> b -> c) -> (m a -> m b -> m c)
map2 =
  \x aToBToC mA mB -> ap x (map x aToBToC mA) mB

map3 :: Applicative m -> (a -> b -> c -> d) -> (m a -> m b -> m c -> m d)
map3 =
  \x aToBToCToD mA mB mC ->
    let
      mBToCToD = map x aToBToCToD mA
      mCToD = ap x mBToCToD mB
      mD = ap x mCToD mC
      in mD
