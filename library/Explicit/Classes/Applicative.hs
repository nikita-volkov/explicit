module Explicit.Classes.Applicative where

import Explicit.Prelude
import qualified Explicit.Classes.Functor as Functor
import qualified Explicit.Classes.Point as Point
import qualified Explicit.Classes.Ap as Ap


data Applicative m =
  Applicative {
    functorInstance :: Functor.Functor m,
    pointInstance :: Point.Point m,
    apInstance :: Ap.Ap m
  }

point :: Applicative m -> a -> m a
point =
  Point.point . pointInstance

ap :: Applicative m -> m (a -> b) -> (m a -> m b)
ap =
  Ap.ap . apInstance

map :: Applicative m -> (a -> b) -> (m a -> m b)
map =
  Functor.map . functorInstance

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
