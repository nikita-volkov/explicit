module Explicit.Alternative where

import Explicit.Prelude
import qualified Explicit.Functor as Functor
import qualified Explicit.Applicative as Applicative
import qualified Explicit.Alt as Alt
import qualified Explicit.Empty as Empty
import qualified Explicit.Point as Point


data Alternative m =
  Alternative {
    applicativeInstance :: !(Applicative.Applicative m),
    altInstance :: !(Alt.Alt m),
    emptyInstance :: !(Empty.Empty m)
  }

functorInstance :: Alternative m -> Functor.Functor m
functorInstance =
  Applicative.functorInstance . applicativeInstance

pointInstance :: Alternative m -> Point.Point m
pointInstance =
  Applicative.pointInstance . applicativeInstance

point :: Alternative m -> a -> m a
point =
  Point.point . pointInstance

alt :: Alternative m -> m a -> m a -> m a
alt =
  Alt.alt . altInstance
