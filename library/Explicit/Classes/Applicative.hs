module Explicit.Classes.Applicative where

import Explicit.Prelude
import qualified Explicit.Classes.Functor as Functor
import qualified Explicit.Classes.Point as Point
import qualified Explicit.Classes.Ap as Ap


data Applicative m =
  Applicative {
    pointInstance :: Point.Point m,
    apInstance :: Ap.Ap m
  }

functorInstance :: Applicative m -> Functor.Functor m
functorInstance =
  Ap.functorInstance . apInstance

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
  Ap.map2 . apInstance

map3 :: Applicative m -> (a -> b -> c -> d) -> (m a -> m b -> m c -> m d)
map3 =
  Ap.map3 . apInstance
