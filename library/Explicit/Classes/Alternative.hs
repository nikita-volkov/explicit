module Explicit.Classes.Alternative where

import Explicit.Prelude
import qualified Explicit.Classes.Functor as Functor
import qualified Explicit.Classes.Applicative as Applicative
import qualified Explicit.Classes.Alt as Alt
import qualified Explicit.Classes.Empty as Empty
import qualified Explicit.Classes.Point as Point


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
